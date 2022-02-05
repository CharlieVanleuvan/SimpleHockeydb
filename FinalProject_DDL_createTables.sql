/*
	DDL Statements for Hockey Team Database

	Author: Charles Vanleuvan
	December 2019
	IST 659 Database Admin. Projects
*/
/*
	Drop the tables first if they exist
	Drop in reverse order of creation to avoid any problems with foreign key references
	Drop in this order:
	Goals
	Penalties
	GoalsAgainst
	GamePlayers
	Games
	Opponents
	Players
*/

/*
	drop table code....
	drop table if exists

*/
drop table Goals
drop table Penalties
drop table GoalsAgainst
drop table GamePlayers
drop table Games
drop table Opponents
drop table Players
/*
	Create tables
	create strong entities first
	In this order:
	Players
	Opponents
	Games
	GamePlayers
	GoalsAgainst
	Penalties
	Goals
*/
--Players Table
create table Players (
	PlayerID int identity primary key,
	FirstName varchar(30) not null,
	LastName varchar(50) not null,
	Email varchar(75) not null,
	StreetAddress varchar(50) not null,
	City varchar(30) not null,
	StateOrProvince varchar(20) not null,
	ZIPcode varchar(10) not null,
	PhoneNumber varchar(20) not null,
	Position varchar(2) not null,
	Number varchar(2) not null,
	SchoolYear varchar(2) not null,
	constraint U1_Players unique (Email)
	)

--Opponents Table
create table Opponents (
	OpponentID int identity primary key,
	TeamName varchar(30) not null,
	SchoolName varchar(100) not null,
	HomeRinkTown varchar(50) not null
	)

--Games Table
create table Games (
	GameID int identity primary key,
	GameDate datetime not null,
	HomeOrAway varchar(4) not null,
	Result varchar(4) not null,
	OpponentID int foreign key references Opponents(OpponentID)
	)

--GamePlayers Table
create table GamePlayers (
	GamePlayerID int identity primary key,
	PlayerID int foreign key references Players(PlayerID),
	GameID int foreign key  references Games(GameID),
	IceTime int not null default(0),
	constraint U1_GamePlayers unique (PlayerID,GameID)
	)

--GoalsAgainst table
create table GoalsAgainst (
	GoalsAgainstID int identity primary key,
	GameID int foreign key references Games(GameID),
	PlayerID int foreign key references Players(PlayerID)
	)

--Penalties Table
create table Penalties (
	PenaltyID int identity primary key,
	PenaltyType varchar(30) not null,
	Severity varchar(30) not null,
	GameID int foreign key references Games(GameID),
	PlayerID int foreign key references Players(PlayerID)
	)

--Needed to alter Penalties Table to make Severity an int
alter table Penalties
	alter column Severity int

--Goals Table
create table Goals(
	GoalID int identity primary key,
	GoalType varchar(20) not null,
	GoalScorerID int foreign key references Players(PlayerID),
	GameID int foreign key references Games(GameID),
	FirstAssistID int foreign key references Players(PlayerID),
	SecondAssistID int foreign key references Players(PlayerID),
	constraint U1_UniqueAssisters check (FirstAssistID != SecondAssistID)
	)

