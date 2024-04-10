--establecemos la integridad referencial
PRAGMA foreign_keys = ON; 

--creamos las tablas
DROP TABLE IF EXISTS person;
CREATE TABLE person (
        email TEXT PRIMARY KEY, --todas las claves primarias están indexadas
        name TEXT NOT NULL,
        code TEXT NOT NULL
);

DROP TABLE IF EXISTS mobile;
CREATE TABLE mobile (
        serial TEXT PRIMARY KEY,
        model TEXT UNIQUE NOT NULL,  --no hace falta índice, ya está indexado al ser único
        price REAL NOT NULL
);

DROP TABLE IF EXISTS buys;
CREATE TABLE buys (
        email TEXT,
        serial TEXT,
        date DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')),
        PRIMARY KEY(email, serial, date),
        FOREIGN KEY(email) REFERENCES person(email) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(serial) REFERENCES mobile(serial) ON DELETE CASCADE ON UPDATE CASCADE
);
DROP TABLE IF EXISTS historial;
CREATE TABLE historial (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        serial TEXT,
	leaving_date DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime'))
);
DROP TABLE IF EXISTS updatePrice;
CREATE TABLE updatePrice (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	serial TEXT NOT NULL,
	model TEXT NOT NULL,
	old_price REAL NOT NULL,
	new_price REAL NOT NULL,
	update_date DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime'))
);
--tabla para guardar datos adicionales cunado se adquiere un móvil
--registro: id autoincrementable, serial y la fecha de adquisición (actual)
DROP TABLE IF EXISTS datos_extra_movil;
CREATE TABLE datos_extra_movil (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	serial TEXT NOT NULL,
	date DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime'))
);

--añadir índices sobre code y model
DROP INDEX IF EXISTS cod;
CREATE INDEX cod ON person(code);
DROP INDEX IF EXISTS mod;
CREATE INDEX mod ON mobile(model);

--creamos vista sobre unión de las tres tablas
DROP VIEW IF EXISTS show_data;
CREATE VIEW show_data AS SELECT name, model, price, date FROM person, mobile, buys WHERE person.email = buys.email AND mobile.serial = buys.serial;

--creamos un trigger de borrado
DROP TRIGGER IF EXISTS borrado;
CREATE TRIGGER borrado BEFORE DELETE
ON buys
BEGIN
        INSERT INTO historial (email, serial) VALUES
        (old.email, old.serial);
END;

--creamos un trigger de actualización
DROP TRIGGER IF EXISTS savePrice;
CREATE TRIGGER savePrice AFTER UPDATE
ON mobile
BEGIN
	INSERT INTO updatePrice (serial, model, old_price, new_price) VALUES
	(old.serial, old.model, old.price, new.price);
END;
--creamos un trigger de insercción para rellenar la tabla datos_extra_movil
DROP TRIGGER IF EXISTS extra;
CREATE TRIGGER extra AFTER INSERT
ON mobile
BEGIN
	INSERT INTO datos_extra_movil (serial) VALUES (new.serial);
END;


