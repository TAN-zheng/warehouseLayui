<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${request.contextPath}/static/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${request.contextPath}/static/layuiadmin/style/admin.css" media="all">
</head>
<body style="background-color: #FAFAFA;">
<div style="padding: 20px; ">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">
                    <form class="layui-form" action="">
                        <div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">供应商</label>
                                <div class="layui-input-inline">
                                    <select id="sele" name="providername" lay-filter="providername">
                                        <option value="" selected=""></option>
                                        <option value="旺旺食品">旺旺食品</option>
                                        <option value="达利园食品">达利园食品</option>
                                        <option value="娃哈哈集团">娃哈哈集团</option>
                                        <option value="哇哈哈">哇哈哈</option>
                                        <option value="小米锅巴">小米锅巴</option>
                                    </select>
                                </div>
                                <label class="layui-form-label">商品名称</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="goodsname" lay-verify="required"
                                           autocomplete="off" class="layui-input">
                                </div>
                                <label class="layui-form-label">生产批号</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="productcode" lay-verify="required"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">批准文号</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="promitcode" lay-verify="required"
                                           placeholder="请输入" autocomplete="off" class="layui-input">
                                </div>
                                <label class="layui-form-label">商品描述</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="description" lay-verify="required"
                                           placeholder="请输入" autocomplete="off" class="layui-input">
                                </div>
                                <label class="layui-form-label">商品规格</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="gsize" lay-verify="required"
                                           placeholder="请输入" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-row layui-col-space10">
                            <div class="layui-col-md4 layui-col-md-offset4">
                                <button type="button" id="search" class="layui-btn layui-btn-normal">查询</button>
                                <button type="button" id="reset" class="layui-btn layui-btn-warm">清空</button>
                            </div>
                        </div>
                    </form>
                    <#--                    数据表格-->
                    <table class="layui-hide" id="goods" lay-filter="goods"></table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <#--<button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>-->
        <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
    </div>
</script>

<script type="text/html" id="bar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script src="${request.contextPath}/static/layuiadmin/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述 JS 路径需要改成你本地的 -->

<script>
    layui.use(['table', 'jquery'], function () {
        var table = layui.table;
        //引入layui内部的jquery后需要定义的变量。
        var $ = layui.$;
        table.render({
            elem: '#goods'
            , url: '${request.contextPath}/goods/getGoodsList'
            , method: 'post'
            , contentType: 'application/json'
            , toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: '商品ID', width: 80, fixed: 'left', unresize: true}
                , {field: 'goodsname', title: '商品名称', width: 120}
                , {field: 'providername', title: '供应商', width: 120}
                , {field: 'produceplace', title: '产地', width: 80}
                , {field: 'gsize', title: '规格', width: 100}
                , {field: 'goodspackage', title: '包装'}
                , {field: 'productcode', title: '生产批号'}
                , {field: 'promitcode', title: '批准文号', width: 80}
                , {fixed: 'right', title: '操作', toolbar: '#bar', width: 150}
            ]]
            , page: true
        });

        //头工具栏事件
        table.on('toolbar(goods)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：' + data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选' : '未全选');
                    break;
                    case 'add':
                        //这是一个弹出层(iframe)的子页面
                        layer.open({
                            title:'新增商品信息',
                            //type属性值，为2的时候是iframe子页面
                            type: 2,
                            //设置宽高
                            area:['950px','450px'],
                            //设置子页面里面的按钮
                            btn: ['确认', '取消'], //可以无限个按钮
                            //点击id为add的按钮时，去寻找目标路径的子页面。
                            content:['${request.contextPath}/goods/toGoodsLayer']//这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

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

                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
            }
            ;
        });

        //监听行工具事件
        table.on('tool(goods)', function (obj) {
            var data = obj.data;
            //console.log(obj)
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {


                layer.open({
                    title:'修改客户信息',
                    type: 2,
                    area:['950px','400px'],
                    btn: ['确认', '取消'], //可以无限个按钮
                    //访问controller跳转页面。
                    content:['${request.contextPath}/goods/toGoodsLayer?id='+data.id]//这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
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

        //    查询按钮
        $("#search").click(function () {
            var providername = $("input[name='providername']").val();
            var goodsname = $("input[name='goodsname']").val();
            var productcode = $("input[name='productcode']").val();
            var promitcode = $("input[name='promitcode']").val();
            var description = $("input[name='description']").val();
            var gsize = $("input[name='gsize']").val();
            //       表格重载，点击查询后，需要对表格进行重新加载。
            table.reload("supplier", {
                where: {
                    providername: providername,
                    goodsname: goodsname,
                    productcode: productcode,
                    promitcode: promitcode,
                    description: description,
                    gsize: gsize
                }
            });
        });
        //    清空按钮
        $("#reset").click(function () {
            $("input[name='goodsname']").val("");
            $("input[name='promitcode']").val("");
            $("input[name='productcode']").val("");
            $("input[name='gsize']").val("");
            $("input[name='description']").val("");
        });
    });
</script>
</body>
</html>