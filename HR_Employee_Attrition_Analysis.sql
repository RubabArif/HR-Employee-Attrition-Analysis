create database hr_employee_attrition;
use hr_employee_attrition;
select database();
show tables;
use hr_employee_attrition;
select count(*) from hr_employee_attrition_data;
select * from hr_employee_attrition_data
limit 10;
-- total employee--
select count(*) as total_employees from hr_employee_attrition_data;
-- employee who left--
select count(*) as employees_left from hr_employee_attrition_data where Attrition= 'yes';
-- active employee --
select count(*) as active_employees from hr_employee_attrition_data where Attrition= 'No';
-- overall Attrition rate--
select Attrition, count(*) as Employee_count from hr_employee_attrition_data group by Attrition;
select round ((237.0/1470)*100 ,2 )as Attrition_Rate_percentage;
-- department wise analysis--
select Department, count(*) as total_employees, sum(Attrition='yes') as Employees_Left from hr_employee_attrition_data group by Department;
use hr_employee_attrition;
select Department, count(*) as total_employees, round(sum( Attrition='yes')*100.0/ count(*),2) as Attrition_Rate from hr_employee_attrition_data group by Department;
select Department from hr_employee_attrition_data limit 5;
-- job role wise employee attrition --
select JobRole, count(*) as total_employees, sum(Attrition='yes') as Employees_Left, round(sum(Attrition='yes')*100.0/count(*), 2) as Attrition_Rate from hr_employee_attrition_data group by JobRole order by Attrition_Rate desc;
ALTER TABLE hr_employee_attrition_data CHANGE COLUMN `ï»¿Age` Age int;
describe hr_employee_attrition_data;
-- age group wise attrition --
SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and above'
    END AS Age_Group,
    COUNT(*) AS Total_Employees,
    SUM(Attrition = 'Yes') AS Employees_Left,
    ROUND(SUM(Attrition = 'Yes') * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_employee_attrition_data
GROUP BY Age_Group
ORDER BY Age_Group;
-- gender wise employee attrition --
select Gender, count(*) as total_employees, sum(Attrition='yes') as Employees_Left, round(sum(Attrition='yes')* 100.0/count(*),2) as Attrition_Rate from hr_employee_attrition_data group by Gender; 
-- education wise attrition rate-- 
SELECT
    Education,
    COUNT(*) AS Total_Employees,
    SUM(Attrition = 'Yes') AS Employees_Left,
    ROUND(SUM(Attrition = 'Yes') * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_employee_attrition_data
GROUP BY Education
ORDER BY Education;
-- monthly income vs employee attrition --
SELECT
    Attrition,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(MonthlyIncome), 2) AS Average_Monthly_Income
FROM hr_employee_attrition_data
GROUP BY Attrition;
-- overtime vs employees attrition --
SELECT
    OverTime,
    COUNT(*) AS Total_Employees,
    SUM(Attrition = 'Yes') AS Employees_Left,
    ROUND(
        SUM(Attrition = 'Yes') * 100.0 / COUNT(*), 2
    ) AS Attrition_Rate
FROM hr_employee_attrition_data
GROUP BY OverTime;
-- business travel and employees attrition--
SELECT
    BusinessTravel,
    COUNT(*) AS Total_Employees,
    SUM(Attrition = 'Yes') AS Employees_Left,
    ROUND(
        SUM(Attrition = 'Yes') * 100.0 / COUNT(*), 2
    ) AS Attrition_Rate
FROM hr_employee_attrition_data
GROUP BY BusinessTravel
ORDER BY Attrition_Rate DESC;
-- job satisfactiona vs employees attrition --
SELECT
    JobSatisfaction,
    COUNT(*) AS Total_Employees,
    SUM(Attrition = 'Yes') AS Employees_Left,
    ROUND(
        SUM(Attrition = 'Yes') * 100.0 / COUNT(*), 2
    ) AS Attrition_Rate
FROM hr_employee_attrition_data
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;
-- work -life balance vs employee atrition --
select  case when WorkLifeBalance = 1 then 'Bad' 
when WorkLifeBalance = 2 then 'Good'
when WorkLifeBalance = 3 then 'Better'
when WorkLifeBalance = 4 then 'Best' 
 end as Work_Life_Balance_Level,count(*) as total_employees, sum(attrition ='yes') as Employee_Left, round(sum(Attrition='yes')*100.0/ count(*),2) as Attrition_Rate from hr_employee_attrition_data group by WorkLifeBalance order by WorkLifeBalance;
-- year at company vs employee attrition --
SELECT
    CASE
        WHEN YearsAtCompany < 2 THEN 'Less  than 2 Years'
        WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 Years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE 'More than 10 Years'
    END AS Experience_Group,
    COUNT(*) AS Total_Employees,
    SUM(Attrition = 'Yes') AS Employees_Left,
    ROUND(
        SUM(Attrition = 'Yes') * 100.0 / COUNT(*), 2
    ) AS Attrition_Rate
FROM hr_employee_attrition_data
GROUP BY Experience_Group
ORDER BY MIN(YearsAtCompany);
-- year in current role vs employee  attrition --
SELECT
    CASE
        WHEN YearsInCurrentRole < 2 THEN 'Less than 2 Years'
        WHEN YearsInCurrentRole BETWEEN 2 AND 5 THEN '2-5 Years'
        WHEN YearsInCurrentRole BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE 'More than 10 Years'
    END AS Role_Experience_Group,
    COUNT(*) AS Total_Employees,
    SUM(Attrition = 'Yes') AS Employees_Left,
    ROUND(
        SUM(Attrition = 'Yes') * 100.0 / COUNT(*), 2
    ) AS Attrition_Rate
FROM hr_employee_attrition_data
GROUP BY Role_Experience_Group
ORDER BY MIN(YearsInCurrentRole);
-- year since last promotions vs employess attrition --
select case 
when YearsSincelastPromotion < 2 then 'less than 2 year'
when YearsSincelastPromotion between 2 and 5 then '2-5 year'  
when YearsSincelastPromotion between 6 and 10 then '6-10 year'
else 'more then 10 year'
end as promotion_group,
count(*) as total_employees, round(sum(Attrition='yes')* 100.0/ count(*),2) as Attrition_Rate from hr_employee_attrition_data group by Promotion_Group order by min(yearsSinceLastPromotion);
-- final HR summary --
select count(*)  as total_employees, sum(Attrition= 'yes') as employees_left, sum(attrition='no') as active_employess, round(sum(attrition='yes')* 100.0/ count(*),2) as overall_Atttrition_Rate from hr_employee_attrition_data;





