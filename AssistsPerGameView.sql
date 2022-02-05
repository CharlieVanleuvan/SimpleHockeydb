select 
	GoalID,
	GoalScorerID,
	FirstAssistID,
	SecondAssistID,
	
	--count(GoalID) as TotalFirstAssists,
	--Count(GoalID) as TotalSecondAssists
from Goals
where FirstAssistID = 16 or SecondAssistID = 16
--group by GoalID,GoalScorerID, FirstAssistID, SecondAssistID

--returns total assists by a player
select 
	count(GoalID) as TotalAssists
from Goals
where FirstAssistID = 11 or SecondAssistID = 11

--sum of games played
select count(GamePlayerID)
from GamePlayers
where PlayerID = 11


select 
	count(GoalID) as TotalAssists,
	A1.FirstName,
	A1.LastName
from Goals
join Players as A1 on Goals.FirstAssistID = A1.PlayerID
join Players as A2 on Goals.SecondAssistID = A2.PlayerID
where FirstAssistID = 11 or SecondAssistID = 11
group by A1.FirstName, A1.LastName

select *
from Goals
where FirstAssistID = 11 or SecondAssistID = 11

select 
	count(GoalID) as TotalAssists
	--A1.FirstName,
	--A1.LastName
from Goals
join Players as A1 on Goals.FirstAssistID = A1.PlayerID
join Players as A2 on Goals.SecondAssistID = A2.PlayerID
where FirstAssistID = 11 or SecondAssistID = 11
--group by A1.FirstName, A1.LastName

select 
	count(GoalID) as TotalAssists
from Goals
where FirstAssistID = 11 or SecondAssistID = 11

select PlayerID
from Players
order by PlayerID desc

--Use a while loop to count total assists per player on the roster
declare @cnt INT = 0
while @cnt < 31 --30 total players on roster
begin
	select 
		count(GoalID) as TotalAssists
	from Goals
	where FirstAssistID = @cnt or SecondAssistID = @cnt
	set @cnt = @cnt +1
end