--insertamos los datos
--usuarios:
insert into person (name, email, code) values ('Cyndi Aronowitz', 'caronowitz0@geocities.jp', '23689');
insert into person (name, email, code) values ('Bianca Groucutt', 'bgroucutt1@prweb.com', '23818');
insert into person (name, email, code) values ('Clerissa MacKegg', 'cmackegg2@bluehost.com', '23067');
insert into person (name, email, code) values ('Donnajean Lemanu', 'dlemanu3@springer.com', '23785');
insert into person (name, email, code) values ('Idell Charlesworth', 'icharlesworth4@ameblo.jp', '23949');
insert into person (name, email, code) values ('Clarette Iacovozzo', 'ciacovozzo5@irs.gov', '23417');
insert into person (name, email, code) values ('Veda Vardie', 'vvardie6@issuu.com', '23207');
insert into person (name, email, code) values ('Towny Hayth', 'thayth7@shinystat.com', '23581');
insert into person (name, email, code) values ('Dacey Iorio', 'diorio8@edublogs.org', '23027');
insert into person (name, email, code) values ('Lorenza Covolini', 'lcovolini9@indiegogo.com', '23313');
insert into person (name, email, code) values ('Frankie Gregore', 'fgregorea@cyberchimps.com', '23632');
insert into person (name, email, code) values ('Elka Pragnall', 'epragnallb@youku.com', '23942');
insert into person (name, email, code) values ('Milena Colclough', 'mcolcloughc@livejournal.com', '23384');
insert into person (name, email, code) values ('Doe Readshaw', 'dreadshawd@ezinearticles.com', '23915');
insert into person (name, email, code) values ('Tallie Lowman', 'tlowmane@dailymail.co.uk', '23207');
insert into person (name, email, code) values ('Sibyl Devita', 'sdevitaf@mediafire.com', '23438');
insert into person (name, email, code) values ('Mead Witch', 'mwitchg@netlog.com', '23214');
insert into person (name, email, code) values ('Janet Biskupek', 'jbiskupekh@yellowpages.com', '23531');
insert into person (name, email, code) values ('Shari Brodie', 'sbrodiei@independent.co.uk', '23170');
insert into person (name, email, code) values ('Gabriela Margerison', 'gmargerisonj@indiegogo.com', '23797');
insert into person (name, email, code) values ('Madison Saxelby', 'msaxelbyk@jiathis.com', '23892');
insert into person (name, email, code) values ('Antonie Radoux', 'aradouxl@berkeley.edu', '23330');
insert into person (name, email, code) values ('Townie Cartmael', 'tcartmaelm@sphinn.com', '23120');
insert into person (name, email, code) values ('Peter Negri', 'pnegrin@aboutads.info', '23705');
insert into person (name, email, code) values ('Timofei Ugo', 'tugoo@tuttocitta.it', '23525');
insert into person (name, email, code) values ('Petronella Girdwood', 'pgirdwoodp@lycos.com', '23028');
insert into person (name, email, code) values ('Mada Pierucci', 'mpierucciq@chicagotribune.com', '23077');
insert into person (name, email, code) values ('Tawnya Cheavin', 'tcheavinr@irs.gov', '23105');
insert into person (name, email, code) values ('Nertie Rowesby', 'nrowesbys@quantcast.com', '23423');
insert into person (name, email, code) values ('Brennen Steenson', 'bsteensont@shinystat.com', '23537');
insert into person (name, email, code) values ('Tatiana Edgin', 'tedginu@cloudflare.com', '23137');
insert into person (name, email, code) values ('Gardener Gunter', 'ggunterv@xrea.com', '23389');
insert into person (name, email, code) values ('Lanny Whartonby', 'lwhartonbyw@desdev.cn', '23229');
insert into person (name, email, code) values ('Gaven Matteucci', 'gmatteuccix@qq.com', '23705');
insert into person (name, email, code) values ('Earl Kellitt', 'ekellitty@multiply.com', '23780');
insert into person (name, email, code) values ('Neall Tunney', 'ntunneyz@webs.com', '23752');
insert into person (name, email, code) values ('Hobard Deex', 'hdeex10@nasa.gov', '23652');
insert into person (name, email, code) values ('Amargo Catterill', 'acatterill11@reuters.com', '23414');
insert into person (name, email, code) values ('Barbra Reeve', 'breeve12@oakley.com', '23621');
insert into person (name, email, code) values ('Vittoria Harkin', 'vharkin13@mapy.cz', '23717');
insert into person (name, email, code) values ('Jeramey Verne', 'jverne14@state.tx.us', '23993');
insert into person (name, email, code) values ('Francklin Giraudoux', 'fgiraudoux15@tiny.cc', '23654');
insert into person (name, email, code) values ('Irma Yosifov', 'iyosifov16@blogger.com', '23683');
insert into person (name, email, code) values ('Tally Dorning', 'tdorning17@unesco.org', '23191');
insert into person (name, email, code) values ('Benedikta Watman', 'bwatman18@de.vu', '23050');
insert into person (name, email, code) values ('Eydie Keitley', 'ekeitley19@linkedin.com', '23746');
insert into person (name, email, code) values ('Evangelia Pozer', 'epozer1a@free.fr', '23682');
insert into person (name, email, code) values ('Leandra Alcorn', 'lalcorn1b@economist.com', '23278');
insert into person (name, email, code) values ('Rickard Van Brug', 'rvan1c@fc2.com', '23899');
insert into person (name, email, code) values ('Granger Gyde', 'ggyde1d@digg.com', '23371');
insert into person (name, email, code) values ('Hashim McCreadie', 'hmccreadie1e@noaa.gov', '23494');
insert into person (name, email, code) values ('Abelard Caldera', 'acaldera1f@networksolutions.com', '23419');
insert into person (name, email, code) values ('Anett Amberger', 'aamberger1g@prlog.org', '23991');
insert into person (name, email, code) values ('Arlina Penner', 'apenner1h@ocn.ne.jp', '23666');
insert into person (name, email, code) values ('Dionysus Jenicke', 'djenicke1i@salon.com', '23832');
insert into person (name, email, code) values ('Marlon Willcot', 'mwillcot1j@msn.com', '23269');
insert into person (name, email, code) values ('Glad Rigglesford', 'grigglesford1k@technorati.com', '23085');
insert into person (name, email, code) values ('Lacee Brotherheed', 'lbrotherheed1l@mozilla.org', '23042');
insert into person (name, email, code) values ('Lucy Shorrock', 'lshorrock1m@guardian.co.uk', '23430');
insert into person (name, email, code) values ('Lacy Mayho', 'lmayho1n@google.nl', '23354');
insert into person (name, email, code) values ('Daryle Pull', 'dpull1o@mozilla.com', '23888');
insert into person (name, email, code) values ('Elisha Kaesmans', 'ekaesmans1p@exblog.jp', '23173');
insert into person (name, email, code) values ('Lindon Royse', 'lroyse1q@constantcontact.com', '23681');
insert into person (name, email, code) values ('Guillemette Matusson', 'gmatusson1r@ustream.tv', '23103');
insert into person (name, email, code) values ('Augusto Tittershill', 'atittershill1s@washington.edu', '23577');
insert into person (name, email, code) values ('Werner Bedbury', 'wbedbury1t@vkontakte.ru', '23533');
insert into person (name, email, code) values ('Alix Hunte', 'ahunte1u@howstuffworks.com', '23892');
insert into person (name, email, code) values ('Doug Packer', 'dpacker1v@dailymail.co.uk', '23032');
insert into person (name, email, code) values ('Sargent Goldine', 'sgoldine1w@360.cn', '23822');
insert into person (name, email, code) values ('Hester Bumpass', 'hbumpass1x@clickbank.net', '23840');
insert into person (name, email, code) values ('Robby Lapping', 'rlapping1y@auda.org.au', '23654');
insert into person (name, email, code) values ('Lorin Ruthven', 'lruthven1z@de.vu', '23548');
insert into person (name, email, code) values ('Abeu Kalinke', 'akalinke20@globo.com', '23614');
insert into person (name, email, code) values ('Chere Gitthouse', 'cgitthouse21@deliciousdays.com', '23673');
insert into person (name, email, code) values ('Abramo Devin', 'adevin22@ucoz.ru', '23106');
insert into person (name, email, code) values ('Russell Gossage', 'rgossage23@narod.ru', '23247');
insert into person (name, email, code) values ('Moselle Tewkesberry', 'mtewkesberry24@privacy.gov.au', '23480');
insert into person (name, email, code) values ('Sylvan Sineath', 'ssineath25@rakuten.co.jp', '23622');
insert into person (name, email, code) values ('Brandy Mateus', 'bmateus26@amazonaws.com', '23285');
insert into person (name, email, code) values ('Desdemona Nesbit', 'dnesbit27@parallels.com', '23246');
insert into person (name, email, code) values ('Gustavo Hefferon', 'ghefferon28@mozilla.com', '23741');
insert into person (name, email, code) values ('Filia Halleday', 'fhalleday29@bbc.co.uk', '23055');
insert into person (name, email, code) values ('Jamil Grassi', 'jgrassi2a@prnewswire.com', '23376');
insert into person (name, email, code) values ('Stevena Ivery', 'sivery2b@whitehouse.gov', '23843');
insert into person (name, email, code) values ('Abbe Berget', 'aberget2c@merriam-webster.com', '23352');
insert into person (name, email, code) values ('Alfie Enstone', 'aenstone2d@opera.com', '23846');
insert into person (name, email, code) values ('Jaquelin Dmitriev', 'jdmitriev2e@nps.gov', '23416');
insert into person (name, email, code) values ('Nathanil Rolf', 'nrolf2f@drupal.org', '23184');
insert into person (name, email, code) values ('Sib Stowers', 'sstowers2g@de.vu', '23946');
insert into person (name, email, code) values ('Amity Trayton', 'atrayton2h@microsoft.com', '23738');
insert into person (name, email, code) values ('Cleo Erasmus', 'cerasmus2i@parallels.com', '23971');
insert into person (name, email, code) values ('Mareah Lorenzetto', 'mlorenzetto2j@ocn.ne.jp', '23674');
insert into person (name, email, code) values ('Ranique Norrie', 'rnorrie2k@dagondesign.com', '23332');
insert into person (name, email, code) values ('Drugi Gorcke', 'dgorcke2l@sourceforge.net', '23728');
insert into person (name, email, code) values ('Stanly MacGilmartin', 'smacgilmartin2m@netscape.com', '23070');
insert into person (name, email, code) values ('Michal Pennetta', 'mpennetta2n@ovh.net', '23338');
insert into person (name, email, code) values ('Clarie Royall', 'croyall2o@github.io', '23780');
insert into person (name, email, code) values ('Almeta Abrahart', 'aabrahart2p@sfgate.com', '23796');
insert into person (name, email, code) values ('Candis Commins', 'ccommins2q@ow.ly', '23710');
insert into person (name, email, code) values ('Greta Velti', 'gvelti2r@spiegel.de', '23957');

