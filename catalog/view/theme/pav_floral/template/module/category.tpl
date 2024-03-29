<div class="box category">
  <div class="box-heading"><span><?php echo $heading_title; ?></span></div>
  <div class="box-content">
    <ul class="box-category">
      <?php foreach ($categories as $category) { 
       $class = "";
     if(isset($category["children"]) && !empty($category["children"])){
      $class = "haschild";
     }
      $name = str_replace("(", '<span class="badge pull-right">(',  $category['name'] );
      $category['name'] = str_replace(")", ')</span>', $name); 
    ?>
      <li class="<?php echo $class; ?>">
        <?php if ($category['category_id'] == $category_id) { ?>
        <a href="<?php echo $category['href']; ?>" class="active"><i class="icon-asterisk"></i><?php echo $category['name']; ?></a>
        <?php } else { ?>
        <a href="<?php echo $category['href']; ?>"><i class="icon-asterisk"></i><?php echo $category['name']; ?></a>
        <?php } ?>
        <?php if ($category['children']) { ?>
        <ul>
          <?php foreach ($category['children'] as $child) { ?>
          <?php
             $child['name'] = str_replace("(", '<span class="badge pull-right">(',  $child['name'] );
             $child['name'] = str_replace(")", ')</span>', $child['name']);  
          ?>
          <li>
            <?php if ($child['category_id'] == $child_id) { ?>
            <a href="<?php echo $child['href']; ?>" class="active"> <?php echo $child['name']; ?></a>
            <?php } else { ?>
            <a href="<?php echo $child['href']; ?>"> <?php echo $child['name']; ?></a>
            <?php } ?>
          </li>
          <?php } ?>
        </ul>
        <?php } ?>
      </li>
      <?php } ?>
    </ul>
  </div>
</div>
