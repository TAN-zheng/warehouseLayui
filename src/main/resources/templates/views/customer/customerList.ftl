<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>客户管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${request.contextPath}/static/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${request.contextPath}/static/layuiadmin/style/admin.css" media="all">

    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body style=" background-color: #F2F2F2;">
<#--卡片面板-->
<div style="padding: 20px;">
    <div class="layui-row layui-col-space15">
<#--        strap栅格系统，拉长卡片-->
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">
<#--                表单    条件查询框 -->
                    <form>
                        <div class="layui-form-item" style="margin-top: 5px">
                            <div class="layui-inline">
                                <label class="layui-form-label">客户名称</label>
                                <div class="layui-input-inline">
                                    <input type="tel" name="customername" lay-verify="" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">客户电话</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="telephone" lay-verify="" autocomplete="off" class="layui-input">
                                </div>
                            </div><div class="layui-inline">
                                <label class="layui-form-label">联系人</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="connectionperson" lay-verify="" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <button type="button" id="search" class="layui-btn layui-btn-sm" >查询</button>
                            <button type="button" id="reset" class="layui-btn layui-btn-sm">清空</button>
                        </div>

                    </form>
<#--                    数据表格-->
                    <table class="layui-hide" id="customer" lay-filter="customer"></table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
<#--        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>-->
<#--        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>-->
<#--        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>-->
        <button class="layui-btn layui-btn-sm" lay-event="add">新增</button>
        <button class="layui-btn layui-btn-sm" lay-event="multiDelete">批量删除</button>
    </div>
</script>

<script type="text/html" id="bar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script src="${request.contextPath}/static/layuiadmin/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述 JS 路径需要改成你本地的 -->
<script>
<#--    'table','jquery','layer'主键-->
    layui.use(['table','jquery','layer'], function(){
        var table = layui.table;
        var $=layui.$;
        var layer=layui.layer;

        var layerIndex='';
        table.render({
            elem: '#customer'
            ,url:'${request.contextPath}/customer/getPageList'
            ,method:'post'
            ,contentType:'application/json'
            ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                //是否能被选中。fixed: 'left'：固定到左端。
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID'}
                ,{field:'customername', title:'客户名称'}
                ,{field:'zip', title:'客户邮编'}
                ,{field:'address', title:'客户地址'}
                ,{field:'telephone', title:'客户电话'}
                ,{field:'connectionperson', title:'联系人'}
                ,{field:'phone', title:'联系电话'}
                ,{field:'bank', title:'开户行'}
                ,{field:'account', title:'账户'}
                ,{field:'email', title:'邮箱', width:150, edit: 'text', templet: function(res){
                        return '<em>'+ res.email +'</em>'
                    }}

                ,{fixed: 'right', title:'操作', toolbar: '#bar', width:150}
            ]]
            ,page: true
        });

        //头工具栏事件
        table.on('toolbar(customer)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;
                case 'add':
                    layer.open({
                        title:'新增客户信息',
                        type: 2,
                        area:['350px','400px'],
                        btn: ['确认', '取消'], //可以无限个按钮
                        content:'${request.contextPath}/customer/customerLayer' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

                        ,yes: function(index, layero){
                            //按钮【按钮一】的回调
                            // alert("yes")
                            layerIndex=index;
                            //获取form表单
                            var submitForm = layer.getChildFrame('form', index);
                            console.log(submitForm)
                            //获取表单里面的“新增”按钮
                            var submitButton = submitForm.find("button");
                            console.log(submitButton)
                            submitButton.click();
                        }
                    });
                    break;

                    case'multiDelete':
                        layer.confirm('真的删除这些数据吗？', function(index){
                            // obj.del();
                            var idAry=[];
                               var data=checkStatus.data;
                               console.log(data)
                            for (var  i=0;i<data.length;i++){
                                var id=data[i].id;
                                idAry.push(id);
                            }
                            console.log(idAry);
                            $.ajax({
                                type:'post',
                                //后台地址,提交后腰判断他是添加还是更改。
                                url:'${request.contextPath}/customer/deleteCustomerByIds',
                                //json方法,相当于是请求头
                                // contentType:'application/json;charset=UTF-8',因为只传一个id，所以不用转json
                                //把数据转成json的字符串
                                // data:JSON.stringify(data.field),

                                //直接拼接字符串，相当于传参数。相当于parameter一样。
                                data:'ids='+idAry,
                                //
                                success:function (res) {
                                    layer.msg(res.msg);
                                    layer.close(index);//关闭提示信息
                                    table.reload('customer');
                                },
                                error:function (res) {
                                    console.log(res)
                                }

                            })
                            layer.close(index);
                        });
            };
        });

        //监听行工具事件
        table.on('tool(customer)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除这条数据吗？', function(index){
                    // obj.del();
                    /*
                    * 利用ajax传数据到后台进行删除
                    * */
                    $.ajax({
                        type:'post',
                        //后台地址,提交后腰判断他是添加还是更改。
                        url:'${request.contextPath}/provider/deleteCustomerByIds',
                        //json方法,相当于是请求头
                        // contentType:'application/json;charset=UTF-8',因为只传一个id，所以不用转json
                        //把数据转成json的字符串
                        // data:JSON.stringify(data.field),

                        //直接拼接字符串，相当于传参数。相当于parameter一样。
                        data:'ids='+data.id,
                        //
                        success:function (res) {
                            layer.msg(res.msg);
                            layer.close(index);//关闭提示信息
                            table.reload('customer');
                        },
                        error:function (res) {
                            console.log(res)
                        }

                    })
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                    console.log(data);
                layer.open({
                    title:'修改客户信息',
                    type: 2,
                    area:['350px','400px'],
                    btn: ['确认', '取消'], //可以无限个按钮
                    content:'${request.contextPath}/customer/customerLayer?id='+data.id //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    ,yes: function(index, layero){
                        //按钮【按钮一】的回调
                        // alert("yes")
                        layerIndex=index;
                        //获取form表单
                        var submitForm = layer.getChildFrame('form', index);
                        console.log(submitForm)
                        //获取表单里面的“新增”按钮
                        var submitButton = submitForm.find("button");
                        console.log(submitButton)
                        submitButton.click();
                    }
                });
            }
        });

    //    清空按钮#id选择器
        $("#reset").click(function () {
            $("input[name='customername']").val('');
            $("input[name='telephone']").val('');
            $("input[name='connectionperson']").val('');
        })
    //    查询按钮
        $("#search").click(function () {
            var customername = $("input[name='customername']").val();
            var telephone = $("input[name='telephone']").val();
            var connectionperson=$("input[name='connectionperson']").val();
            //表格重载
            table.reload("customer",{where:{customername:customername,telephone:telephone,connectionperson:connectionperson}});


        })
        //关闭弹窗
        window.closeLayer=function(){
            layer.close(layerIndex)

        }
        //    刷新客户列表，子页面要掉父页面的方法，如果不写window子页面就会拿不到。
        window.reloadCustomerList=function () {
            table.reload("customer")//单引号
        }
    });
</script>
</body>
</html>