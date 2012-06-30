<div class="container">
	<?php /** @var BootActiveForm $form */
		$form = $this->beginWidget('bootstrap.widgets.BootActiveForm', array(
		    'id'=>'verticalForm',
			'enableClientValidation'=>true,
			'clientOptions'=>array(
				'validateOnSubmit'=>true,
			),				
			'htmlOptions'=>array('class'=>'well span3 offset4'),
			
		)); ?>
		<h1>Platypus <small>Login</small></h1><br>
		<?php echo $form->textFieldRow($model, 'username', array('class'=>'span3')); ?>
		
		<?php echo $form->passwordFieldRow($model, 'password', array('class'=>'span3')); ?>
		
		<?php echo $form->checkboxRow($model, 'rememberMe'); ?>
		<br>
		<?php $this->widget('bootstrap.widgets.BootButton', array('buttonType'=>'submit', 'type' => 'primary', 'size'=>'large', 'icon'=>'ok white', 'label'=>'Login')); ?>
		<?php ?>
	 
	<?php $this->endWidget(); ?>
</div>