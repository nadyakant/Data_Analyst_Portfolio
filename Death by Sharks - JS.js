var chart1 = new CanvasJS.Chart("chartContainer1", {
  animationEnabled: true,
  title: {
    text: "Spline Area Chart"
  },
  axisX: {
    interval: 1,
  },
  data: [
    {
      type: "splineArea",
      color: "rgba(250,128,114,.3)",
      dataPoints: [
        { x: new Number(10.00), y: 62 },
        { x: new Number(11.00), y: 120 },
        { x: new Number(12.00), y: 111 },
        { x: new Number(13.00), y: 72 },
        { x: new Number(14.00), y: 98 },
        { x: new Number(15.00), y: 107 },
        { x: new Number(16.00), y: 101 },
        { x: new Number(17.00), y: 68 },
        { x: new Number(18.00), y: 68 },
        { x: new Number(19.00), y: 24 },
        { x: new Number(20.00), y: 12, indexLabel: "safest h", markerColor: "rgba(46,139,87)", markerType: "triangle" }
      ]
    },
  ]
});
chart1.render();

var chart2 = new CanvasJS.Chart("chartContainer2", {
  animationEnabled: true,
  title: {
    text: "Fatality in Shark Attack Cases",
  },
  data: [
    {
      type: "pie",
      showInLegend: true,
      dataPoints: [
        { y: 22, legendText: "UK", indexLabel: "Unknown",color: "rgba(255,215,0)" },
        { y: 268, legendText: "F", indexLabel: "Fatal",color: "rgba(178,34,34)" },
        { y: 2286, legendText: "N", indexLabel: "Not Fatal",color: "rgba(250,128,114)" }
      ]
    },
  ]
});
chart2.render();

var chart3 = new CanvasJS.Chart("chartContainer3", {
  animationEnabled: true,
  title: {
    text: "Fatal Cases by Year"
  },
  axisX: {
    valueFormatString: "YYYY",
    interval: 1,
    intervalType: "year"
  },
  axisY: {
    includeZero: false
  },
  data: [
    {
      type: "line",
      color: "rgba(220,20,60)",
      dataPoints: [
        { x: new Date(2009, 00, 1), y: 13 },
        { x: new Date(2010, 00, 1), y: 8 },
        { x: new Date(2011, 00, 1), y: 13 },
        { x: new Date(2012, 00, 1), y: 9 },
        { x: new Date(2013, 00, 1), y: 14, indexLabel: "most", markerColor: "#8B0000", markerType: "triangle" },
        { x: new Date(2014, 00, 1), y: 7 },
        { x: new Date(2015, 00, 1), y: 9 },
        { x: new Date(2016, 00, 1), y: 5 },
        { x: new Date(2017, 00, 1), y: 8 },
        { x: new Date(2018, 00, 1), y: 4 },
        { x: new Date(2019, 00, 1), y: 7 },
        { x: new Date(2020, 00, 1), y: 2, indexLabel: "least", markerColor: "#696969", markerType: "cross" }
      ]
    }
  ]
});
chart3.render();

var chart4 = new CanvasJS.Chart("chartContainer4", {
  animationEnabled: true,
  title: {
    text: "Fatal Cases by Country"
  },
  axisX: {
    interval: 10,
  },
  data: [
    {
      type: "column",
      legendMarkerType: "triangle",
      legendMarkerColor: "#8B0000",
      color: "rgba(250,128,114,.3)",
      showInLegend: true,
      legendText: "Highest Number of Fatal Shark Attack Cases",
      dataPoints: [
        { x: 10, y: 221, label: "Australia" },
        { x: 20, y: 126, label: "USA" },
        { x: 30, y: 86, label: "S.Africa" },
        { x: 40, y: 49, label: "Papua New Guinea" },
        { x: 50, y: 32, label: "Mexico" },
        { x: 60, y: 30, label: "Brazil" },
        { x: 70, y: 19, label: "Reunion" },
        { x: 80, y: 18, label: "Philippines" }
      ]
    },
  ]
});
chart4.render();