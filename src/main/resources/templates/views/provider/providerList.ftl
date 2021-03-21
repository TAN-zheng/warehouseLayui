<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>供货管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${request.contextPath}/static/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${request.contextPath}/static/layuiadmin/style/admin.css" media="all">
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
                                <label class="layui-form-label">供应商名称</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="providername" lay-verify="" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">供应商电话</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="telephone" lay-verify="" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
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
                    <table class="layui-hide" id="supplier" lay-filter="supplier"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<#--头部按钮-->
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <#--        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>-->
        <#--        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>-->
        <#--        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>-->
        <button class="layui-btn layui-btn-sm" lay-event="add">新增</button>
        <button class="layui-btn layui-btn-sm" lay-event="multiDelete">批量删除</button>
    </div>
</script>
<#--表格最后一列的操作键-->
<script type="text/html" id="bar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<#--引入js-->
<script src="${request.contextPath}/static/layuiadmin/layui/layui.js"></script>
<script>
<#--    需要用到什么就需要在layui.use(['table','jquery','layer'], function(){})
        在里面的加入:table,jquery,layer等。
-->
    layui.use(['table','jquery','layer'], function(){
        var table = layui.table;
        //引入layui内部的jquery后需要定义的变量。
        var $=layui.$;
        //关闭子页面的变量申明
        var layer = layui.layer;
        //定义了一个全局变量。
        var layerIndex='';
        //数据表的格式
        table.render({
            //选中数据表格的id
            elem: '#supplier'
            //controller里面的访问方法的路径。
            ,url:'${request.contextPath}/provider/getPageList'
            //ajax的提交方式
            ,method:'post'
            //定义数据的返回格式是以什么返回到前端。
            ,contentType:'application/json'
            ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                //是否能被选中。
                {type: 'checkbox', fixed: 'left'}
                //下面的field是数据库里面的对应字段，title是前端页面展示的表头。
                ,{field:'id', title:'供应商ID'}
                ,{field:'providername', title:'供应商名称'}
                ,{field:'zip', title:'供应商邮编'}
                ,{field:'address', title:'供应商地址'}
                ,{field:'telephone', title:'供应商电话'}
                ,{field:'connectionperson', title:'联系人'}
                ,{field:'phone', title:'联系人电话'}
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
        table.on('toolbar(supplier)', function(obj){
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


                    //这是一个弹出层(iframe)的子页面
                    layer.open({
                        title:'新增客户信息',
                        //type属性值，为2的时候是iframe子页面
                        type: 2,
                        //设置宽高
                        area:['950px','400px'],
                        //设置子页面里面的按钮
                        btn: ['确认', '取消'], //可以无限个按钮
                        //点击id为add的按钮时，去寻找目标路径的子页面。
                        content:['${request.contextPath}/provider/providerLayer' ,'no']//这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

                        //确认按钮的事件的响应操作。
                        ,yes: function(index, layero){
                            //按钮【按钮一】的回调
                            // alert("yes")
                            //给全局变量赋值
                            layerIndex=index;
                            //获取form表单,拿到子页面的表单在父页面进行提交表单。
                            var submitForm = layer.getChildFrame('form', index);
                            console.log(submitForm)
                            //获取，拿到这个表单里面的“新增”按钮属性。点父页面的提交触发子页面的提交按钮。
                            var submitButton = submitForm.find("button");
                            console.log(submitButton)
                            //触发
                            submitButton.click();
                        }
                    });
                    break;

                //    批量删除供应商信息
                case'multiDelete':
                    layer.confirm('真的删除这些数据吗？', function(index){
                        // obj.del();
                        //定义一个数组来存放选中的id框。
                        var idAry=[];
                        //这是复选框被选中的对象。
                        var data=checkStatus.data;
                        console.log(data)
                        for (var  i=0;i<data.length;i++){
                            //遍历选中对象的数组长度。
                            var id=data[i].id;
                            //把id遍历出来，压栈到集合数组里面，
                            idAry.push(id);
                        }
                        console.log(idAry);
                        $.ajax({
                            type:'post',
                            //后台地址,提交后腰判断他是添加还是更改。
                            url:'${request.contextPath}/provider/deleteProviderByIds',
                            //json方法,相当于是请求头
                            // contentType:'application/json;charset=UTF-8',因为只传一个id，所以不用转json
                            //把数据转成json的字符串
                            // data:JSON.stringify(data.field),

                            //直接拼接字符串，相当于传参数。相当于parameter一样。
                            // 把数组赋值给ids.controller层使用List接收的
                            data:'ids='+idAry,
                            //
                            success:function (res) {
                                //打印信息
                                layer.msg(res.msg);
                                //关闭弹窗
                                layer.close(index);//关闭提示信息
                                //重新刷新表格
                                table.reload('supplier');
                            },
                            error:function (res) {
                                console.log(res)
                            }

                        })
                        //关闭弹窗
                        layer.close(index);
                    });
            };
        });

        //监听行工具事件
        table.on('tool(supplier)', function(obj){
            var data = obj.data;
            console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除这条数据吗？', function(index){
                    // obj.del();
                    $.ajax({
                        type:'post',
                        //后台地址,提交后腰判断他是添加还是更改。
                        url:'${request.contextPath}/provider/deleteProviderByIds',
                        //json方法,相当于是请求头
                        // contentType:'application/json;charset=UTF-8',因为只传一个id，所以不用转json
                        //把数据转成json的字符串
                        // data:JSON.stringify(data.field),

                        //直接拼接字符串，相当于传参数。相当于parameter一样。
                        data:'ids='+data.id,
                        //
                        success:function (res) {
                            //显示提示信息
                            layer.msg(res.msg);
                            //关闭窗口
                            layer.close(index);//关闭提示信息
                            //重新刷新页面
                            table.reload('supplier');
                        },
                        error:function (res) {
                            //打印提示信息
                            console.log(res)
                        }

                    })
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                console.log(data);
                /*
                * 弹出修改子页面
                * */
                layer.open({
                    title:'修改客户信息',
                    type: 2,
                    area:['950px','400px'],
                    btn: ['确认', '取消'], //可以无限个按钮
                    //访问controller跳转页面。
                    content:['${request.contextPath}/provider/providerLayer?id='+data.id,'no']//这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    //确认按钮点击的效果设置
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
                        //触发确认按钮。
                        submitButton.click();
                    }
                });
            }
        });

    // 清空按钮，的操作实现。要用到jQuery。
        /*
        * 一、绑定
        * 1、绑定id:"#rest"
        * 2、事件click(),点击事件产生的效果
        * 3、通过回调函数function (){}来实现具体的功能。
        *
        * 二、jquery的格式
        * 1、jquery的格式:$("").xxx();
        *   (1)$里面的参数：a.字符串,b.标签,c.选择器
        * 二、拿到输入框的数据,
        * 1、先通过标签拿到元素，在通过name属性拿到具体的。进行设置清空。
        * 2、
        * */
        $("#reset").click(function () {
        //name选择器拿到指定元素的标签
            $("input[name='providername']").val('');
            $("input[name='telephone']").val('');
            $("input[name='connectionperson']").val('');
        })
    //    查询按钮，功能实现。
        /*
        * 原理同上，清空按钮
        * */
        $("#search").click(function () {
               var providername = $("input[name='providername']").val();
               var telephone =$("input[name='telephone']").val();
               var connectionperson =$("input[name='connectionperson']").val();
        //       表格重载，点击查询后，需要对表格进行重新加载。
            table.reload("supplier",{where:{providername:providername,telephone:telephone,connectionperson:connectionperson}});
        })

        //关闭弹窗
        window.closeLayer=function(){
            //传入全局变量index，这个index绑定了【确认】按钮
            layer.close(layerIndex)
        }
        /*
        * 原因：新增后页面还没刷新，数据应该刷新显示。
        * */
        //    刷新客户列表，子页面要掉父页面的方法，如果不写window子页面就会拿不到。
        window.reloadProviderList=function () {
            table.reload("supplier")//单引号
        }
    });
</script>
</body>
</html>