--móviles
insert into mobile (model, serial, price) values ('Huawei G5000', 'MOB78022', 637.97);
insert into mobile (model, serial, price) values ('Samsung Galaxy S5 Duos', 'MOB56294', 736.4);
insert into mobile (model, serial, price) values ('Sewon SGD-102', 'MOB01470', 951.47);
insert into mobile (model, serial, price) values ('Realme X2 Pro', 'MOB58472', 976.51);
insert into mobile (model, serial, price) values ('Apple iPad 2 Wi-Fi + 3G', 'MOB33306', 574.02);
insert into mobile (model, serial, price) values ('Samsung Star 3 s5220', 'MOB87446', 655.77);
insert into mobile (model, serial, price) values ('alcatel OT 565', 'MOB13211', 961.75);
insert into mobile (model, serial, price) values ('LG K30', 'MOB33087', 244.96);
insert into mobile (model, serial, price) values ('Lava Iris 505', 'MOB65848', 619.37);
insert into mobile (model, serial, price) values ('LG Lucid2 VS870', 'MOB99857', 274.59);
insert into mobile (model, serial, price) values ('Samsung M210S Wave2', 'MOB78162', 497.99);
insert into mobile (model, serial, price) values ('Motorola RAZR2 V9', 'MOB48041', 837.85);
insert into mobile (model, serial, price) values ('Motorola E680', 'MOB98556', 813.84);
insert into mobile (model, serial, price) values ('Icemodel Rock Bold', 'MOB76968', 143.41);
insert into mobile (model, serial, price) values ('Meizu PRO 5 mini', 'MOB37187', 322.25);
insert into mobile (model, serial, price) values ('Philips Xenium X519', 'MOB60340', 405.15);
insert into mobile (model, serial, price) values ('Wiko Sunny3 Plus', 'MOB59147', 304.92);
insert into mobile (model, serial, price) values ('alcatel Pop 4S', 'MOB22511', 404.54);
insert into mobile (model, serial, price) values ('BLU Touch Book 7.0', 'MOB75188', 625.41);
insert into mobile (model, serial, price) values ('Samsung Z300', 'MOB26704', 218.54);
insert into mobile (model, serial, price) values ('Motorola ATRIX HD MB886', 'MOB52406', 705.64);
insert into mobile (model, serial, price) values ('Samsung Galaxy J6', 'MOB03774', 536.88);
insert into mobile (model, serial, price) values ('Huawei nova 7 Pro 5G', 'MOB10380', 900.14);
insert into mobile (model, serial, price) values ('i-mate SPL', 'MOB67357', 743.68);
insert into mobile (model, serial, price) values ('Plum Signal', 'MOB36747', 478.42);
insert into mobile (model, serial, price) values ('BLU Electro', 'MOB16803', 913.56);
insert into mobile (model, serial, price) values ('Nokia X1-00', 'MOB40939', 558.14);
insert into mobile (model, serial, price) values ('Samsung i7410', 'MOB01517', 301.29);
insert into mobile (model, serial, price) values ('Oppo R1 R829T', 'MOB42876', 687.82);
insert into mobile (model, serial, price) values ('Motorola MPx220', 'MOB27794', 553.4);
insert into mobile (model, serial, price) values ('LG Optimus L5 E610', 'MOB08405', 171.69);
insert into mobile (model, serial, price) values ('Infinix Hot 5 Lite', 'MOB84575', 816.18);
insert into mobile (model, serial, price) values ('HP Pre 3 CDMA', 'MOB38529', 958.43);
insert into mobile (model, serial, price) values ('Nokia Asha 300', 'MOB51629', 429.83);
insert into mobile (model, serial, price) values ('Asus Zenpad 8.0 Z380KL', 'MOB00083', 215.13);
insert into mobile (model, serial, price) values ('Maxwest Nitro 55M', 'MOB46088', 544.18);
insert into mobile (model, serial, price) values ('Philips 760', 'MOB07859', 615.11);
insert into mobile (model, serial, price) values ('Lava A79', 'MOB07103', 247.25);
insert into mobile (model, serial, price) values ('Samsung Galaxy A52', 'MOB68629', 319.17);
insert into mobile (model, serial, price) values ('Infinix S4', 'MOB10917', 963.18);
insert into mobile (model, serial, price) values ('Sendo X', 'MOB41918', 683.58);
insert into mobile (model, serial, price) values ('BLU Jenny', 'MOB26274', 643.68);
insert into mobile (model, serial, price) values ('LG G7030', 'MOB68052', 266.35);
insert into mobile (model, serial, price) values ('NEC N100', 'MOB95350', 145.93);
insert into mobile (model, serial, price) values ('Celkon C609', 'MOB85382', 473.38);
insert into mobile (model, serial, price) values ('XOLO One HD', 'MOB26256', 629.9);
insert into mobile (model, serial, price) values ('Gionee Ctrl V3', 'MOB14326', 935.06);
insert into mobile (model, serial, price) values ('LG KC910 Renoir', 'MOB05399', 195.66);
insert into mobile (model, serial, price) values ('Lenovo S560', 'MOB15932', 285.33);
insert into mobile (model, serial, price) values ('Google Pixel 4a 5G', 'MOB02533', 470.3);
insert into mobile (model, serial, price) values ('Philips I928', 'MOB77509', 465.0);
insert into mobile (model, serial, price) values ('Motorola V186', 'MOB62478', 951.09);
insert into mobile (model, serial, price) values ('Celkon A90', 'MOB57887', 465.51);
insert into mobile (model, serial, price) values ('ZTE Memo', 'MOB93758', 943.64);
insert into mobile (model, serial, price) values ('Kyocera E4600', 'MOB60573', 710.2);
insert into mobile (model, serial, price) values ('Vodafone 226', 'MOB20002', 925.62);
insert into mobile (model, serial, price) values ('Nokia E63', 'MOB29414', 567.73);
insert into mobile (model, serial, price) values ('Sony Ericsson Xperia active', 'MOB91286', 311.4);
insert into mobile (model, serial, price) values ('alcatel OT-706', 'MOB38009', 261.15);
insert into mobile (model, serial, price) values ('LeEco Le Max 2', 'MOB26352', 913.21);
insert into mobile (model, serial, price) values ('Lava A32', 'MOB34680', 267.09);
insert into mobile (model, serial, price) values ('i-mate JAQ4', 'MOB84766', 358.0);
insert into mobile (model, serial, price) values ('Amoi A320', 'MOB49278', 515.92);
insert into mobile (model, serial, price) values ('Nokia 150', 'MOB53306', 460.09);
insert into mobile (model, serial, price) values ('ZTE nubia X6', 'MOB55048', 989.34);
insert into mobile (model, serial, price) values ('BLU Grand Energy', 'MOB24286', 173.9);
insert into mobile (model, serial, price) values ('Sendo X2', 'MOB26507', 769.41);
insert into mobile (model, serial, price) values ('LG A230', 'MOB48736', 218.43);
insert into mobile (model, serial, price) values ('Yezz Andy 5E3', 'MOB69972', 592.68);
insert into mobile (model, serial, price) values ('Nokia N70', 'MOB22505', 615.81);
insert into mobile (model, serial, price) values ('Lenovo K3', 'MOB34400', 222.13);
insert into mobile (model, serial, price) values ('Philips Xenium 9@9k', 'MOB94248', 102.74);
insert into mobile (model, serial, price) values ('Pantech PG-6100', 'MOB17236', 731.04);
insert into mobile (model, serial, price) values ('Siemens A65', 'MOB51499', 632.43);
insert into mobile (model, serial, price) values ('BenQ-Siemens EL71', 'MOB99711', 410.83);
insert into mobile (model, serial, price) values ('Samsung Galaxy Tab 4 10.1', 'MOB32939', 439.92);
insert into mobile (model, serial, price) values ('Tel.Me. T918', 'MOB54305', 656.04);
insert into mobile (model, serial, price) values ('HTC Desire 626', 'MOB92985', 884.47);
insert into mobile (model, serial, price) values ('Sony Xperia M2 dual', 'MOB13854', 101.34);
insert into mobile (model, serial, price) values ('Celkon C349', 'MOB79363', 804.39);
insert into mobile (model, serial, price) values ('Samsung B6520 Omnia PRO 5', 'MOB99708', 839.16);
insert into mobile (model, serial, price) values ('verykool SL5560 Maverick Pro', 'MOB71841', 776.82);
insert into mobile (model, serial, price) values ('Google Pixel 2 XL', 'MOB70071', 973.44);
insert into mobile (model, serial, price) values ('Sagem my411X', 'MOB58791', 248.02);
insert into mobile (model, serial, price) values ('Huawei nova 5i Pro', 'MOB59145', 739.84);
insert into mobile (model, serial, price) values ('Telit G80', 'MOB24164', 896.23);
insert into mobile (model, serial, price) values ('Samsung Galaxy A32 5G', 'MOB40620', 857.2);
insert into mobile (model, serial, price) values ('Sony CMD Z5', 'MOB44705', 814.32);
insert into mobile (model, serial, price) values ('BlackBerry 7100v', 'MOB63655', 572.5);
insert into mobile (model, serial, price) values ('Panasonic P66', 'MOB01558', 395.32);
insert into mobile (model, serial, price) values ('Wiko Sunny Max', 'MOB46483', 329.77);
insert into mobile (model, serial, price) values ('Nokia 5110', 'MOB93442', 459.85);
insert into mobile (model, serial, price) values ('Micromax Canvas Nitro 2 E311', 'MOB03336', 896.57);
insert into mobile (model, serial, price) values ('Samsung Galaxy J Max', 'MOB11313', 533.86);
insert into mobile (model, serial, price) values ('Samsung P270', 'MOB96284', 173.04);
insert into mobile (model, serial, price) values ('vivo U20', 'MOB97782', 942.14);
insert into mobile (model, serial, price) values ('Samsung Galaxy A3 Duos', 'MOB16765', 677.27);
insert into mobile (model, serial, price) values ('Samsung T729 Blast', 'MOB67610', 643.42);
insert into mobile (model, serial, price) values ('Motorola Edge', 'MOB45594', 193.47);
insert into mobile (model, serial, price) values ('ZTE V81', 'MOB23455', 822.84);

