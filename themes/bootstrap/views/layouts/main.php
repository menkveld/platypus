<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title><?php echo CHtml::encode($this->pageTitle); ?></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">
	
		<!-- Le styles -->
	    <link href="<?php echo Yii::app()->theme->baseUrl; ?>/css/bootstrap-theme.css" rel="stylesheet">
		<link href="<?php echo Yii::app()->theme->baseUrl; ?>/css/bootstrap.min.css" rel="stylesheet">
		<link href="<?php echo Yii::app()->theme->baseUrl; ?>/css/bootstrap-responsive.css" rel="stylesheet">
	
		<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
	
		<!-- Le fav and touch icons -->
		<link rel="shortcut icon" href="<?php echo Yii::app()->request->baseUrl; ?>/images/favicon.ico">
		<link rel="apple-touch-icon" href="<?php echo Yii::app()->request->baseUrl; ?>/images/apple-touch-icon.png">
		<link rel="apple-touch-icon" sizes="72x72" href="<?php echo Yii::app()->request->baseUrl; ?>/images/apple-touch-icon-72x72.png">
		<link rel="apple-touch-icon" sizes="114x114" href="<?php echo Yii::app()->request->baseUrl; ?>/images/apple-touch-icon-114x114.png">
		<link rel="apple-touch-icon" sizes="144x144" href="<?php echo Yii::app()->request->baseUrl; ?>/images/apple-touch-icon-144x144.png">
	</head>
	<body>
		<?php $this->widget('bootstrap.widgets.BootNavbar', array(
			'fluid'=>true,
		    'brand'=>CHtml::encode(Yii::app()->name),
		    'brandUrl'=>'#',
		    'collapse'=>true, // requires bootstrap-responsive.css
		    'items'=>array(
		        array(
		            'class'=>'bootstrap.widgets.BootMenu',
		            'items'=>array(
		                array('label'=>'Home', 'url'=>'#', 'active'=>true),
		                array('label'=>'Link', 'url'=>'#'),
		                array('label'=>'Dropdown', 'url'=>'#', 'items'=>array(
		                    array('label'=>'Action', 'url'=>'#'),
		                    array('label'=>'Another action', 'url'=>'#'),
		                    array('label'=>'Something else here', 'url'=>'#'),
		                    '---',
		                    array('label'=>'NAV HEADER'),
		                    array('label'=>'Separated link', 'url'=>'#'),
		                    array('label'=>'One more separated link', 'url'=>'#'),
		                )),
		            ),
		        ),
		    	array(
		            'class'=>'bootstrap.widgets.BootMenu',
		            'htmlOptions'=>array('class'=>'pull-right'),
		            'items'=>array(
		            	'---',
		                array('label'=>Yii::app()->user->name, 'url'=>'#', 'items'=>array(
		                    array('label'=>'Profile', 'url'=>'#'),
		                    array('label'=>'Settings', 'url'=>'#'),
		                		'---',
		                    array('label'=>'Log out', 'url'=>array('/site/logout')),
		                )),
		            ),
		        ),
		    	'<form class="navbar-search pull-right" action=""><input type="text" class="search-query span2" placeholder="Search"></form>',	
		    ),
		)); ?>
		<?php $this->widget('bootstrap.widgets.BootBreadcrumbs', array(
    		'links'=>$this->breadcrumbs,
		)); ?>

		<div class="container-fluid">
			<?php echo $content; ?>
		</div>
		
		<footer class="footer"style=" margin-left: auto; margin-right: auto; text-align: center;">
				<hr>
				<p style="margin-top: -15px"><h6>Copyright &copy; <?php echo date('Y'); ?> by <a href="mailto:anton.menkveld@gmail.com">Anton R. Menkveld</a> | <?php echo Yii::powered(); ?></h6></p>
		</footer>
	</body>
</html>