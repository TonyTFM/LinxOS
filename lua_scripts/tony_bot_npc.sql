DELETE FROM `creature_template` WHERE `entry` = 990001;

INSERT INTO `creature_template` (`entry`, `scale`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `unit_class`, `type`) 
VALUES (990001, 1.0, 'Tony Bot', 'LinxOS Commander', 80, 80, 35, 1, 1, 7);
