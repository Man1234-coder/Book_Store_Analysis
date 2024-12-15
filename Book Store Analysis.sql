-- 1.	Return reporting manager names for each employee?

Select * from employee

Select e.first_name,m.first_name As Reporting_manager from employee e
join employee m
on e.reports_to=m.employee_id


-- 2. Which national have min_estimated_sales 100 millions.

Select nationality,min_estimated_sales from books_album
where min_estimated_sales = '100 million';

-- 3. Who is the best author? The one who sells more books will be declared the best author.


Select author,sale_quantity from sales_analysis1
order by sale_quantity desc
limit 1

-- 4. Write a query to find the minimum estimated sales of books written in the English language and the author who sells the most books at the best price.

With Books_quan As(
Select album_id,book,author,sale_quantity,original_language from sales_analysis1 
where original_language= 'English'
) 
Select ba.min_estimated_sales,bq.book,bq.author,bq.sale_quantity,bq.original_language from Books_quan bq
join books_album ba
on ba.album_id=bq.album_id
order by sale_quantity desc
limit 1

-- 5. Write a query to find the editor's name whose total revisions and total entities are greater than 7000, and whose sale quantity is greater than 50.

With Editor_details As(
Select td.id,td.editor_name,td.total_revisions,te.total As total_entities,td.books from total_editors td
join total_entities te
on td.id=te.id
where td.total_revisions>7000 AND
te.total >7000
)
Select ed.editor_name,ed.total_revisions,ed.total_entities,ed.books,sa.sale_quantity from Editor_details ed
join sales_analysis1 sa
on ed.id=sa.album_id
where sale_quantity>50

-- 6. Find books and their authors who wrote in Japanese, and whose total price is greater than the average price of all books.

Select book,author,original_language, sum(Book_Price_In_IndianRupees) As Total_price from sales_analysis1
where original_language= 'Japanese'
group by book,author,original_language
HAVING sum(Book_Price_In_IndianRupees) > (Select avg(Book_Price_In_IndianRupees) from sales_analysis1)

--7. Write a query to return employees mail id’s whose city is Calgary.

Select first_name, email,city 
from employee
where city='Calgary'

--8. Retrieve the book titles and their corresponding authors sorted in alphabetical order by author.

Select book,author 
from sales_analysis1
order by 2

--9. Find the total books price sell by each author in descending order.

Select sum(Book_Price_In_IndianRupees) as Total_Price,author from sales_analysis1
group by author
order by 2 desc

--10.	Retrieve the top 3 best-selling books based on the total quantity sold.

Select sale_quantity,book from sales_analysis1
order by sale_quantity desc
limit 3
