<section class="mini-layout">
    <div class="frame_title clearfix">
        <div class="pull-left">
            <span class="help-inline"></span>
            <span class="title">{lang("Cache")}</span>
        </div>
    </div>
    <div class="tab-content">
        <div class="tab-pane active" id="modules">
            <div class="row-fluid">
                <div class="form-horizontal">
                    <table class="table table-striped table-bordered table-hover table-condensed content_big_td">
                        <thead>
                            <tr>
                                <th colspan="6">
                                    {lang("Delete cache")}                                    
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="6">
                                    <div class="inside_padd">
                                        <div class="control-group m-t_10">
                                            <label class="control-label" for="inputName">{lang("Total file caching")}:</label>
                                            <div class="controls">
                                                <span class="filesCount">{echo $allFile}</span>                                                      
                                            </div>
                                        </div>
                                        <div class="control-group m-t_10">
                                            <label class="control-label" for="inputLocal">{lang("Clear old or Delete outdated posts or information")}</label>
                                            <div class="controls">                                                        
                                                <button type="button" data-target="/admin/delete_cache" data-param="expried" id="inputLocal" class="btn btn-small clearCashe btn-danger" ><i class="icon-trash icon-white" ></i> {lang('Clean')}</button>
                                            </div>
                                        </div>
                                        <div class="control-group m-t_10">
                                            <label class="control-label" for="inputLocal2">{lang("Clear all")}</label>
                                            <div class="controls">                                                        
                                                <button type="button" data-target="/admin/delete_cache" data-param="all" id="inputLocal2" class="btn btn-small clearCashe btn-danger"><i class="icon-trash icon-white" ></i> {lang('Clean')}</button>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="tab-pane"></div>
    </div>
</section>