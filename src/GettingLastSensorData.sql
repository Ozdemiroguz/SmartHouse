SELECT
    R.RoomID,
    TH.Temperature AS LastTemperature,
    TH.Humidity AS LastHumidity,
    G.Gas AS LastGas,
    F.Fire AS LastFire,
    M.Move AS LastMove
FROM Room AS R
LEFT JOIN (
    SELECT RoomID, Temperature, Humidity
    FROM Temp_Hum
    WHERE (RoomID, Time) IN (
        SELECT RoomID, MAX(Time) AS MaxTime
        FROM Temp_Hum
        GROUP BY RoomID
    )
) AS TH ON R.RoomID = TH.RoomID
LEFT JOIN (
    SELECT RoomID, Gas
    FROM Gas
    WHERE (RoomID, Time) IN (
        SELECT RoomID, MAX(Time) AS MaxTime
        FROM Gas
        GROUP BY RoomID
    )
) AS G ON R.RoomID = G.RoomID
LEFT JOIN (
    SELECT RoomID, Fire
    FROM Fire
    WHERE (RoomID, Time) IN (
        SELECT RoomID, MAX(Time) AS MaxTime
        FROM Fire
        GROUP BY RoomID
    )
) AS F ON R.RoomID = F.RoomID
LEFT JOIN (
    SELECT RoomID, Move
    FROM Move
    WHERE (RoomID, Time) IN (
        SELECT RoomID, MAX(Time) AS MaxTime
        FROM Move
        GROUP BY RoomID
    )
) AS M ON R.RoomID = M.RoomID
WHERE R.RoomID = 7;