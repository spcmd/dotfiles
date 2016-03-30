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
COMMIT;
