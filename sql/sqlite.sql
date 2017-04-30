CREATE TABLE IF NOT EXISTS schedules (
   id    INTEGER NOT NULL PRIMARY KEY,
   title  VARCHAR(30),
   date    date,
   body    text
);

CREATE TABLE IF NOT EXISTS images (
   id     INTEGER NOT NULL,
   path    VARCHAR(255),
   type    VARCHAR(30),
   remarks  text
);

CREATE TABLE IF NOT EXISTS sourcetexts (
    id      INTEGER NOT NULL PRIMARY KEY,
    type    VARCHAR(15),
    name    VARCHAR(15),
    date    date,
    body    text,
    owner   VARCHAR(20)
);
