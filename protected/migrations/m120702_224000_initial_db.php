<?php

class m120702_224000_initial_db extends parallel\yii\components\migrations\DbMigration
{
	public function up()
	{
		// Execute the script to create the initial state of the database
		return $this->executeSQLScript(\Yii::app()->basePath.'/migrations/scripts/initial_db.sql');
	}

	public function down()
	{
		echo "m120702_224000_initial_db does not support migration down.\n";
		return false;
	}

	/*
	// Use safeUp/safeDown to do migration with transaction
	public function safeUp()
	{
	}

	public function safeDown()
	{
	}
	*/
}