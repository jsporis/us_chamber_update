SELECT

count(*) total_accounts,
sum(job_seekers) job_seekers,
sum(employers) employers,
sum(recruiter) recruiter,
sum(unapproved_employer) unapproved_employer,
sum(employer_request) employer_request,
sum(admin) admin,
sum(no_role_assigned) no_role_assigned

FROM

Reporting_chamber.chamber_users