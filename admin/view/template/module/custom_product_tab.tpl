<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } else if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a><a href="#tab-about"><?php echo $tab_about; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
       <div id="tab-general">
        <table class="form">
          <tr>
            <td><?php echo $entry_always_show; ?></td>
            <td>
              <input type="checkbox" name="cpt_always_show" value="1" <?php echo ($cpt_always_show) ? 'checked="checked"': ''; ?>/>
            </td>
          </tr>
          <?php if ($language_count > 1) { ?>
          <tr>
            <td><?php echo $entry_use_default_value; ?></td>
            <td>
              <input type="checkbox" name="cpt_use_default_language_value" value="1" <?php echo ($cpt_use_default_language_value) ? 'checked="checked"': ''; ?>/>
            </td>
          </tr>
          <?php } ?>
          <tr>
            <td><?php echo $entry_remove_sql_changes; ?></td>
            <td>
              <input type="checkbox" name="cpt_remove_sql_changes" value="1" <?php echo ($cpt_remove_sql_changes) ? 'checked="checked"': ''; ?>/>
            </td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="custom_product_tab_status">
                <?php if ($custom_product_tab_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
              <input type="hidden" name="cpt_installed" value="1" />
            </td>
          </tr>
        </table>
       </div>
       <div id="tab-about">
        <table class="form">
          <tr>
            <td style="min-width:200px;"><?php echo $text_ext_name; ?></td>
            <td style="min-width:400px;"><?php echo $ext_name; ?></td>
            <td rowspan="7" style="width:440px;border-bottom:0px;"><img src="view/image/cpt/extension_logo.png" /></td>
          </tr>
          <tr>
            <td><?php echo $text_ext_version; ?></td>
            <td><b><?php echo $ext_version; ?></b> [ <?php echo $ext_type; ?> ]</td>
          </tr>
          <tr>
            <td><?php echo $text_ext_compat; ?></td>
            <td><?php echo $ext_compatibility; ?></td>
          </tr>
          <tr>
            <td><?php echo $text_ext_url; ?></td>
            <td><a href="<?php echo $ext_url; ?>" target="_blank"><?php echo $ext_url ?></a></td>
          </tr>
          <tr>
            <td><?php echo $text_ext_support; ?></td>
            <td>
              <a href="mailto:<?php echo $ext_support; ?>?subject=<?php echo $ext_subject; ?>"><?php echo $ext_support; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;
              <a href="<?php echo $ext_support_forum; ?>"><?php echo $text_forum; ?></a> 
              <a href="view/static/bull5i_cpt_extension_help.htm" id="help_notice" style="float:right;"><?php echo $text_asking_help; ?></a>
            </td>
          </tr>
          <tr>
            <td><?php echo $text_ext_legal; ?></td>
            <td>Copyright &copy; 2011 Romi Agar. <a href="view/static/bull5i_cpt_extension_terms.htm" id="legal_notice"><?php echo $text_terms; ?></a></td>
          </tr>
          <tr>
            <td style="border-bottom:0px;"></td>
            <td style="border-bottom:0px;"></td>
          </tr>
        </table>
       </div>
      </form>
    </div>
  </div>
<div id="legal_text" style="display:none"></div>
<div id="help_text" style="display:none"></div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
$("#legal_notice").click(function(e) {
    e.preventDefault();
    $("#legal_text").load(this.href, function() {
        $(this).dialog({
            title: '<?php echo $text_terms; ?>',
            width:  800,
            height:  600,
            minWidth:  500,
            minHeight:  400,
            modal: true,
        });
    });
    return false;
});
$("#help_notice").click(function(e) {
    e.preventDefault();
    $("#help_text").load(this.href, function() {
        $(this).dialog({
            title: '<?php echo $text_help_request; ?>',
            width:  800,
            height:  600,
            minWidth:  500,
            minHeight:  400,
            modal: true,
        });
    });
    return false;
});
//--></script> 
<?php echo $footer; ?>