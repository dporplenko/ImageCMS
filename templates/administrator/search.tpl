    <section class="mini-layout">
        <div class="frame_title clearfix">
            <div class="pull-left">
                <span class="help-inline"></span>
                <span class="title">{lang('a_search_pages_contains')} "{$search_title}"</span>
            </div>                          
        </div>
        <div class="row-fluid">
	    {if count($pages)}
            <table class="table table-striped table-bordered table-hover table-condensed pages-table">
                <thead>
                    <tr>
                        <th class="span1">ID</th>
                        <th class="span4">{lang('a_title')}</th>
                        <th class="span3">{lang('a_url')}</th>
                        <th class="span2">Категория</th>
                        <th class="span1">{lang('a_status')}</th>
                    </tr>
                </thead>
                <tbody >
                    
                    {foreach $pages as $page}
                    <tr data-id="{$page.id}">
                        <td><span>{$page.id}</span></td>
                        <td class="share_alt">
                            <a href="{$BASE_URL}{$page.cat_url}{$page.url}" target="_blank" class="go_to_site pull-right btn btn-small"  data-rel="tooltip" data-placement="top" data-original-title="{lang('a_goto_site')}"><i class="icon-share-alt"></i></a>
                            <a href="{$BASE_URL}admin/pages/edit/{$page.id}" class="title pjax">{$page.title}</a>
                        </td>
                        <td><span>{truncate($page.url, 40, '...')}</span></td>
                        <td><span>
			{$categories[$page.category]}
			</span></td>
                        <td>
                            <div class="frame_prod-on_off" data-rel="tooltip" data-placement="top" data-original-title="{if $page['post_status'] == 'publish'}{lang('a_show')}{else:}{lang('a_dont_show')}{/if}" onclick="change_page_status('{$page.id}');">
                                <span class="prod-on_off {if $page['post_status'] != 'publish'}disable_tovar{/if}" style="{if $page['post_status'] != 'publish'}left: -28px;{/if}"></span>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
	    {else:}
                            <div class="alert alert-info" style="margin: 18px;">{lang('a_not_found')}</div>
            {/if}            
        </div>
        {if $paginator > ''}
        <div class="clearfix">
            {$paginator}
        </div>
        {/if}
    </section>




