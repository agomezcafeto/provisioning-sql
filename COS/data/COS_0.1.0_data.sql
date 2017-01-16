--
-- This source code is the confidential, proprietary information of
-- Cafeto Software S.A.S. here in, you may not disclose such Information,
-- and may only use it in accordance with the terms of the license
-- agreement you entered into with Cafeto Software S.A.S.
--
-- 2016: Cafeto Software S.A.S.
-- All Rights Reserved.
--

INSERT INTO skill_type (skill_type_id, name, description) VALUES (1,'ORG_SKILLS_LABEL', 'Son definidas como aquellas actitudes, habilidades o destrezas que deben poseer los miembros de una organización para el logro de objetivos o metas organizacionales, estas competencias tienen relación directa con las características y valores de la organización y deben estar presentes en todos los cargos de la compañía.');
INSERT INTO skill_type (skill_type_id, name, description) VALUES (2,'LEADERSHIP_SKILLS_LABEL', 'Actitudes, habilidades o destrezas que deben poseer los miembros de una organización que tienen la responsabilidad de liderar procesos o áreas, direccionando el funcionamiento de un equipo de trabajo y velando por la consecución de los objetivos de la organización. Deben aparecer en la mayoría de los cargos tácticos y estratégicos de la compañía.');
INSERT INTO skill_type (skill_type_id, name, description) VALUES (3,'SPECIFIC_SKILLS_LABEL', 'Son las habilidades, actitudes o destrezas que se necesitan para el desarrollo de un rol específico dentro de la compañía, se establecen en el perfil del cargo de acuerdo a la misión, objetivos y responsabilidades de éste. Son competencias críticas que el cargo requiere para su correcta ejecución.');

INSERT INTO business_division (name, description, color, author_username, creation_date) VALUES ('TI', 'Area de tecnologías informáticas.', '#46a3f4', 'deafult','2016-12-09');
INSERT INTO business_division (name, description, color, author_username, creation_date) VALUES ('Mercadeo', 'Area de mercadeo', '#56ff64', 'deafault', '2016-12-09');