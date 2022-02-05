/*
	Calculate a goalies Goals Against Average (GAA)
	GAA = Goals Against * 60.00 / Ice Time
*/

select 
	count(GoalsAgainstID) as TotalGoalsAgainst,
	--count(distinct GoalsAgainst.GameID) as GamesPlayed,
	sum(IceTime) as TotalIceTime,
	--(count(GoalsAgainstID) * 60.000/sum(IceTime)) as GAA,
	FirstName,
	LastName
from GoalsAgainst
--from GamePlayers
--join Players on GoalsAgainst.PlayerID = Players.PlayerID
join GamePlayers on GoalsAgainst.PlayerID = GamePlayers.PlayerID
join Players on GamePlayers.PlayerID = Players.PlayerID
group by FirstName,LastName

--return a goalies total goals against
select
	count(GoalsAgainstID) as TotalGoalsAgainst,
	FirstName,
	LastName
from GoalsAgainst
join Players on GoalsAgainst.PlayerID = Players.PlayerID
group by FirstName,LastName

--return a goalies total Ice time
select
	sum(IceTime) as TotalIceTime,
	FirstName,
	LastName
from GamePlayers
join Players on GamePlayers.PlayerID = Players.PlayerID
where Position = 'G'
group by FirstName, LastName

--combine total goals against and ice time ... Does not work
select
	sum(IceTime) as TotalIceTime,
	count(GoalsAgainstID) as TotalGoalsAgainst,
	count(GoalsAgainstID) * 60.00 / sum(IceTime) as GAA,
	FirstName,
	LastName
from GamePlayers
join Players on GamePlayers.PlayerID = Players.PlayerID
join GoalsAgainst on GamePlayers.PlayerID = GoalsAgainst.PlayerID
where Position = 'G'
group by FirstName, LastName

--create a function to return a players GAA
go
drop function dbo.CalculateGAA
go

go
create function dbo.CalculateGAA(@firstname varchar(30),@lastname varchar(30))
returns numeric(18,2) as
begin
	declare @goalsagainst numeric(18,2)
	declare @icetime numeric(18,2)

	--calculate goals against
	select @goalsagainst = count(GoalsAgainstID)
	from GoalsAgainst
	join Players on GoalsAgainst.PlayerID = Players.PlayerID
	where FirstName = @firstname and LastName = @lastname

	--calculate ice time
	select @icetime = sum(IceTime)
	from GamePlayers
	join Players on GamePlayers.PlayerID = Players.PlayerID
	where FirstName = @firstname and LastName = @lastname
	
	return (@goalsagainst * 60 / @icetime )
end
go


--List of goalie names
Select FirstName,LastName
from Players
Where Position = 'G'

/* Goalies are:
	Arman Tink
	Fraze Stayt
	Bevin Officer
	Jarib Schottli
*/
select dbo.CalculateGAA('Arman','Tink')
select dbo.CalculateGAA('Fraze','Stayt')
select dbo.CalculateGAA('Bevin','Officer')
select dbo.CalculateGAA('Jarib','Schottli')



--return a goalies total goals against
select
	count(GoalsAgainstID) as TotalGoalsAgainst,
	FirstName,
	LastName
from GoalsAgainst
join Players on GoalsAgainst.PlayerID = Players.PlayerID
where FirstName = 'Fraze' and LastName = 'Stayt'
group by FirstName,LastName

--return a goalies total Ice time
select
	sum(IceTime) as TotalIceTime,
	FirstName,
	LastName
from GamePlayers
join Players on GamePlayers.PlayerID = Players.PlayerID
where FirstName = 'Fraze' and LastName = 'Stayt'
group by FirstName, LastName