{/*}

<div class="top-navigation">
    <div style="float:left;">
    <div style="padding-left:10px;">
        <form style="width:100%;" onsubmit="return false;" method="post" action="{$BASE_URL}admin/admin_search" id="g_search_form">
            <input type="text" value="{$search_title}" name="search_text" class="textbox_long" onclick="if (this.value=='{lang('a_search_pages')}...') this.value='';" onblur="if (this.value=='') this.value='{lang('a_search_pages')}...';" />
            <input type="submit" value="Search" class="search_submit" onclick="ajax_form('g_search_form', 'page');"/>
           
            <a href="javascript:ajax_div('page', base_url + 'admin/admin_search/advanced_search')">{lang('a_advanced_search')}</a>
            {if $advanced_search}
                <a style="padding-left:15px;" href="#" id="toggler">{lang('a_change_param')}</a>
            {/if}
         </form>
    </div>

    </div>

    <div align="right" style="padding:7px 13px;">
    <input type="button" class="button_silver_130" value="{lang('a_create_page')}" onclick="ajax_div('page', base_url + 'admin/pages/index'); return false;" />
    <span style="padding:5px;"></span>
    <input type="button" class="button_silver_130" value="{lang('a_create_cat')}" onclick="ajax_div('page', base_url + 'admin/categories/create_form'); return false;" />
    </div>
</div>

<div style="clear:both"></div>

{if $advanced_search}
<div id="filter_block_container">
<div id="change_filter_data_block">
<form action="{$BASE_URL}admin/admin_search/validate_advanced_search" method="post" id="filter_form" style="width:100%;">

    <?php if (!function_exists('build_cats_tree')) { ?>
    <?php  function build_cats_tree($cats, $selected_cats = array()) { ?>        
        {foreach $cats as $cat}
             <option {foreach $selected_cats as $k} {if $k == $cat.id} selected="selected" {/if} {/foreach}
             value="{$cat['id']}">{for $i=0;$i < $cat['level'];$i++}-{/for} {$cat['name']}</option>
            {if $cat['subtree']} {build_cats_tree($cat['subtree'], $selected_cats)} {/if}
        {/foreach}
    <?php } ?>   
    <?php } ?> 

	<div class="form_text">{lang('a_text')}</div>
	<div class="form_input">
        <input type="text" class="textbox_long" value="{$filter_data.search_text}" name="search_text" />
    </div>
	<div class="form_overflow"></div>


	<div class="form_text">{lang('a_categories')}</div>
	<div class="form_input">
        <select name="category[]" multiple="multiple" style="width:270px;">
        <option value="0">{lang('a_root')}</option>
        <option disabled="disabled"> </option>
            {build_cats_tree($this->CI->lib_category->build(), (array) $filter_data.category)}  
        </select>
    </div>
	<div class="form_overflow"></div>

    {$cfcm_groups = $this->CI->db->get('content_field_groups')}
    {if $cfcm_groups->num_rows() > 0}
	<div class="form_text">{lang('a_search_group')}:</div>
	<div class="form_input">
    <select id="cfcm_search_group_id" onchange="filter_load_form();">
            <option value="0">-- {lang('a_choose_group')} --</option>
        {foreach $cfcm_groups->result_array() as $g}
            <option value="{$g.id}" {if $g.id == $filter_data.use_cfcm_group}selected="selected"{/if} >{$g.name}</option>
        {/foreach}
    </select>
    </div>
	<div class="form_overflow"></div>

    <div id="dynamic_cfcm_form" class="CForms">{$cfcm_group_html}</div>

    {/if}

	<div class="form_text"></div>
	<div class="form_input">
        <input type="submit" value="{lang('a_search')}" class="button_silver" onclick="ajax_me('filter_form');" />
    </div>
	<div class="form_overflow"></div>

</form>
</div>
</div>

{literal}
    	<script type="text/javascript">
        window.addEvent('domready', function(){	
    		$('toggler').addEvents({
			    'click' : function(){
                    var cur_style = $('filter_block_container').getStyle('display'); 
                    if (cur_style == 'none')
                    {
    		    		$('filter_block_container').setStyle('display', 'block');
                        
                    }
                    else
                    {
                    	$('filter_block_container').setStyle('display', 'none');
                    }

                    return false;
			    },
    		    });
            });

            function filter_load_form()
            {
                gid = $('cfcm_search_group_id').value;

                ajax_div('dynamic_cfcm_form', base_url + 'admin/admin_search/form_from_group/'+gid);
            }
		</script>

        <style type="text/css">
            #change_filter_data_block {
                display:block;
                position:absolute;
                clear:both;
                margin:0px;
                padding:0px;
                text-align:left;
                list-style-type:none;
                text-align:center;
                width:500px;
                float:none;
                left:0px;
                top:0px;
                background-color:#FFF;
                border-left:3px solid #A2C449;
                border-right:3px solid #A2C449;
                border-bottom:3px solid #A2C449;
                opacity: 0.9;
                z-index:999;
            }
            #filter_block_container {
                display:none;
                position:relative;
                width:700px;
                margin:0px auto 0px;
            }
        </style>
{/literal}

{/if}


{if count($pages) == 0}
    <div id="notice" style="width:500px;">
        {lang('a_not_found')}
    </div>    
    {return}
{/if}



<div id="sortable" >
		  <table id="pages_table">
		  	<thead>
                <th width="5px"></th>
				<th axis="number" width="5px;">{lang('a_id')}</th>
				<th axis="string">{lang('a_title')}</th>
				<th axis="string">{lang('a_category')}</th>
				<th axis="string">{lang('a_url')}</th>
				<th axis="date">{lang('a_created')}</th>
				<th axis="string">{lang('a_author')}</th>
				<th>{lang('a_status')}</th>
				<th></th>
			</thead>
			<tbody>
		{foreach $pages as $page}
		<tr id="{$page.number}">
            <td>
            <input type="checkbox" id="chkb_{$page.id}" class="chbx"/>  
            </td>
			<td class="">{$page.id}</td>
			<td title="{$page.title}. {lang('a_view_count')}: {$page.showed}" onclick="ajax_div('page','{$BASE_URL}admin/pages/edit/{$page.id}'); return false;">{truncate($page.title, 50)}</td>
			<td>
                <a href="#" onclick="cats_options({$page.category});" >{truncate(get_category_name($page.category), 20, '...')}</a> 
            </td>
            <td><a href="{$BASE_URL}{$page.cat_url}{$page.url}" target="_blank">{truncate($page.url, 40, '...')}</a></td>
			<td>{ date('Y-m-d H:i:s', $page['created']) }</td>
			<td>{$page.author}</td>
			<td>
			{ switch $page['post_status'] }
				{ case "publish" }
				<div style="visibility:hidden;float:left">1</div>
                <img id="p_status_{$page.id}" onclick="change_page_status('{$page.id}');" title="{lang('a_published')}" src="{$THEME}/images/publish.png" width="16" height="16" />
                {break;}
				{ case "pending" }
				<div style="visibility:hidden;float:left">2</div>
                <img id="p_status_{$page.id}" onclick="change_page_status('{$page.id}');" title="{lang('a_wait_approve')}" src="{$THEME}/images/pending.png" width="16" height="16" />
                {break;}
				{ case "draft" }
					<div style="visibility:hidden;float:left">3</div>
                    <img id="p_status_{$page.id}" onclick="change_page_status('{$page.id}');" title="{lang('a_not_publ')}" src="{$THEME}/images/draft.png" width="16" height="16" />
                {break;}
			{ /switch }
			</td>
			<td  class="rightAlign">
			<img onclick="ajax_div('page','{$BASE_URL}admin/pages/edit/{$page.id}/{$page.lang}');" style="cursor:pointer" src="{$THEME}/images/edit_page.png" width="16" height="16" title="{lang('a_edit')}" />
			<img onclick="confirm_delete_page({$page.id});" src="{$THEME}/images/delete_page.png"  style="cursor:pointer" width="16" height="16" title="Удалить" />
			</td>
		</tr>
		{/foreach}
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</tfoot>
		  </table>
</div>

<div style="padding-left:15px;padding-top:2px;">
<a href="#" onclick="check_all(); return false;">{lang('a_cancel_all')}</a>  /  <a href="#" onclick="uncheck_all(); return false;">{lang('a_unselect_all')}</a> 
</div>

<div class="footer_block" align="right">
{lang('a_with_selected')}:
<input type="submit" name="delete"  class="button_silver" value="{lang('a_repalce')}" onclick="show_move_window('move');" />
<input type="submit" name="delete"  class="button_silver" value="{lang('a_copy')}" onclick="show_move_window('copy');" />
<input type="submit" name="delete"  class="button_red" style="font-weight:bold;" value="{lang('a_delete')}" onclick="delete_sel_pages({$cat_id}); return false;" />
</div>

<div align="center" style="padding:5px;" id="pagination">
{$pagination}
</div>

{literal}
    	<script type="text/javascript">
			window.addEvent('domready', function(){
				pages_table = new sortableTable('pages_table', {overCls: 'over', sortOn: -1 ,onClick: function(){}});
                pages_table.altRow();
			});

            function check_all()
            {
                var items = $('pages_table').getElements('input');
                items.each(function(el,i){
                if(el.hasClass('chbx')) 
                {
                    el.checked = true;
                }  
                });
            }

            function uncheck_all()
            {
                var items = $('pages_table').getElements('input');
                items.each(function(el,i){
                if(el.hasClass('chbx')) 
                {
                    el.checked = false;
                }  
                });
            }

            function show_move_window(action)
            {
                new MochaUI.Window({
                    id: 'move_pages_window',
                    title: 'Копировать/Переместить страницы ',
                    type: 'modal',
                    loadMethod: 'xhr',
                    contentURL: base_url + 'admin/pages/show_move_window/' + action,
                    width: 410,
                    height: 100
                });
            }
		</script>
{/literal}
{*/}