/* total type of merch sold per event location */
SELECT 
    md.MerchandiseType,
    ld.LocationCity AS City,
    SUM(ef.MerchandiseSold) AS TotalSalesQuantity,
    SUM(ef.MerchandiseSoldPND) AS TotalSalesPND
FROM 
    EventFact ef
JOIN
    MerchandiseDim md ON ef.MerchandiseID = md.MerchandiseID
JOIN
    EventDim ed ON ef.EventID = ed.EventID
JOIN
    LocationDim ld ON ed.EventID = ld.LocationID
GROUP BY CUBE (
    md.MerchandiseType , ld.LocationCity
);

/* avg game duration to improve spectator experience and scheduling */
SELECT 
    sd.StadiumName, 
    AVG(gf.GameDuration) AS AvgGameDuration,
    AVG(gf.GameDurationOfPause) AS AvgGameDurationOfPause,
    AVG(gf.GameNumberOfPause) AS AvgGamePauses,
    RANK() OVER (ORDER BY AVG(gf.GameDuration) DESC) AS DurationRank
FROM 
    GameFact gf
JOIN 
    StadiumDim sd ON gf.StadiumID = sd.StadiumID
GROUP BY 
    sd.StadiumName;

/* analysis of the net sales and refunds by Merchandise Type */
SELECT 
    md.MerchandiseType, 
    SUM(o.MerchandiseSoldPND) AS TotalSalesPND,
    SUM(r.MerchandiseRefundedPND) AS TotalRefundsPND,
    (SUM(o.MerchandiseSoldPND) - COALESCE(SUM(r.MerchandiseRefundedPND), 0)) AS NetSalesPND
FROM 
    OnlineSalesFact o
JOIN 
    MerchandiseDim md ON o.MerchandiseID = md.MerchandiseID
LEFT JOIN 
    RefundFact r ON md.MerchandiseID = r.MerchandiseID
GROUP BY CUBE (
    md.MerchandiseType)
ORDER BY 
    NetSalesPND DESC;

/* Breakdown of ticket refunds by type and event */
    SELECT 
        td.TicketEvent,
        td.TicketType,
        SUM(rf.TicketsRefundedPND) AS TotalRefundsPND
    FROM 
        RefundFact rf
    JOIN 
        TicketDim td ON rf.TicketID = td.TicketID
    GROUP BY CUBE (
        td.TicketType, td.TicketEvent)
    ORDER BY 
        TotalRefundsPND DESC;

/* Optimising Promotional Spending */
SELECT ed.EventName, 
        pd.PromotionType,
       SUM(ef.PromotionCost) AS TotalPromotionCost, 
       SUM(ef.PromotionRevenue) AS TotalPromotionRevenue,
       SUM(ef.PromotionRevenue) - SUM(ef.PromotionCost) AS TotalProfit
FROM 
    EventFact ef
JOIN 
    EventDim ed ON ef.EventID = ed.EventID
JOIN
    PromotionDim pd ON ef.PromotionID = pd.promotionID
GROUP BY ROLLUP (
    pd.PromotionType, ed.EventName)
ORDER BY 
    TotalPromotionRevenue DESC;

/* Analysis of Game Interruptions by Stadium */
SELECT 
    sd.StadiumName,
    COUNT(gf.GameInterruption) AS TotalInterruptions
FROM 
    GameFact gf
JOIN 
    StadiumDim sd ON gf.StadiumID = sd.StadiumID
GROUP BY CUBE(
        sd.StadiumName)