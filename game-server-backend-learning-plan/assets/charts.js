(function() {
  var style = getComputedStyle(document.documentElement);
  var accent = style.getPropertyValue('--accent').trim();
  var accent2 = style.getPropertyValue('--accent2').trim();
  var ink = style.getPropertyValue('--ink').trim();
  var muted = style.getPropertyValue('--muted').trim();
  var rule = style.getPropertyValue('--rule').trim();
  var bg2 = style.getPropertyValue('--bg2').trim();

  // --- Chart: Timeline ---
  var chartTimeline = echarts.init(document.getElementById('chart-timeline'), null, { renderer: 'svg' });

  var categories = [
    '阶段划分',
    'Git',
    'Spring Boot',
    'MyBatis-Plus',
    'MySQL',
    'Redis',
    'Linux',
    'Java 并发',
    'Netty',
    '游戏架构',
    '项目实战'
  ];

  var phaseColor = accent;
  var techColors = [
    '#2563eb', '#3b82f6', '#60a5fa',
    '#7c3aed', '#8b5cf6', '#a78bfa',
    '#059669', '#10b981', '#34d399',
    '#d97706', '#f59e0b'
  ];

  var rawData = [
    { name: '阶段一：现代后端基础', category: '阶段划分', start: 1, end: 10 },
    { name: '阶段二：并发与网络', category: '阶段划分', start: 11, end: 18 },
    { name: '阶段三：游戏架构与求职', category: '阶段划分', start: 19, end: 22 },
    { name: 'Git', category: 'Git', start: 1, end: 1 },
    { name: 'Spring Boot', category: 'Spring Boot', start: 2, end: 4 },
    { name: 'MyBatis-Plus', category: 'MyBatis-Plus', start: 3, end: 4 },
    { name: 'MySQL 进阶', category: 'MySQL', start: 5, end: 7 },
    { name: 'Redis', category: 'Redis', start: 7, end: 8 },
    { name: 'Linux 基础', category: 'Linux', start: 9, end: 9 },
    { name: 'Java 并发 / JUC', category: 'Java 并发', start: 11, end: 14 },
    { name: 'Netty 网络编程', category: 'Netty', start: 15, end: 18 },
    { name: '游戏服务端架构', category: '游戏架构', start: 19, end: 20 },
    { name: '项目实战与面试', category: '项目实战', start: 20, end: 22 }
  ];

  var data = rawData.map(function(item, index) {
    var catIndex = categories.indexOf(item.category);
    var color = item.category === '阶段划分' ? phaseColor : techColors[catIndex];
    return {
      name: item.name,
      value: [catIndex, item.start, item.end, item.end - item.start + 1],
      itemStyle: { color: color }
    };
  });

  function renderItem(params, api) {
    var categoryIndex = api.value(0);
    var start = api.coord([api.value(1), categoryIndex]);
    var end = api.coord([api.value(2), categoryIndex]);
    var height = api.size([0, 1])[1] * 0.55;
    var rectShape = echarts.graphic.clipRectByRect({
      x: start[0],
      y: start[1] - height / 2,
      width: end[0] - start[0],
      height: height
    }, {
      x: params.coordSys.x,
      y: params.coordSys.y,
      width: params.coordSys.width,
      height: params.coordSys.height
    });
    return rectShape && {
      type: 'rect',
      transition: ['shape'],
      shape: rectShape,
      style: api.style()
    };
  }

  chartTimeline.setOption({
    animation: false,
    tooltip: {
      trigger: 'item',
      appendToBody: true,
      formatter: function(params) {
        var v = params.value;
        return params.name + '<br/>第 ' + v[1] + ' 周 至 第 ' + v[2] + ' 周（共 ' + v[3] + ' 周）';
      }
    },
    grid: { left: '18%', right: '6%', top: '8%', bottom: '8%' },
    xAxis: {
      type: 'value',
      min: 1,
      max: 22,
      interval: 1,
      name: '周',
      nameLocation: 'end',
      splitLine: { show: true, lineStyle: { color: rule, type: 'dashed' } },
      axisLabel: { color: muted },
      axisLine: { lineStyle: { color: rule } }
    },
    yAxis: {
      type: 'category',
      data: categories,
      axisLabel: { color: ink, fontWeight: 700 },
      axisLine: { lineStyle: { color: rule } },
      splitLine: { show: false }
    },
    series: [{
      type: 'custom',
      renderItem: renderItem,
      itemStyle: { borderRadius: 4 },
      encode: { x: [1, 2], y: 0 },
      data: data
    }]
  });

  window.addEventListener('resize', function() { chartTimeline.resize(); });
})();
