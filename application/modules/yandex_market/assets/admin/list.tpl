
   
<div class="container">
                    <section class="mini-layout">
                        <div class="frame_title clearfix">
                            <div class="pull-left">
                                <span class="help-inline"></span>
                                <span class="title">{lang('Yandex Market management', 'banners')}</span>
                            </div>
                            <div class="clearfix" style="float:left; margin-left:10px; margin-top:5px;">
                                <div class="btn-group myTab m-t_20 pull-left" data-toggle="buttons-radio"  style="display:block; float:left; margin-top:0px;" >
                                    <a href="#yandex" class="btn btn-small active">Yandex</a>
                                    <a href="#hotlin" class="btn btn-small">Hotline</a>
                                </div>
                            </div>

                        </div>
                        <div class="tab-content">         
                        <div class="tab-pane active" id="yandex">
                            <form id="settings_form" action="/admin/components/cp/yandex_market/update" method="post">
                            <div class="pull-right" style="margin-bottom:10px;">
                                <div class="d-i_b">
                                    <button type="button" class="btn btn-small btn-primary action_on formSubmit" data-form="#settings_form"><i class="icon-ok"></i>{lang('Save','admin')}</button>
                                        {echo create_language_select(ShopCore::$ci->cms_admin->get_langs(true), $locale, "/admin/components/run/shop/settings/index")}
                                </div>
                            </div>
                            <table class="table table-striped table-bordered table-hover table-condensed t-l_a">
                                <thead>
                                    <tr>
                                        <th colspan="6">
                                            {lang('Settings Yandex.Market','admin')}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="6">
                                            <div class="inside_padd">
                                                <div class="control-group">
                                                    <label class="control-label">{lang('Displayed categories selection','admin')}:</label>
                                                    {$holder = ShopCore::app()->SSettings->getSelectedCats()}
                                                    {$categories = ShopCore::app()->SCategoryTree->getTree()}
                                                    <div class="controls">
                                                        <select name="displayedCats[]" multiple="multiple" style="width:285px;height:129px;">
                                                            {foreach $categories as $category}
                                                                <option value="{echo $category->getId()}"{if @in_array($category->getId(), $holder)}selected="selected"{/if}>
                                                                    {str_repeat('-',$category->getLevel())} {echo ShopCore::encode($category->getName())}
                                                                </option>
                                                            {/foreach}
                                                        </select>
                                                    </div>

                                                    <div class="controls">
                                                        <span class="frame_label no_connection">
                                                            <span class="niceCheck b_n">
                                                                {$isAdult = ShopCore::app()->SSettings->getIsAdult()}
                                                                <input type="checkbox" name="yandex[isAdult]" value="1"{if $isAdult == 1}checked="checked"{/if} id="yandex[isAdult]" />
                                                            </span>
                                                            {lang('Adult products','admin')}
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table class="table table-striped table-bordered table-hover table-condensed content_big_td">
                                <thead>
                                <th>{lang('Yandex.Market document','admin')}</th>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="inside_padd">
                                                <div class="control-group">
                                                    <a href="{site_url('yandex_market/genreyml/yandex')}" target="_blank">{lang('XML document','admin')}</a>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            </form>
                        </div>   
                         
                        
                        <div class="tab-pane" id="hotlin">
                            <form id="settings_form1" action="/admin/components/cp/yandex_market/update" method="post">
                            <div class="pull-right" style="margin-bottom:10px;">
                                <div class="d-i_b">
                                    <button type="button" class="btn btn-small btn-primary action_on formSubmit" data-form="#settings_form1"><i class="icon-ok"></i>{lang('Save','admin')}</button>
                                        {echo create_language_select(ShopCore::$ci->cms_admin->get_langs(true), $locale, "/admin/components/run/shop/settings/index")}
                                </div>
                            </div>
                            <table class="table table-striped table-bordered table-hover table-condensed t-l_a">
                                <thead>
                                    <tr>
                                        <th colspan="6">
                                            {lang('Settings Hotline.ua','admin')}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="6">
                                            <div class="inside_padd">
                                                <div class="control-group">
                                                    <label class="control-label">{lang('Displayed categories selection','admin')}:</label>
                                                 
                                                    {$model = ShopSettingsQuery::create()->filterByName('selectedProductCatsHotline')->findOne()}
                                                    {$arr = $model->getValue()}
                                                    {$holder = unserialize($arr)}   
                                                    {$categories = ShopCore::app()->SCategoryTree->getTree()}
                                                    <div class="controls">
                                                        <select name="displayedCatsHotline[]" multiple="multiple" style="width:285px;height:129px;">
                                                            {foreach $categories as $category}
                                                                <option value="{echo $category->getId()}"{if @in_array($category->getId(), $holder)}selected="selected"{/if}>
                                                                    {str_repeat('-',$category->getLevel())} {echo ShopCore::encode($category->getName())}
                                                                </option>
                                                            {/foreach}
                                                        </select>
                                                    </div>

                                                <div class="controls" style="padding-top:10px;">
                                                <div >
                                                    <div class="control-group">
                                                        <label class="control-label">
                                                            Set your hotline shop number:
                                                            <span class="must">*</span>
                                                        </label>
                                                       {$model = ShopSettingsQuery::create() ->filterByName('shopNumber') ->findOne()}
                                                        <div class="controls">
                                                            <input type="text" value="{echo $model->getValue()}" name="shopNumber" class="input-small" required="required" data-form="#settings_form1"  >
                                                            <span class="help-inline"></span>
                                                        </div>
                                                    </div>
                                                            <select multiple="multiple" size="all">
                                                                <option>1</option>
                                                                <option>2</option>
                                                                <option>3</option>
                                                                <option>4</option>
                                                                <option>5</option>
                                                              </select>
                                                </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table class="table table-striped table-bordered table-hover table-condensed content_big_td">
                                <thead>
                                <th>{lang('Hotline.ua document','admin')}</th>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="inside_padd">
                                                <div class="control-group">
                                                    <a href="{site_url('yandex_market/genreyml/hotline')}" target="_blank">{lang('XML document','admin')}</a>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>   
                        </form>
                        </div>
    </section>
</form>                                               
</div>
