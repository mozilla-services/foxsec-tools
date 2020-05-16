with
total as (select date, count(*) as C from heroku_members group by date),
collab as (select date, count(*) as C from heroku_invalid_collaborator group by date),
service as (select date, count(*) as C from heroku_service_account group by date),
staff as (select date, count(*) as C from heroku_invalid_staff_sso group by date),
non_staff as (select date, count(*) as C from heroku_non_staff group by date)
-- compliant as (select date, total.C - collab.C - staff.C as C)

select total.date,
total.C as "All Acnts",
coalesce(non_staff.C, 0) as "All Collab",
coalesce(staff.C, 0) as "Bad Staff",
coalesce(collab.C, 0) as "Bad Collab",
coalesce(service.C, 0) as "Service Acnts",
coalesce(collab.C, 0) + coalesce(staff.C, 0) as "Non Compliant",
total.C - (coalesce(collab.C, 0) + coalesce(staff.C, 0)) as "Compliant"
-- coalesce(compliant.C, 0) as "Compliant"
from total
left outer join staff on staff.date = total.date
left outer join non_staff on non_staff.date = total.date
left outer join collab on collab.date = total.date
left outer join service on service.date = total.date
where from_iso8601_date(total.date) > (current_date - interval '3' month)
--left outer join compliant on compliant.date = total.date
