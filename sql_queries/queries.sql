-- Top 5 Brands by Receipts Scanned for the Most Recent Month
SELECT b.name, COUNT(r._id) AS receipts_scanned
FROM Receipts r
JOIN ReceiptItems ri ON r._id = ri.receiptId
JOIN Brands b ON ri.barcode = b.barcode
WHERE DATE_TRUNC('month', r.dateScanned) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY b.name
ORDER BY receipts_scanned DESC
LIMIT 5;

-- Average Spend for Receipts with 'Accepted' or 'Rejected' Status
SELECT rewardsReceiptStatus, AVG(totalSpent) AS average_spend
FROM Receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY rewardsReceiptStatus;

-- Total Number of Items Purchased for 'Accepted' or 'Rejected' Receipts
SELECT rewardsReceiptStatus, SUM(purchasedItemCount) AS total_items_purchased
FROM Receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY rewardsReceiptStatus;

-- Brand with the Most Spend Among Users Created in the Past 6 Months
SELECT b.name, SUM(r.totalSpent) AS total_spend
FROM Receipts r
JOIN Users u ON r.userId = u._id
JOIN ReceiptItems ri ON r._id = ri.receiptId
JOIN Brands b ON ri.barcode = b.barcode
WHERE u.createdDate >= NOW() - INTERVAL '6 months'
GROUP BY b.name
ORDER BY total_spend DESC
LIMIT 1;
