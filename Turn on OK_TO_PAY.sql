select count(*) from ps_pay_earnings a
where exists (select 'X' from ps_pay_calendar b
               where b.company = a.company
                 and b.paygroup = a.paygroup
                 and b.pay_end_dt = a.pay_end_dt
                 and b.run_id = 'T235')
/                 
update ps_pay_earnings a
set ok_to_pay = 'Y'
where exists (select 'X' from ps_pay_calendar b
               where b.company = a.company
                 and b.paygroup = a.paygroup
                 and b.pay_end_dt = a.pay_end_dt
                 and b.run_id = 'T235')
/                 
commit
/                 