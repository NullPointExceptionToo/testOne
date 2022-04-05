<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>检查单列表</title>
</head>

<body>
<div class="layui-container">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" media="all">
    <style>
        body {
            margin: 10px;
        }
    </style>
    <div class="layui-row">
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
            <div class="x-nav layui-elem-quote">
						<span class="layui-breadcrumb">
             <a><cite><i class="layui-icon" style="line-height:25px">&#xe68e  </i>首页</cite></a>
              <a><cite>检查单列表</cite></a>
            </span>
                <a class="layui-btn layui-btn-mini" style="line-height:1.0em;margin-top:1px;float:right"
                   href="${pageContext.request.contextPath}/admin/quota/protein/index" title="刷新">
                    <i class="layui-icon" style="line-height:25px">&#x1002</i></a>
            </div>
        </div>

        <a class="layui-btn layui-btn-normal" role="button"
               style="margin-right: 10px;float: right" href="${pageContext.request.contextPath}/admin/quota/protein/add">添加检查单</a>
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
            <table class="layui-table"
                   lay-data="{height: 'full-110',even: true,url:'${pageContext.request.contextPath}/admin/quota/protein/list',limits:[10,30,50,100], limit: 10,page:true,id:'id'}"
                   lay-filter=protein>
                <thead>
                <tr>
                    <th lay-data="{field:'id',align:'center', width:100, sort: true}">检查单ID</th>
                    <th lay-data="{field:'urine',align:'center', width:150, sort: true, templet: timeTpl1}">尿量</th>
                    <th lay-data="{field:'urine_protein',align:'center', width:150, sort: true, templet: timeTpl2}">尿蛋白[0.01-0.14]</th>
                    <th lay-data="{field:'urine_protein24',align:'center', width:170, sort: true, templet: timeTpl3}">24小时尿蛋白[0.0-0.2]</th>
                    <th lay-data="{field:'dateTime',align:'center', width:150, sort: true}">检查时间</th>
                    <th lay-data="{field:'hospital', align:'center',width:150, sort: true}">医院</th>
                    <th lay-data="{width:180, align:'center', toolbar: '#toolBar'}">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="toolBar">
    <a class="layui-btn layui-btn-normal layui-btn-mini" lay-event="detail">详情</a>
    <a class="layui-btn layui-btn-warm layui-btn-mini" lay-event="update">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="delete">删除</a>
</script>

<script type="text/html" id="timeTpl1">
    <div>{{d.urine.value}}
        <i class="layui-icon">&nbsp;&nbsp;&nbsp;&nbsp;</i>
    </div>
</script>
<script type="text/html" id="timeTpl2">
    <div {{# if(d.urine_protein.upOrDown == 1 || d.urine_protein.upOrDown == -1){ }} style="color: red" {{# }}}>{{d.urine_protein.value}}
        {{#  if(d.urine_protein.upOrDown == 1){ }}
        <i class="layui-icon">&#xe619;</i>
        {{# }}}
        {{#  if(d.urine_protein.upOrDown == -1){ }}
        <i class="layui-icon">&#xe61a;</i>
        {{# }}}
        {{#  if(d.urine_protein.upOrDown == 0){ }}
        <i class="layui-icon">&nbsp;&nbsp;&nbsp;&nbsp;</i>
        {{# }}}
    </div>
</script>
<script type="text/html" id="timeTpl3">
    <div {{# if(d.urine_protein24.upOrDown == 1 || d.urine_protein24.upOrDown == -1){ }} style="color: red" {{# }}}>{{d.urine_protein24.value}}
        {{#  if(d.urine_protein24.upOrDown == 1){ }}
        <i class="layui-icon">&#xe619;</i>
        {{# }}}
        {{#  if(d.urine_protein24.upOrDown == -1){ }}
        <i class="layui-icon">&#xe61a;</i>
        {{# }}}
        {{#  if(d.urine_protein24.upOrDown == 0){ }}
        <i class="layui-icon">&nbsp;&nbsp;&nbsp;&nbsp;</i>
        {{# }}}
    </div>
</script>

<script src="${pageContext.request.contextPath}/resources/layui/layui.js"></script>
<script>
    layui.use(['table', 'element', 'jquery'], function () {
        var table = layui.table,
            element = layui.element,
            $ = layui.jquery;
        //监听导航点击
        element.on('nav(demo)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());
        });
        //监听工具条
        table.on('tool(protein)', function (obj) {
            var data = obj.data;

            if (obj.event === 'delete') {
                layer.confirm('确定要删除该检查单吗？宝', {
                    btn: ['确定', '取消'] //按钮
                }, function () {
                    layer.closeAll();
                    $.post("${pageContext.request.contextPath}/admin/quota/protein/del", {id: data.id}, function (data) {
                        if ("success"==data) {
                            //如果删除成功,则刷新页面
                            layer.msg('删除成功!', {icon: 1});
                            window.location.reload(); //刷新当前页面
                        }
                    }).error(function () {
                        layer.msg('删除失败!', {icon:5});
                    });
                });
            }
            
            if (obj.event === 'detail') {
                window.location.href = '${pageContext.request.contextPath}/admin/quota/protein/detail/' + data.id;
            }
            if (obj.event === 'update') {
                window.location.href = '${pageContext.request.contextPath}/admin/quota/protein/update/' + data.id;
            }
        });
        //弹出层
        var msg = "${msg}";
        if (msg.length != "") {
            layer.msg(msg, {icon: 6});
            $("#msg").text("");
        }
    });
</script>
</body>

</html>