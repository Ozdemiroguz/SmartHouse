SELECT R.RoomName, AVG(G.Gas) AS AvgGasLevel
FROM Room R
JOIN Gas G ON R.RoomID = G.RoomID
GROUP BY R.RoomName
HAVING AvgGasLevel = (
    SELECT MAX(AvgGas)
    FROM (
        SELECT R.RoomName, AVG(G.Gas) AS AvgGas
        FROM Room R
        JOIN Gas G ON R.RoomID = G.RoomID
        GROUP BY R.RoomName
    ) AS RoomAvgGasLevels
);
