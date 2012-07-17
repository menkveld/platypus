<?php
// Setup path aliases for the Parallel library
Yii::setPathOfALias('server_root', 'C:\wamp\www');
Yii::setPathOfAlias('parallel', Yii::getPathOfAlias('server_root.parallel'));
Yii::setPathOfAlias('vendors', Yii::getPathOfAlias('parallel.vendors'));

// This is the configuration for yiic console application.
// Any writable CConsoleApplication properties can be configured here.
return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
	'name'=>'My Console Application',
	// application components
	'components'=>array(
		'db'=>array(
			'connectionString' => 'mysql:host=localhost;dbname=platypus',
			'emulatePrepare' => true,
			'username' => 'parallel',
			'password' => 'dogfood2',
			'charset' => 'utf8',
		),
	),
);