%Created by RM on 2019.03.06 for ECON 632
%Part II: Programming

%Dependencies: llplan

%%
%%%%%%%%
%1. Import Data
%%%%%%%%

data = csvread('/Users/russellmorton/Desktop/Coursework/Winter 2019/ECON 632/Problem Sets/Temp/insurance_data_mod.csv',1,0);
indiv_id = data(:,1);
choice_sit = data(:,2);
year = data(:,5);
years_enrolled = data(:,6);
age = data(:,7);
income = data(:,9);
risk = data(:,10);
tool = data(:,11);
premium = data(:,12);
coverage = data(:,13);
quality = data(:,14);
num_plans = data(:,19);
plan_goes_away = data(:,22);
chose_min = data(:,26);
switch_plan = data(:,23);
same_plan = data(:,24);
premium_income_q1 = data(:,35);
premium_income_q2 = data(:,38);
premium_income_q3 = data(:,41);
premium_income_q4 = data(:,44);
quality_risk_q1 = data(:,36);
quality_risk_q2 = data(:,39);
quality_risk_q3 = data(:,42);
quality_risk_q4 = data(:,45);
coverage_risk_q1 =  data(:,37);
coverage_risk_q2 =  data(:,40);
coverage_risk_q3 =  data(:,43);
coverage_risk_q4 =  data(:,46);

%%
%%%%%
%Turn into variables and datasets for use later in likelihood
%%%%%

choice = data(:,3) ==  data(:,4); 
first_year = years_enrolled == 1;

prem_income = horzcat(premium_income_q1, premium_income_q2, premium_income_q3, premium_income_q4);
qual_risk = horzcat(quality_risk_q1, quality_risk_q2, quality_risk_q3, quality_risk_q4);
cov_risk = horzcat(coverage_risk_q1, coverage_risk_q2, coverage_risk_q3, coverage_risk_q4);

prob_vars = horzcat(tool, num_plans, risk, age, income, years_enrolled, chose_min, first_year, plan_goes_away, switch_plan);
plan_vars = horzcat(coverage, quality, same_plan);
    

%%
%%%%%
%Set Starting Values for All Parameters 
%%%%

alpha_start = [0 0 0 0];
beta_start = [0 0 0 0];
gamma_start = [0 0 0 0];
delta_start = [0 0 0];

psi_start = [0 0 0 0 0 0 0 0 0 0 0];
mu_start = 1;

x0 = horzcat(alpha_start,beta_start,gamma_start,delta_start,psi_start,mu_start);

%%
%%%%%
%MLE
%%%%%

options  =  optimset('GradObj','off','LargeScale','off','Display','iter','TolFun',1e-14,'TolX',1e-14,'Diagnostics','on','MaxFunEvals',200000,'MaxIter',1000); 
[estimateplan] = fminunc(@(x)llplan(x,choice_sit,choice,prem_income,qual_risk,cov_risk,prob_vars,plan_vars),x0,options);


%%
csvwrite('/Users/russellmorton/Desktop/Coursework/Winter 2019/ECON 632/Problem Sets/Temp/params_hat.csv',estimateplan);
