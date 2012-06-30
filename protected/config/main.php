<?php
// Setup path aliases for the Parallel library
Yii::setPathOfALias('server_root', 'D:\wamp\www');
Yii::setPathOfAlias('parallel', Yii::getPathOfAlias('server_root.parallel'));
Yii::setPathOfAlias('vendors', Yii::getPathOfAlias('parallel.vendors'));

// This is the main Web application configuration. Any writable
// CWebApplication properties can be configured here.
return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
	'name'=>'Platypus',
	'theme' => 'bootstrap',	// Twitter Bootstap Theme

	// preloading 'log' component
	'preload'=>array('log', 		// System loggin component
					 'bootstrap'	// Twitter Bootstrap CSS Framework Components
			),

	// autoloading model and component classes
	'import'=>array(
		'application.models.*',
		'application.components.*',
	),

	'modules'=>array(
		// Person Module
		'person' => array(
			'class' => 'parallel\yii\modules\person\PersonModule',
		),
	),

	// application components
	'components'=>array(
		'user'=>array(
			// enable cookie-based authentication
			'allowAutoLogin'=>true,
		),

		// URL's in path format
		'urlManager'=>array(
			'urlFormat'=>'path',
			'showScriptName' => false,
		),

		// Connect to the database
		'db'=>array(
			'connectionString' => 'mysql:host=localhost;dbname=platypus',
			'emulatePrepare' => true,
			'username' => 'parallel',
			'password' => 'dogfood2',
			'charset' => 'utf8',
		),

		'errorHandler'=>array(
			// use 'site/error' action to display errors
			'errorAction'=>'site/error',
		),
		'log'=>array(
			'class'=>'CLogRouter',
			'routes'=>array(
				array(
					'class'=>'CFileLogRoute',
					'levels'=>'error, warning',
				),
				array(
					'class'=>'CWebLogRoute',
					'levels'=>'error, warning, info, trace',
					'showInFireBug' => true,
					'categories' => 'parallel.*',
				),
			),
		),
		
		/*
		 * Twitter Bootstrap CSS framework - http://twitter.github.com/bootstrap/
		 */
		'bootstrap'=>array(
			'class' => 'parallel.yii.extensions.bootstrap.components.Bootstrap',		
		),

		/*
		 * Create auto loader for Zend Framework classes
		*/
		'zendAutoloader'=>array(
				'class'=>'parallel\yii\config\ZendFrameworkLoader',
		),
		
		/*
		 * Create the Parallel config component to be able to read/write system configuration
		*/
		'config'=>array(
				'class'=>'parallel\yii\config\Config',
		),			
	),

	// application-level parameters that can be accessed
	// using Yii::app()->params['paramName']
	'params'=>array(
		// this is used in contact page
		'adminEmail'=>'webmaster@example.com',
		'majorVersion' => 0,
		'minorVersion' => 1,
		'codeStatus' => 'alpha',
		'slogan' => 'Go out and sell your stuff!',				
	),
);