--compras
insert into buys(serial, email, date) values ('MOB78022', 'lcovolini9@indiegogo.com','2024-03-29 13:17:29');
insert into buys(serial, email, date) values ('MOB13211', 'ekellitty@multiply.com', '2023-03-29 13:17:29');
insert into buys(serial, email, date) values ('MOB68052', 'ggyde1d@digg.com', '2024-12-29 13:17:29');
insert into buys(serial, email, date) values ('MOB53306', 'caronowitz0@geocities.jp', '2024-03-1 13:17:29');
insert into buys(serial, email, date) values ('MOB02533', 'nrolf2f@drupal.org', '2020-03-29 13:17:29');
insert into buys(serial, email, date) values ('MOB94248', 'gvelti2r@spiegel.de', '2024-7-29 13:17:29');
insert into buys(serial, email, date) values ('MOB55048', 'lcovolini9@indiegogo.com', '2024-8-29 13:17:29');
insert into buys(serial, email, date) values ('MOB78022', 'atrayton2h@microsoft.com','2024-03-31 13:17:29' );
insert into buys(serial, email, date) values ('MOB13854', 'rlapping1y@auda.org.au', '2022-03-29 13:17:29');
insert into buys(serial, email, date) values ('MOB01558', 'ssineath25@rakuten.co.jp', '2021-03-29 13:17:29');
insert into buys(serial, email, date) values ('MOB48736', 'jdmitriev2e@nps.gov', '2024-02-29 13:17:29');
insert into buys(serial, email, date) values ('MOB51629', 'msaxelbyk@jiathis.com', '2024-05-29 13:17:29');
insert into buys(serial, email, date) values ('MOB24164', 'ekellitty@multiply.com', '2024-08-29 13:17:29');
insert into buys(serial, email, date) values ('MOB11313', 'ekellitty@multiply.com', '2024-11-29 13:17:29');
insert into buys(serial, email, date) values ('MOB45594', 'acaldera1f@networksolutions.com', '2024-03-11 13:17:29');
insert into buys(serial, email, date) values ('MOB23455', 'atrayton2h@microsoft.com', '2021-01-21 13:17:29');
























