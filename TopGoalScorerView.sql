/*
	Create view to see who is leading in goal scoring
*/

go
drop view TopGoalScorer
go


/*
	Create view to see who is leading in goal scoring
*/
go
create view TopGoalScorer as
select
	count(GoalID) as TotalGoals,
	FirstName,
	LastName
from Goals join Players on Goals.GoalScorerID = Players.PlayerID
group by FirstName,LastName
go

/*
	Query for R to pull top 5 goal scorers to mimic NHL dashboard
*/
select *
from TopGoalScorer
order by TotalGoals desc