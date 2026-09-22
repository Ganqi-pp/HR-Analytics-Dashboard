-- ==========================================
-- 项目：拼多多HR管培生SSC方向作品集 - HR数据数仓
-- 数据库：hr_analytics
-- 层级：ODS-DWD-DWS 三层离线数仓
-- ==========================================

-- 1. ODS层：原始数据层（全量导入原始CSV，不做任何修改）
CREATE TABLE ods_hr_employee (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

-- 2. DWD层：数据清洗层（存放Python清洗后的数据）
CREATE TABLE dwd_hr_employee_detail (
    Age INT,
    Attrition INT,
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    NumCompaniesWorked INT,
    OverTime INT,
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT,
    TenureGroup VARCHAR(50),
    IncomeBand VARCHAR(50)
);

-- 3. DWS层：数据汇总层（为PowerBI看板提供聚合数据）
CREATE TABLE dws_dept_summary AS
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS attrition_count,
    ROUND(SUM(Attrition) / COUNT(*), 4) AS attrition_rate,
    ROUND(AVG(MonthlyIncome), 2) AS avg_salary,
    SUM(OverTime) AS overtime_count,
    ROUND(SUM(OverTime) / COUNT(*), 4) AS overtime_rate,
    ROUND(AVG(YearsAtCompany), 1) AS avg_tenure
FROM dwd_hr_employee_detail
GROUP BY Department;