USE mysql_main_climsoft_db_v4;LOAD DATA INFILE 'climsoft_v4_sample_obs_data.csv' IGNORE INTO TABLE observationFinal FIELDS TERMINATED BY ',' (stationId,elementId,obsLevel,obsDatetime,obsValue,flag);