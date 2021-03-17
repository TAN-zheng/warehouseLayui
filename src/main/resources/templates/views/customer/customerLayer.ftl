<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>客户信息</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layuiadmin/layui/css/layui.css" media="all">
</head>
<body style=" background-color: #F2F2F2;">
<#--卡片面板-->
<div style="padding: 20px;">
    <div class="layui-row layui-col-space15">
        <#--        strap栅格系统，拉长卡片-->
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">
                    <form class="layui-form" action="" style="margin-top: 5px">
<#--                        用EL表达式获取到model里面存放的数据。controller里面的。-->
                        <input type="text" name="id" value="${(customer.id)!}" style="display: none">
                        <div class="layui-form-item">
                            <label class="layui-form-label">客户名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="customername" placeholder=""
                                       autocomplete="off" class="layui-input" value="${(customer.customername)!}">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">客户邮编</label>
                            <div class="layui-input-inline">
                                <input type="text" name="zip" required lay-verify="required"
                                       placeholder="" autocomplete="off" class="layui-input" value="${(customer.zip)!}">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">客户地址</label>
                            <div class="layui-input-inline">
                                <input type="text" name="address" required lay-verify="required"
                                       placeholder="" autocomplete="off" class="layui-input" value="${(customer.address)!}">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">客户电话</label>
                            <div class="layui-input-inline">
                                <input type="text" name="telephone" required lay-verify="required|phone"
                                       placeholder="" autocomplete="off" class="layui-input" value="${(customer.telephone)!}">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">联系人</label>
                            <div class="layui-input-inline">
                                <input type="text" name="connectionperson" required lay-verify="required"
                                       placeholder="" autocomplete="off" class="layui-input" value="${(customer.connectionperson)!}">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">联系电话</label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" required lay-verify="required"
                                       placeholder="" autocomplete="off" class="layui-input" value="${(customer.phone)!}">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">开户行</label>
                            <div class="layui-input-inline">
                                <input type="text" name="bank" required lay-verify="required"
                                       placeholder="" autocomplete="off" class="layui-input" value="${(customer.bank)!}">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">账户</label>
                            <div class="layui-input-inline">
                                <input type="text" name="account" required lay-verify="required"
                                       placeholder="" autocomplete="off" class="layui-input" value="${(customer.account)!}">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-inline">
                                <input type="text" name="email" required lay-verify="required|email"
                                       placeholder="" autocomplete="off" class="layui-input" value="${(customer.email)!}">
                            </div>
                        </div>
                        <button class="layui-btn layui-btn-sm" lay-filter="submit" lay-submit style="display: none">新增</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${request.contextPath}/static/layuiadmin/layui/layui.js"></script>
<script>
<#--    添加模块-->
    layui.use(['form','jquery','layer'],function () {
            var form=layui.form;
            var $=layui.$;
            var layer=layui.layer;
    //        表单监听，lay-event="submit"监听事件。
        form.on('submit(submit)',function (data) {
            // alert("111")
                //后台展示数据。
                console.log(data.field);

            $.ajax({
                type:'post',
                //后台地址,提交后腰判断他是添加还是更改。
                url:'${request.contextPath}/customer/addOrUpdateCustomer',
                //json方法,相当于是请求头
                contentType:'application/json;charset=UTF-8',
                //把数据转成json的字符串
                data:JSON.stringify(data.field),
                //
                success:function (res) {
                    //返回的任何值都储存到res里面的
                    console.log(res)
                    layer.alert(res.msg,{icon:1},function () {
                    //        调用父页面的方法
                        parent.closeLayer();
                        parent.reloadCustomerList();
                    })
                },
                error:function (res) {
                    console.log(res)
                }

            })
            return false;
        })
    })
</script>
</body>
</html>