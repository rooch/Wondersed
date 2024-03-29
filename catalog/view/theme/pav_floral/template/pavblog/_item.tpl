<div class="blog-item">
	<div class="image clearfix">
		<?php if( $blog['thumb'] && $config->get('cat_show_image') )  { ?>
		<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" align="middle"/>
		<?php } ?>
	</div>	
<div class="row">
	<div class="blog-meta col-lg-4 col-md-4 col-sm-6 col-xs-12">
		<ul>
		<?php if( $config->get('cat_show_created') ) { ?>
		<li class="created">
			<span class="icon-time ">   <?php echo $this->language->get("text_created");?> :</span>
			<?php echo date("d-M-Y",strtotime($blog['created']));?>
		</li>
		<?php } ?>
		<?php if( $config->get('cat_show_author') ) { ?>
		<li class="author"><span class="icon-pencil">   <?php echo $this->language->get("text_write_by");?></span> <?php echo $blog['author'];?></li>
		<?php } ?>
		<?php if( $config->get('cat_show_category') ) { ?>
		<li class="publishin">
			<span class="icon-user">   <?php echo $this->language->get("text_published_in");?></span>
			<a href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
		</li>
		<?php } ?>
		
		<?php if( $config->get('cat_show_hits') ) { ?>
		<li class="hits"><span class="icon-eye-open">   <?php echo $this->language->get("text_hits");?></span> <?php echo $blog['hits'];?></li>
		<?php } ?>
		<?php if( $config->get('cat_show_comment_counter') ) { ?>
		<li class="comment_count"><span class="icon-comments">   <?php echo $this->language->get("text_comment_count");?></span> <?php echo $blog['comment_count'];?></li>
		<?php } ?>
	</ul>
	</div>
	<div class="blog-body col-lg-8 col-md-8 col-sm-6 col-xs-12">
		
<?php if( $config->get('cat_show_title') ) { ?>
	<div class="blog-header clearfix">
	
	<h3 class="blog-title">	<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></h3>
	</div>
	<?php } ?>
		<?php if( $config->get('cat_show_description') ) {?>
		<div class="description">
			<?php echo $blog['description'];?>
		</div>
		<?php } ?>
		<?php if( $config->get('cat_show_readmore') ) { ?>
		<div class="blog-readmore"><a href="<?php echo $blog['link'];?>" class="button"><?php echo $this->language->get('text_readmore');?></a></div>
		<?php } ?>
	</div>	
</div>
</div>