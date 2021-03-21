<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>添加商品</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layuiadmin/layui/css/layui.css" media="all">
</head>
<body style="background-color: #F2F2F2;">

<form class="layui-form" action="">
    <input type="text" name="id" value="${(provider.id)!}" style="display: none">
    <div>
        <div style="float: left">
            <div class="layui-form-item">
                <label class="layui-form-label">供应商</label>
                <div class="layui-input-block">
<#--                    <input type="text" name="providername" value="${(provider.providername)!}" required-->
<#--                           lay-verify="required" placeholder="请输入供应商名称"-->
<#--                           autocomplete="off" class="layui-input">-->
                    <select id="bg_id" name="bg_id" lay-verify="required"  lay-filter="business" class="select">
                        <option value="" ></option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品名称</label>
                <div class="layui-input-block">
                    <input type="text" name="goodsname" value="${(provider.telephone)!}" required lay-verify="required"
                           placeholder="请输入商品名称"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品描述</label>
                <div class="layui-input-block">
                    <input type="text" name="description" value="${(provider.zip)!}" required lay-verify="required"
                           placeholder="请输入商品描述"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-upload" style="float: right">
            <button type="button" class="layui-btn" id="test1">上传图片</button>
            <div class="layui-upload-list">
                <img class="layui-upload-img" id="demo1" border="1px">
                <p id="demoText"></p>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">产地</label>
        <div class="layui-input-inline">
            <input type="text" name="produceplace" value="${(provider.address)!}" required lay-verify="required"
                   placeholder="请输入产地" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">包装</label>
        <div class="layui-input-inline">
            <input type="text" name="goodspackage" value="${(provider.address)!}" required lay-verify="required"
                   placeholder="请输入包装" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">规格</label>
        <div class="layui-input-inline">
            <input type="text" name="gsize" value="${(provider.connectionperson)!}" required
                   lay-verify="required" placeholder="请输入规格" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">生产批号</label>
        <div class="layui-input-inline">
            <input type="text" name="productcode" value="${(provider.phone)!}" required lay-verify="required"
                   placeholder="请输入生产批号" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">批准文号</label>
        <div class="layui-input-inline">
            <input type="text" name="promitcode" value="${(provider.bank)!}" required lay-verify="required"
                   placeholder="请输入批准文号" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">销售价格</label>
        <div class="layui-input-inline">
            <input type="text" name="price" value="${(provider.account)!}" required lay-verify="required"
                   placeholder="请输入销售价格" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">库存量</label>
        <div class="layui-input-inline">
            <input type="text" name="number" value="${(provider.bank)!}" required lay-verify="required"
                   placeholder="请输入库存量" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">库存预警值</label>
        <div class="layui-input-inline">
            <input type="text" name="dangernum" value="${(provider.account)!}" required lay-verify="required"
                   placeholder="请输入库存预警值" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否有效</label>
        <div class="layui-input-block">
            <input type="radio" name="choseradio" value="1" title="是" checked="">
            <input type="radio" name="choseradio" value="null" title="否">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="submit" style="display: none">立即提交</button>
        </div>
    </div>
</form>
<#--导入JS-->
<script src="${request.contextPath}/static/layuiadmin/layui/layui.js"></script>
<script>
    <#--    layui的标准文档查询-->
    layui.use(['form', 'jquery','layer', 'table'], function () {
        //申明使用标准
        var form = layui.form;
        //申明jquery的使用。
        var $ = layui.$;
        //申明弹出层的变量
        var layer=layui.layer;

        //添加商品信息，下拉框从数据库查询数据显示出来。
        $(function () {
            $.ajax({
                type: "POST",
                // url: "/admin/devData/getSendQueueShowChannel",
                url: "${request.contextPath}/goods/getProviderName",
                success: function (data) {
                    $.each(data, function (index, item) {
                        alert(data)
                        alert(index);
                        alert(item);
                        $("#sendQueueChannel").append(new Option(item));
                    });
                    layui.form.render("select");
                },error: function () {
                    alert("查询信道失败")
                }
            })
        });

        /*
        * form语句，
        *   1、'submit(submit)'
        *       （1）'submit()'：监听提交按钮，(submit)是filter。只要能对应上按钮的设置，就能触发回调函数。
        * */
        form.on('submit(submit)', function (data) {
            console.log(data.field);
            /*
            * 1、作用：提交iframe弹出层的表单。
            * 2、ajax格式：$.ajax({})
            * */
            //利用ajax提交数据。特点：不刷新整个页面，局部刷新提交数据。
            $.ajax({
                type: "post",
                //传递给controller层
                url: "${request.contextPath}/provider/addOrUpdateProvider",
                contentType: 'application/json; charset=UTF-8',
                //字符串转换，设置字符集
                data: JSON.stringify(data.field),
                success: function (res) {
                    //controller的返回值都会存到res里面。
                    console.log("=====success=====")
                    console.log(res)
                    /*
                    * res.msg提示信息
                    * {icon: 1}：显示正确，还是错误（提示信息）
                    * */
                    layer.alert(res.msg, {icon: 1}, function () {
                        //调用父页面的关闭方法。
                        parent.closeLayer();
                        //重新加载页面
                        parent.reloadProviderList();
                    })
                },
                error: function (res) {
                    console.log(res);
                }
            })
            return false;
        });

    });
</script>
</body>
</html>