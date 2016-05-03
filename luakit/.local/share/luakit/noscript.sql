PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE by_domain (
    id INTEGER PRIMARY KEY,
    domain TEXT,
    enable_scripts INTEGER,
    enable_plugins INTEGER
);
INSERT INTO "by_domain" VALUES(4,'bookmarks',1,0);
INSERT INTO "by_domain" VALUES(5,'downloads',1,0);
INSERT INTO "by_domain" VALUES(6,'adblock',1,0);
INSERT INTO "by_domain" VALUES(7,'duckduckgo.com',1,0);
INSERT INTO "by_domain" VALUES(9,'history',1,0);
INSERT INTO "by_domain" VALUES(13,'help',1,0);
INSERT INTO "by_domain" VALUES(14,'www.youtube.com',1,0);
INSERT INTO "by_domain" VALUES(15,'m.youtube.com',1,0);
INSERT INTO "by_domain" VALUES(16,'www.imdb.com',1,0);
INSERT INTO "by_domain" VALUES(17,'logout.hu',1,0);
INSERT INTO "by_domain" VALUES(18,'www.openmailbox.org',1,0);
INSERT INTO "by_domain" VALUES(19,'privoxy.org',1,0);
INSERT INTO "by_domain" VALUES(20,'github.com',1,0);
INSERT INTO "by_domain" VALUES(21,'m.facebook.com',1,0);
INSERT INTO "by_domain" VALUES(23,'whatnext.eu',1,0);
INSERT INTO "by_domain" VALUES(24,'plus.google.com',1,0);
INSERT INTO "by_domain" VALUES(31,'www.reddit.com',1,0);
INSERT INTO "by_domain" VALUES(32,'itcafe.hu',1,0);
INSERT INTO "by_domain" VALUES(34,'www.blu-ray.com',1,0);
INSERT INTO "by_domain" VALUES(37,'accounts.google.com',1,0);
INSERT INTO "by_domain" VALUES(38,'mail.google.com',1,0);
INSERT INTO "by_domain" VALUES(40,'letterboxd.com',1,0);
INSERT INTO "by_domain" VALUES(41,'docs.google.com',1,0);
INSERT INTO "by_domain" VALUES(42,'encrypted.google.com',1,0);
INSERT INTO "by_domain" VALUES(45,'alpha.wallhaven.cc',1,0);
INSERT INTO "by_domain" VALUES(49,'www.deviantart.com',1,0);
INSERT INTO "by_domain" VALUES(51,'drive.google.com',1,0);
INSERT INTO "by_domain" VALUES(52,'markdownlivepreview.com',1,0);
INSERT INTO "by_domain" VALUES(53,'www.mostszol.hu',1,0);
COMMIT;
