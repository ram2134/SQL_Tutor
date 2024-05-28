# Squtor

<b>Note : </b> After following below steps, the prutor system will be connected to xdata-dataGenration. Please note that this is required untill the scripts are not added as the integral part of of prutor codebase.Following this step, Squtor can be successfully configured in the local system. For more information of each scripts involved, please go through the thesis report.

<h2>Steps</h2>

Download the scipt "ARC_Thesis_content_install.sh"

<b>Copy the script to Engine Container</b><br>
docker cp '/path/to/script' container_id:/

<b>Run the script inside engine container</b><br>
bash ARC_Thesis_content_install.sh

<h3>Execute following command inside rdb container terminal</h3><br>
<b>Get MYSQL terminal</b><br>
mysql
<br>
<b>add new attribute to 'problem' table</b><br>
ALTER TABLE its.problem

ADD COLUMN schema_id INT;

<b>create new table to store schema</b><br>
CREATE TABLE `its`.`xdata_schema` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  `schema_file` BLOB,
  'sample_data' BLOB,
  'description' VARCHAR(255)
);

<b>make schema_id in problem table as foreign key</b><br>

ALTER TABLE its.problem

ADD CONSTRAINT 'FOREIGN'

FOREIGN KEY ('schema_id')

REFERENCES 'xdata_schema' ('id')

ON DELETE CASCADE

ON UPDATE CASCADE;


<h3>Execute following commands to NOSQL container terminal</h3><br>

<b>Get mongodb terminal</b><br>
mongo

<b>Get inside table its</b><br>
use its;

<b>Insert configuration for sql</b><br>

db.environments.insertOne({"name" : "sql", "editor_mode" : "sql", "compile" : true, "output_format" : "text", "source_ext" : "sql", "binary_ext" : "out", "cmd_compile" : "/var/www/app/compilers/wrappers/xdata_wrapper.sh %s.sql", "cmd_execute" : "%s", "display" : "text", "link_template" : "", "default" : false });

<b>check whether insertion done for sql</b><br>

db.environments.find();

<b>Unable to connect to postgresql?</b><br>
When running the program,it might happen that the postgresql database server refuses the connection,in this case we might need to edit the "pg_hba.conf" file. Edit the authentication method of
"postgres" user  from 'peer' to 'trust' and 'ipv4' to 'trust'.Restart postgresql using "service postgresql restart".Re run the installation script so that it can now connect to database server and create roles.

After following above steps, SQL facilities will be accessible from prutor interface.

<h2>All other related scripts can be found here: </h2><a href="https://github.com/ram2134/Mtech_thesis_scripts">https://github.com/ram2134/Mtech_thesis_scripts</a>
