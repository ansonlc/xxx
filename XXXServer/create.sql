CREATE TABLE UserInfo(
	uid int AUTO_INCREMENT,
	uuid varchar(50),
	crystal int,
	money int,
	energy int,
	userHP int,
	PRIMARY KEY(uid)
);

CREATE TABLE SessionInfo(
	sid int AUTO_INCREMENT,
	uid int,
	skey varchar(50),
	PRIMARY KEY(sid)	
);

CREATE TABLE SkillInfo(
	skillID int,
	uid int,
	skillExp int,
	PRIMARY KEY(skillID, uid)
);

CREATE TABLE MissionInfo(
	missionID int,
	uid int,
	levelScore int,
	PRIMARY KEY(missionID,uid)
);

CREATE TABLE MonsterInfo(
	monsterID int,
	uid int,
	PRIMARY KEY(monsterID,uid)
);