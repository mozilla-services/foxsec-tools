with
total as (select date, count(*) as C from heroku_members group by date),
collab as (select date, count(*) as C from heroku_invalid_collaborator group by date),
service as (select date, count(*) as C from heroku_service_account group by date),
staff as (select date, count(*) as C from heroku_invalid_staff_sso group by date)

select total.date, total.C as "All Acnts", staff.C as "Bad Staff", collab.C as "Bad Collab", service.C as "Service Acnts"
from total
join staff on staff.date = total.date
join collab on collab.date = total.date
join service on service.date = total.date