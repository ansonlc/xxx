CREATE TABLE UserInfo(
	uid int AUTO_INCREMENT,
	uuid varchar(50),
	crystal int,
	money int,
	energy int,
	PRIMARY KEY(uid)
)

CREATE TABLE SessionInfo(
	sid int AUTO_INCREMENT,
	uid int,
	skey varchar(50),
	PRIMARY KEY(sid)	
)

CREATE TABLE BattleSkill{
	skillID int,
	skillQuality int,
	skillName int,
	PRIMARY KEY(skillid)
}