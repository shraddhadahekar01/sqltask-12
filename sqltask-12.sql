select * from sales

create table report_table(
	product_id int primary key,
	total_sales int,
	sum_of_profit int
)

select * from report_table

create or replace function update_report_table()
returns trigger as $$
declare
total_sales int;
sum_of_profit int;
begin
select sum(sales),sum(profit) into total_sales, sum_of_profit
from sales
where product_id=new.product_id;
if not found then
insert into report_table(product_id,total_sales,sum_of_profit)values(new.product_id,total_sales,sum_of_profit);
end if;
return new;
end;
$$ language plpgsql

create trigger report_table
after insert on sales for each row
execute function update_report_table()

insert into sales(order_line,order_id,order_date,ship_date,ship_mode,customer_id,product_id,sales,quantity,discount,profit)
values(995,'CA-2014-117639','2014-05-25','2014-04-25','Standard Class','MW-18235','OFF-BI-10003925',2715.93,7,0,1276.4871)

select * from sales
select * from report_table