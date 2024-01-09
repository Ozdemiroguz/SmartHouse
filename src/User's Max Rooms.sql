SELECT U.UserID, U.Name, U.Surname, COUNT(R.RoomID) AS NumberOfRooms
FROM User U
LEFT JOIN Room R ON U.UserID = R.UserID
GROUP BY U.UserID, U.Name, U.Surname
HAVING NumberOfRooms = (
    SELECT MAX(RoomCount)
    FROM (
        SELECT U.UserID, COUNT(R.RoomID) AS RoomCount
        FROM User U
        LEFT JOIN Room R ON U.UserID = R.UserID
        GROUP BY U.UserID
    ) AS UserRoomCounts
);