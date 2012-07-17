<?php $this->beginContent('//layouts/main'); ?>
<div class="row-fluid">
	<div id="sidebar" class="span2">
		<div class="well" style="padding: 8px 0;">
		<?php 
			// Sidebar Menu
			$this->widget('bootstrap.widgets.BootMenu', array(
					'type'=>'list',
					'items'=> $this->menu,
			));
		?>
		</div>
	</div><!-- sidebar -->
	<div id="content" class="span10">
		<?php echo $content; ?>
	</div><!-- content -->
</div><!-- row-fluid -->
<?php $this->endContent(); ?>