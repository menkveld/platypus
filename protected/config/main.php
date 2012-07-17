<?php
// Setup path aliases for the Parallel library
Yii::setPathOfALias('server_root', 'C:\wamp\www');
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
		// User Module
		'user' => array(
			'class' => 'parallel\yii\modules\user\UserModule',
		),			
	),

	// application components
	'components'=>array(
		'user'=>array(
			// enable cookie-based authentication
			'allowAutoLogin'=>false,	// Auto Login not allowed for security reasons
		),

		// Pretty URL's in path format
		'urlManager'=>array(
			'urlFormat'=>'path',
			'showScriptName' => false,
			'rules' => array(
				// REST Interface - TBD: Create Rules class to keep these centrally
				array('<controller>/rest/read', 'pattern' => 'rest/<controller:\w+>/<id:\w+>', 'verb' => 'GET'),
				array('<controller>/rest/read<subset>', 'pattern' => 'rest/<controller:\w+>/<id:\w+>/<subset:\w+>', 'verb' => 'GET'),
				array('<controller>/rest/update<subset>', 'pattern' => 'rest/<controller:\w+>/<id:\w+>/<subset:\w+>', 'verb' => 'POST'),
					
				// Route request to controllers to the default controller without the need to have /default/ in the url
				// site must be excluded as the only controller not contained in a module
				array('site/<action>', 'pattern' => 'site/<action:\w+>', 'verb' => 'GET'),
				array('<controller>/default/<action>', 'pattern' => '<controller:\w+>/<action:\w+>', 'verb' => 'GET'),
			),				
		),

		// Connect to the database
		'db'=>array(
			'connectionString' => 'mysql:host=localhost;dbname=platypus',
			'emulatePrepare' => true,
			'username' => 'parallel',
			'password' => 'dogfood2',
			'charset' => 'utf8',
		),

		// Error handling
		'errorHandler'=>array(
			// use 'site/error' action to display errors
			'errorAction'=>'site/error',
		),
			
		// System Message Logging
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
			// In order to better control what is loaded, CSS files will be included
			// by the layout
			'coreCss' => false,
			'responsiveCss' => false,
			'yiiCss' => false,
			'enableJS' => true,
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
		'adminEmail'=>'admin@platypus-platform.com',
		'majorVersion' => 0,
		'minorVersion' => 1,
		'codeStatus' => 'alpha',
		'slogan' => 'Systemize or DIE!',				
	),
);