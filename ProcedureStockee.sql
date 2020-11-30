

--À l’aide d’une procédure stockée, insérez 500 stations météorologiques :

BEGIN

 DECLARE nomTemp VARCHAR(50);

 DECLARE latitudeTemp FLOAT;

 DECLARE longitudeTemp FLOAT;

 DECLARE altitudeTemp INT;

 DECLARE estZoneUrbaineTemp BOOLEAN;

 DECLARE idSocieteTemp INT;

 DECLARE i INT;

 SET @i = 0;

 BEGIN

  WHILE @i < 500 DO

   SET @nomTemp = CONV(FLOOR(RAND() * 99999999999999), 20, 36);

   SET @latitudeTemp = 42.5 + RAND() * 8;

   SET @longitudeTemp = -3.5 + RAND() * 10;

   SET @altitudeTemp = RAND() * 1500;

   SET @estZoneUrbaineTemp = IF(RAND() < 0.25, 1, 0);

   SET @idSocieteTemp = (SELECT idSociete FROM Fabricant ORDER BY RAND() LIMIT 1);

   INSERT INTO Station(nom, latitude, longitude, altitude, estZoneUrbaine, idSociete)

   VALUES(@nomTemp, @latitudeTemp, @longitudeTemp, @altitudeTemp, @estZoneUrbaineTemp, @idSocieteTemp);

   SET @i = @i + 1;

  END WHILE;

  SELECT CONCAT(@i, ' stations ajoutées') AS Resultat;

 END;

END

​

--À l’aide d’une procédure stockée, insérez 10 000 relevés :

BEGIN

 DECLARE idStationTemp INT;

 DECLARE idTypeMesureTemp INT;

 DECLARE valeurMinTemp DECIMAL(10,2);

 DECLARE valeurMaxTemp DECIMAL(10,2);

 DECLARE valeurTemp DECIMAL(10,2);

 DECLARE dateHeureTemp datetime;

 DECLARE i INT;

 SET @i = 0;

 BEGIN

  WHILE @i < 10000 DO

   SET @idStationTemp = (SELECT idStation FROM Station ORDER BY RAND() LIMIT 1);

   SET @idTypeMesureTemp = (SELECT idTypeMesure FROM TypeMesure ORDER BY RAND() LIMIT 1);

   SET @valeurMinTemp = (SELECT valeurMin FROM TypeMesure WHERE idTypeMesure = @idTypeMesureTemp);

   SET @valeurMaxTemp = (SELECT valeurMax FROM TypeMesure WHERE idTypeMesure = @idTypeMesureTemp);

   SET @valeurTemp = @valeurMinTemp + RAND() * (@valeurMaxTemp - @valeurMinTemp);

   SET @dateHeureTemp = "2018-10-09" + INTERVAL RAND() * 182 DAY;

   INSERT INTO Releve(dateHeure, valeur, idTypeMesure, idStation)

   VALUES(@dateHeureTemp, @valeurTemp, @idTypeMesureTemp, @idStationTemp);

   SET @i = @i + 1;

  END WHILE;

  SELECT CONCAT(@i, ' relevés ajoutés') AS Resultat;

 END;

END


