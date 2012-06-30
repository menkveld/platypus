<?php

return CMap::mergeArray(
	require(dirname(__FILE__).'/main.php'),
	array(
		'components'=>array(
			'fixture'=>array(
				'class'=>'system.test.CDbFixtureManager',
			),
		// Connect to the database
		'db'=>array(
			'connectionString' => 'mysql:host=localhost;dbname=platypus',
			'emulatePrepare' => true,
			'username' => 'parallel',
			'password' => 'dogfood2',
			'charset' => 'utf8',
		),
	)
);
