/*
	Create a function to return the wins and losses
*/


select count(*) from Games where Result = 'Win'
select count(*) from Games where Result = 'Loss'


--Create Function that takes Games table as the input
go
drop function dbo.TeamRecord
go
go
create function dbo.TeamRecord()
returns @ReturnTable table(Wins Int, Losses Int) as
begin
	declare @wins int
	declare @losses int

	--calculate wins
	select
		@wins = count(GameID)
	from Games
	where Result = 'Win'

	--calculate losses
	select
		@losses = count(GameID)
	from Games
	where Result = 'Loss'
	
	--Add wins and losses to @ReturnTable
	insert into @ReturnTable (Wins, Losses) 
	values (@wins, @losses)

	return
end
go

--Test function
select * from dbo.TeamRecord()
