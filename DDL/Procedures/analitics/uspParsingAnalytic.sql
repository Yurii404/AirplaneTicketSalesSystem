use booking_system;

drop procedure if exists uspParsingAnalytic;

delimiter $$
create procedure uspParsingAnalytic(in analyticJson json)
proc_body:
begin

    
 start transaction;
     drop table if exists tempJson;
     create temporary table tempJson
     (
        city      		varchar(50),
        airplane        	varchar(50),

        periodStartDate 	datetime,
        periodEndDate   	datetime,  

        showNullRows    	bool,
        showNullCols    	bool
     );

     insert into tempJson (city, airplane, periodStartDate, periodEndDate, showNullRows, showNullCols)
         select js.city,
                js.airplane,
                js.periodStartDate,
                js.periodEndDate,
                js.showNullRows,
                js.showNullCols
         from json_table(analyticJson, '$' columns 
                                 (
									periodStartDate 	datetime 	path '$.periodStartDate',
                                     periodEndDate   	datetime 	path '$.periodEndDate',
                                     showNullRows    	bool     	path '$.showNullRows',
                                     showNullCols    	bool     	path '$.showNullCols',
                                     nested path '$.cities[*]' columns
                                     (
										city varchar(50) path '$'
									
                                     ),
                                     nested path '$.airplanes[*]' columns
                                     (
                                         airplane varchar(50) path '$'
                                     )
                                 )
                        ) js;

	if not exists (select *
                    from tempJson
                    where (tempJson.periodStartDate < tempJson.periodEndDate))
     then
         select 'Error. Transaction aborted.';
         rollback;
         leave proc_body;
     end if;

	-- create temporary table for Category1 data
    drop table if exists tempCities;
    create temporary table tempCities
    (
        city varchar(100)
    );

	 -- create temporary table for Category2 data
    drop table if exists tempAirplanes;
    create temporary table tempAirplanes
    (
        airplane varchar(100)
    );

	 -- create temporary table for raw data (it's data for objects connecting with used categouries without grouping and agregating) for analytic
    drop table if exists tempRawData;
    create temporary table tempRawData
    (
        city    	 varchar(100),
        airplane     varchar(100)
    );
    
    set @start_date := (select distinct periodStartDate from tempJson);
	set @end_date := (select distinct periodEndDate from tempJson);
    
     -- add Category1 data from tempJson table
    if exists (select tempJson.city
               from tempJson inner join 
                    cities on (tempJson.city = cities.`name`))
    then
        -- add category data from tempJson table for data existing in database
        insert into tempCities (city)
        select distinct tempJson.city
        from tempJson inner join 
             cities on (tempJson.city = cities.`name`);
    else
        -- if not category data in json then add all category data from database    
        insert into tempCities (city)
        select cities.`name`
        from cities;
    end if;
    
    
    -- add Category2 data from tempJson table
    if exists (select tempJson.airplane
               from tempJson inner join 
                    airplane on (tempJson.airplane = airplane.`name`))
    then
        -- add category data from tempJson table for data existing in database
        insert into tempAirplanes (airplane)
        select distinct tempJson.airplane
        from tempJson inner join 
             airplane on (tempJson.airplane = airplane.`name`);
    else
        -- if not category data in json then add all category data from database    
        insert into tempAirplanes (airplane)
        select airplane.`name`
        from airplane;
    end if;
    
    
	if (select distinct tempJson.showNullRows from tempJson)
		then
			
			select "Pam pam";
	
		else
	
		insert into tempRawData (city, airplane)
			select tempCities.city,
				tempAirplanes.airplane
			from  ticket 
				inner join tempCities
				inner join tempAirplanes
                inner join ticket_statuses 	on ticket_statuses.`name` = "booked" 
												OR ticket_statuses.`name` = "paid"
				inner join cities 			on tempCities.city = cities.`name`
				inner join airport 			on (airport.city_id = cities.city_id)
				inner join flight			on (flight.departure_airport_id = airport.airport_id) 
												OR (flight.arrival_airport_id = airport.airport_id)
				inner join airplane 		on (airplane.airplane_id = flight.airplane_id) 
												AND (airplane.`name` = tempAirplanes.airplane)
			where (flight.datetime_departure between @start_date and @end_date) 
												AND ticket.flight_id = flight.flight_id 
												AND ticket.status_id = ticket_statuses.status_id;

            
		
	end if;
    
    select * from tempRawData;
    

end$$
delimiter ;
