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
			
				-- insert data for all categories values
			insert into tempRawData (city, airplane)
			select cities.`name`,
				   tempAirplanes.airplane
			from tempAirplanes left outer join
				 (ticket inner join flight on ticket.flight_id = flight.flight_id
                    inner join airplane on airplane.airplane_id = flight.airplane_id
                    inner join airport on flight.departure_airport_id = airport.airport_id
												OR flight.arrival_airport_id = airport.airport_id
                    inner join cities on cities.city_id = airport.city_id
                    inner join ticket_statuses on ticket_statuses.status_id = ticket.status_id
                    inner join tempCities on tempCities.city = cities.`name`) on (tempAirplanes.airplane = airplane.`name`)
			where (flight.datetime_departure between @start_date and @end_date 
					AND ticket_statuses.`name` in ("booked", "paid") 
                    OR cities.city_id is null);
	
	else
	
		insert into tempRawData (city, airplane)
			select cities.`name`,
				   tempAirplanes.airplane
			from tempAirplanes inner join
				 (ticket inner join flight on ticket.flight_id = flight.flight_id
                    inner join airplane on airplane.airplane_id = flight.airplane_id
                    inner join airport on flight.departure_airport_id = airport.airport_id
												OR flight.arrival_airport_id = airport.airport_id
                    inner join cities on cities.city_id = airport.city_id
                    inner join ticket_statuses on ticket_statuses.status_id = ticket.status_id
                    inner join tempCities on tempCities.city = cities.`name`) on (tempAirplanes.airplane = airplane.`name`)
			where (flight.datetime_departure between @start_date and @end_date 
					AND ticket_statuses.`name` in ("booked", "paid"));
	end if;
    
     set @ResultQuery := '(select tempRawData.airplane as ''Airplane name'',
                                          {ResultSubquery}
                                   from tempRawData
                                   group by tempRawData.airplane)
                                 ';

            set @ResultSubquery      := '';
       
            
            if (select distinct tempJson.showNullCols from tempJson)
            then
                -- prepare columns with all values from Category2 data
					 select GROUP_CONCAT(CONCAT('COUNT(if(tempRawData.city in (''',
                                           tempCities.city,
                                           '''), tempRawData.city, null)) as ''',
                                           tempCities.city,
                                           ''''))
					into @ResultSubquery
					from tempCities;

            else
                select GROUP_CONCAT(CONCAT('COUNT(if(tempRawData.city in (''',
                                           tempCities.city,
                                           '''), tempRawData.city, null)) as ''',
                                           tempCities.city,
                                           ''''))
				into @ResultSubquery
                from tempCities
                where (tempCities.city in (select distinct tempRawData.city
											from tempRawData
											where (tempRawData.city is not null)));

            end if;

            set @ResultQuery := replace(@ResultQuery, '{ResultSubquery}',      @ResultSubquery);
            
            prepare stmt from @ResultQuery;
            execute stmt;
            deallocate prepare stmt;

    -- successful end of transaction (if used transaction start)
    commit;
    

end$$
delimiter ;
