/*
	Team that was scored on the most

*/


--join opponent ID gameID and goalID

go
create view GoalsScoredOnOpponents as
select
	SchoolName,
	TeamName,
	GameDate,
	Result,
	count(GoalID) as GoalsScored
from Games
join Opponents on Games.OpponentID = Opponents.OpponentID
join Goals on Games.GameID = Goals.GameID
group by SchoolName,TeamName,GameDate,Result
go

select * from GoalsScoredOnOpponents order by GoalsScored desc