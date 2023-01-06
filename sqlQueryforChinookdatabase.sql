/* Query1 - query used for first insight */

WITH t1 AS (
	SELECT
		COUNT(Invoice.InvoiceId) Purchases, Invoice.BillingCity, Album.Title
	FROM Invoice 
		JOIN InvoiceLine  ON InvoiceLine.Invoiceid = Invoice.InvoiceId
		JOIN Track  ON Track.TrackId = InvoiceLine.Trackid
		JOIN Album ON Album.AlbumId = Track.AlbumId
	GROUP BY Invoice.BillingCity
	ORDER BY  Purchases DESC
	)

SELECT t1.*
FROM t1
JOIN (
	SELECT total(Purchases) AS TotalPurchases, BillingCity
	FROM t1
	GROUP BY BillingCity
	)t2
ON t1.BillingCity = t2.BillingCity
WHERE t1.Purchases = t2.TotalPurchases;



/* Query2 - query used for second insight */

SELECT count(Track.TrackId) TimePlayed, MediaType.MediaTypeId, MediaType.Name
FROM MediaType INNER JOIN Track on MediaType.MediaTypeId = Track.MediaTypeId 
group by MediaType.Name
ORDER by TimePlayed DESC;

/* Query3 - query used for Third insight */

SELECT  Album.Title, sum(Track.UnitPrice)as sales, Artist.Name
FROM Album
JOIN Track  ON Track.AlbumId = Album.AlbumId
JOIN Artist on Artist.ArtistId = Album.ArtistId

GROUP by Artist.Name
ORDER by sales DESC ;

/* Query4 - query used for fourth insight */

SELECT Total(Customer.SupportRepId) Support, Employee.FirstName,Employee.LastName
FROM Employee INNER JOIN Customer on Employee.EmployeeId = Customer.SupportRepId

group by Employee.FirstName,Employee.LastName
ORDER by Support DESC;



