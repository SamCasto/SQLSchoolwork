--Asg 5 #1
use MyGuitarShop
go

declare @ProductCount int;
select @ProductCount = count(ProductID)
	from Products
if @ProductCount >= 7 
	begin
	print 'The number of products is greater than or equal to seven';
	end
else --@ProductCount is < 7
	begin
	print 'The number of products is less than seven';
	end
go

-- #2
declare @ProductCount int, @AverageListPrice money;
select @ProductCount = COUNT(ProductID), @AverageListPrice = AVG(ListPrice)
	from Products
if @ProductCount >= 7
	begin
	print 'The number of products is ' + convert(varchar, @ProductCount, 1)+ ' and the average list price is $'+ convert(varchar, @AverageListPrice, 1);
	end
else
	begin
	print 'The number of products is less than seven';
	end
go

-- #3
declare @Counter int, @SameOperators int;
set @Counter = 1;
while ( @Counter <=10)
	begin
		if (10 % @Counter = 0 and 20 % @Counter = 0)
			begin
				print @Counter;
			end
		set @Counter = @Counter + 1;
	end
go

-- #4
begin try
	insert into Categories
	values('Guitars');
	print 'SUCCESS: Record was inserted.'
	
end try
begin catch
	print 'FAILURE: Record was not inserted'
	print 'ERROR ' + convert(varchar, ERROR_NUMBER(), 1) + ': ' + convert(varchar, ERROR_MESSAGE(), 1);
end catch;
go





