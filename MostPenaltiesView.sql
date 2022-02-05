/*
	Create a view to show who has the most penalty minutes
*/

go
create view MostPenalties as
	select 
		sum(Severity) as PenaltiesInMinutes,
		FirstName,
		LastName
	from Penalties
	join Players on Penalties.PlayerID = Players.PlayerID
	group by FirstName, LastName
go

select *
from MostPenalties
order by PenaltiesInMinutes desc
