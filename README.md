# Business-Degree-Database
This database covers the top five industries that students with business administration degree choose to work for.

The database include five columns of data: Industry Name, Population Count of the industry, Population Growth (in percentages), Average wage of the industry, wage Growth (in percentages.)
  
Triggers 

The first triggers is tr_TFPContent_ins, which is a trigger for inserting data into all tables at once.  
  The second trigger is tr_TFPContent_del, which is a trigger for viewing the content that was deleted by the user.

Stored Procedures

First stored procedure is wage_lookup, which allows user to lookup the wage and the wage growth of a specific industry based on the industryID. 
  
  Second stored procedure is popularity_lookup, which allows user to lookup the population and the population growth of a specific industry based on the industryID.

Views

First View is v_all_wage, which allows user to view the wage and the wage growth of all industries included in the data base.

Second View is v_all_population, which allows user to view the population count and the population growth of all industries included in the data base.
