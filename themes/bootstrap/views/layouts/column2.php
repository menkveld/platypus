<?php $this->beginContent('//layouts/main'); ?>
<div class="row-fluid">
	<div id="sidebar" class="span3">
	<?php
		$this->beginWidget('zii.widgets.CPortlet', array(
			'title'=>'Operations',
		));
		$this->widget('zii.widgets.CMenu', array(
			'items'=>$this->menu,
			'htmlOptions'=>array('class'=>'operations'),
		));
		$this->endWidget();
	?>
	</div><!-- sidebar -->
	<div id="content" class="span9">
		<?php echo $content; ?>
	</div><!-- content -->
</div><!-- row-fluid -->
<?php $this->endContent(); ?>