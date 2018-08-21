<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel"></h4>
            </div>
            <div class="modal-body">
                <div style="margin-bottom: 10px">
                    <label for="radio_60">评分</label>
                </div>
                <div>
                    <div class="radio-inline">
                        <input type="radio" name="radio" class="form-control" id="radio_60" value="60">
                        <label for="radio_60" style="margin-left: 30px;">60</label>
                    </div>
                    <div class="radio-inline">
                        <input type="radio" name="radio" class="form-control" id="radio_70" value="70">
                        <label for="radio_70" style="margin-left: 30px;">70</label>
                    </div>
                    <div class="radio-inline" >
                        <input type="radio" name="radio" class="form-control" id="radio_80" value="80">
                        <label for="radio_80" style="margin-left: 30px;">80</label>
                    </div>
                    <div class="radio-inline">
                        <input type="radio" name="radio" class="form-control" id="radio_90" value="90">
                        <label for="radio_90" style="margin-left: 30px;">90</label>
                    </div>
                    <div class="radio-inline">
                        <input type="radio" name="radio" class="form-control" id="radio_100" value="100">
                        <label for="radio_100" style="margin-left: 30px;">100</label>
                    </div>
                </div>
                <%--<div class="form-group">--%>
                    <%--<label for="txt_parentdepartment">上级部门</label>--%>
                    <%--<input type="text" name="txt_parentdepartment" class="form-control" id="txt_parentdepartment" placeholder="上级部门">--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                    <%--<label for="txt_departmentlevel">部门级别</label>--%>
                    <%--<input type="text" name="txt_departmentlevel" class="form-control" id="txt_departmentlevel" placeholder="部门级别">--%>
                <%--</div>--%>
                <div class="form-group" style="margin-top: 20px;">
                    <label for="txt_statu">评语</label>
                    <input type="text" name="txt_statu" class="form-control" id="txt_statu" placeholder="请评价跑腿者" style="height: 50px">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                <button type="button" id="btn_submit" class="btn btn-primary" data-dismiss="modal" onclick="afterGetGood(${orderfrom.id})"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
            </div>
        </div>
    </div>
</div>

