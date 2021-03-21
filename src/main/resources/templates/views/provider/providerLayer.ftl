<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>客户列表</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layuiadmin/layui/css/layui.css" media="all">
</head>
<body style="background-color: #F2F2F2;">

<form class="layui-form" action="">
    <input type="text" name="id" value="${(provider.id)!}" style="display: none">
        <div class="layui-form-item">
            <label class="layui-form-label">供应商名称</label>
            <div class="layui-input-inline">
                <input type="text" name="providername" value="${(provider.providername)!}" required lay-verify="required" placeholder="请输入供应商名称"
                       autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">公司电话</label>
            <div class="layui-input-inline">
                <input type="text" name="telephone" value="${(provider.telephone)!}" required lay-verify="required" placeholder="请输入公司电话"
                       autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">邮编</label>
            <div class="layui-input-inline">
                <input type="text" name="zip" value="${(provider.zip)!}" required lay-verify="required" placeholder="请输入邮编"
                       autocomplete="off" class="layui-input">
            </div>
        </div>


    <div class="layui-form-item">
        <label class="layui-form-label">公司地址</label>
        <div class="layui-input-block">
            <input type="text" name="address" value="${(provider.address)!}" required lay-verify="required" placeholder="请输入公司地址" autocomplete="off"
                   class="layui-input">
        </div>

    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">联系人</label>
        <div class="layui-input-inline">
            <input type="text" name="connectionperson" value="${(provider.connectionperson)!}" required lay-verify="required" placeholder="请输入联系人" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">联系人电话</label>
        <div class="layui-input-inline">
            <input type="text" name="phone" value="${(provider.phone)!}" required lay-verify="required" placeholder="请输入联系人电话" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-inline">
            <input type="text" name="email" value="${(provider.email)!}" required lay-verify="required" placeholder="请输入邮箱" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">开户行</label>
        <div class="layui-input-inline">
            <input type="text" name="bank" value="${(provider.bank)!}" required lay-verify="required" placeholder="请输入开户行" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">账号</label>
        <div class="layui-input-inline">
            <input type="text" name="account" value="${(provider.account)!}" required lay-verify="required" placeholder="请输入账号" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">传真</label>
        <div class="layui-input-inline">
            <input type="text" name="fax" value="${(provider.fax)!}" required lay-verify="required" placeholder="请输入传真" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">是否有效</label>
        <div class="layui-input-block">
            <input type="radio" name="chose" value="1" title="是">
            <input type="radio" name="chose" value="null" title="否" checked>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="submit" style="display: none">立即提交</button>
        </div>
    </div>
</form>

<script src="${request.contextPath}/static/layuiadmin/layui/layui.js"></script>


<script>
<#--    layui的标准文档查询-->
    layui.use(['form', 'jquery','layer'], function () {
        //申明使用标准
        var form = layui.form;
        //申明jquery的使用。
        var $ = layui.$;
        //申明弹出层的变量
        var layer=layui.layer;
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