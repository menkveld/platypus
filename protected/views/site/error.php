<?php
$this->pageTitle=Yii::app()->name . ' - Error';
$this->breadcrumbs=array(
	'Error',
);
?>
<div class="alert alert-error span6">
	<?php echo "<h1>Error ".$code."</h1>"; ?>
	<br>
	<?php echo CHtml::encode($message); ?>
</div>
