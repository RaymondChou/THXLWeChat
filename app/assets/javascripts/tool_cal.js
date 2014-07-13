//获取车型信息
function loadCarInfoData(carId) {
  try {
    $.ajax({
      url: "/handlers/GetCarPriceJson.ashx?carid=" + carId,
      cache: false,
      success: function (json) {
        var carInfo = eval("(" + json + ")");
        //var carInfo = $.parseJSON(json);
        $("#select_carname").html("" + carInfo.YearType + "款 " + carInfo.SerialShowName + " " + carInfo.Name + "");
      }
    });
  } catch (e) { }
  resetPrice(carId);
}
//购置税
function calcAcquisitionTax() {
  var AcquisitionTax = parseFloat($('#show_money').val()) / (1 + 0.17) * 0.1;
  $('#show_gouzhitax').html(Math.round(AcquisitionTax) + "元");
}
//上牌费用

//交强险
function calcCompulsory() {
  var v = $("input[name='r_jiaoqiang']").eq(0).attr("checked");
  if (v)
    $("#show_jiaoqiang").html("950元");
  else
    $("#show_jiaoqiang").html("1100元");
}
//商业险
//第三责任险
function calcTPL() {
  var jdata1 = { j0: 0, j5: 516, j10: 746, j20: 924, j50: 1252, j100: 1630 };
  var jdata2 = { j0: 0, j5: 478, j10: 674, j20: 821, j50: 1094, j100: 1425 };
  var v = $("input[name='thirdInsurance']:checked").val();
  var is6Zuo = $("input[name='r_jiaoqiang']").eq(0).attr("checked");
  var jdata = is6Zuo ? jdata1 : jdata2;
  var reuslt;
  switch (v) {
    case "0": reuslt = jdata["j0"]; break;
    case "5": reuslt = jdata["j5"]; break;
    case "10": reuslt = jdata["j10"]; break;
    case "20": reuslt = jdata["j20"]; break;
    case "50": reuslt = jdata["j50"]; break;
    case "100": reuslt = jdata["j100"]; break;
    default: reuslt = 0; break;
  }
  $("#show_zeren").html(reuslt + "元");
}
//车辆损失险
function calcCarDamage() {
  if ($("#show_sunshi").parent().attr("class") == "off") {
    $('#show_sunshi').html("0元");
  } else {
    var v = ($("input[name='r_jiaoqiang']").eq(1).attr("checked") ? 550 : 459); //是否是6座以上
    var m = Math.round($('#show_money').val() * 0.01088 + v);
    $('#show_sunshi').html(m + "元");
  }
}
//全车盗抢险
function calcCarTheft() {
  if ($("#show_sunshi").parent().attr("class") == "off" || $("#show_daoqiang").parent().attr("class") == "off") {
    $("#show_daoqiang").parent().attr("class", "off");
    $("#even_daoqiang").html("关<s></s>");
    $("#show_daoqiang").html("0元");
  } else {
    if ($("input[name='r_jiaoqiang']").eq(1).attr("checked"))//是否是6座以上
      $('#show_daoqiang').html(Math.round($('#show_money').val() * 0.00374 + 119) + "元");
    else
      $('#show_daoqiang').html(Math.round($('#show_money').val() * 0.004505 + 102) + "元");
  }
}
//玻璃单独破碎险
function calcBreakageOfGlass() {
  var isGuochan = $("input[name='r_boliposui']:checked").val();
  if (isGuochan == "0") {
    $("#show_boliposui").html("0元");
  } else {
    if (isGuochan == "1")
      $('#show_boliposui').html(Math.round($('#show_money').val() * 0.0025) + "元");
    else if (isGuochan == "2")
      $('#show_boliposui').html(Math.round($('#show_money').val() * 0.0015) + "元");
  }
}
//自然损失险
function calcSelfignite() {
  if ($("#show_ziransunshi").parent().attr("class") == "off") {
    $("#show_ziransunshi").html("0元");
  } else {
    $('#show_ziransunshi').html(Math.round($('#show_money').val() * 0.0015) + "元");
  }
}
//不计免赔特约险
function calcAbatement() {
  var zeren = $("input[name='thirdInsurance']:checked").val(); //第三责任险
  if ($("#show_sunshi").parent().attr("class") == "off" //车辆损失险
      || zeren == "0"
      || $("#show_bujimianpei").parent().attr("class") == "off") {
    $("#show_bujimianpei").parent().attr("class", "off");
    $("#even_bujimianpei").html("关<s></s>");
    $("#show_bujimianpei").html("0元");
  } else {
    var total = parseInt($('#show_sunshi').html()) + parseInt($("#show_zeren").html());
    $('#show_bujimianpei').html(Math.round(total * 0.2) + "元");
  }
}
//无过责任险
function calcBlameless() {
  var zeren = $("input[name='thirdInsurance']:checked").val(); //第三责任险
  if (zeren == "0"
      || $("#show_wuguozeren").parent().attr("class") == "off") {
    $("#show_wuguozeren").parent().attr("class", "off");
    $("#even_wuguozeren").html("关<s></s>");
    $("#show_wuguozeren").html("0元");
  } else {
    $('#show_wuguozeren').html(Math.round(parseInt($('#show_zeren').html()) * 0.2) + "元");
  }
}
//车上人员责任险
function calcLimitofPassenger() {
  if ($("#show_renyuanzeren").parent().attr("class") == "off") {
    $("#show_renyuanzeren").html("0元");
  } else {
    $("#show_renyuanzeren").html("50元");
  }
}
//车身划痕险
function calcCarDamageDW() {
  var jdata1 = { j2000: 400, j5000: 570, j10000: 760, j20000: 1140 };
  var jdata2 = { j2000: 850, j5000: 1100, j10000: 1500, j20000: 2250 };
  var jdata3 = { j2000: 585, j5000: 900, j10000: 1170, j20000: 1780 };
  var v = $("input[name='r_cheshenhuahen']:checked").val();
  var money = parseInt($("#show_money").val());
  var jdata;
  if (money < 300000) {
    jdata = jdata1;
  } else if (money > 500000) {
    jdata = jdata2;
  } else {
    jdata = jdata3;
  }
  var result = 0;
  if ($("#show_sunshi").parent().attr("class") == "off") {
    $("input[name='r_cheshenhuahen'][value=0]").attr("checked", true);
  }
  else {
    switch (v) {
      case "2000": result = jdata["j2000"]; break;
      case "5000": result = jdata["j5000"]; break;
      case "10000": result = jdata["j10000"]; break;
      case "20000": result = jdata["j20000"]; break;
      default: break;
    }
  }
  $("#show_cheshenhuahen").html(result + "元");
}

//商业险
function calcCommonTotal() {
  var commonTotal = 0;
  commonTotal += parseFloat($("#show_zeren").html());
  commonTotal += parseFloat($("#show_sunshi").html());
  commonTotal += parseFloat($("#show_daoqiang").html());
  commonTotal += parseFloat($("#show_boliposui").html());
  commonTotal += parseFloat($("#show_ziransunshi").html());
  commonTotal += parseFloat($("#show_bujimianpei").html());
  commonTotal += parseFloat($("#show_wuguozeren").html());
  commonTotal += parseFloat($("#show_renyuanzeren").html());
  commonTotal += parseFloat($("#show_cheshenhuahen").html());
  $('#show_shangye').html(Math.round(commonTotal) + "元");
}
//计算全款
function calcTotal() {
  //	if (!ValidateVehicleAndVesselTax()) {
  //		return;
  //	}
  var moneyTotal = Math.round(parseFloat($('#show_money').val()) + parseFloat($('#show_gouzhitax').html()) +
      parseFloat($('#show_chepai').html()) + parseFloat($('#show_chechuantax').html()) +
      parseFloat($('#show_jiaoqiang').html()) + parseFloat($('#show_shangye').html()));

  $("#show_total").html(moneyTotal + "元");
}
//检查车价格
function checkMoneyValidation() {
  var money = $('#show_money').val();
  if (isNaN(money)) {
    alert("请输入数字!");
    $('#show_money').val("").focus();
    return false;
  }
  if (parseInt(money) == 0 || money == "") {
    return false;
  }
  if (parseInt(money) != 0 && (parseInt(money) < 20000 || parseInt(money) > 99999999)) {
    alert("请输入正确的价格！");
    $('#show_money').val("").focus();
    return false;
  }
  return true;
}
//======================车船使用税==============================
//车船使用税信息
var vehicleAndVesselTaxInfos = {
  1: {
    Level: 1,
    MinDisplacement: 0,
    MaxDisplacement: 1.0,
    DisplacementDescription: "1.0L(含)以下",
    Tax: 300
  },
  2: {
    Level: 2,
    MinDisplacement: 1.0,
    MaxDisplacement: 1.6,
    DisplacementDescription: "1.0-1.6L(含)",
    Tax: 420,
    IsDefault: true
  },
  3: {
    Level: 3,
    MinDisplacement: 1.6,
    MaxDisplacement: 2.0,
    DisplacementDescription: "1.6-2.0L(含)",
    Tax: 480
  },
  4: {
    Level: 4,
    MinDisplacement: 2.0,
    MaxDisplacement: 2.5,
    DisplacementDescription: "2.0-2.5L(含)",
    Tax: 900
  },
  5: {
    Level: 5,
    MinDisplacement: 2.5,
    MaxDisplacement: 3.0,
    DisplacementDescription: "2.5-3.0L(含)",
    Tax: 1920
  },
  6: {
    Level: 6,
    MinDisplacement: 3.0,
    MaxDisplacement: 4.0,
    DisplacementDescription: "3.0-4.0L(含)",
    Tax: 3480
  },
  7: {
    Level: 7,
    MinDisplacement: 4.0,
    MaxDisplacement: Number.MAX_VALUE,
    DisplacementDescription: "4.0L以上",
    Tax: 5280
  }
};
//根据排量获得车船使用税信息
function GetVehicleAndVesselTaxInfo(dispplacement) {
  for (var taxLevel in vehicleAndVesselTaxInfos) {
    if (dispplacement > vehicleAndVesselTaxInfos[taxLevel].MinDisplacement
        && dispplacement <= vehicleAndVesselTaxInfos[taxLevel].MaxDisplacement) {
      return vehicleAndVesselTaxInfos[taxLevel];
    }
  }
}
//车船使用税减免信息
var vehicleAndVesselTaxRelief;

function resetPrice(carId) {
  $.ajax({
    url: "/handlers/GetCarInfoForCalcTools.ashx?type=jsonwithname&carId=" + carId,
    cache: true,
    dataType: "script",
    success: function () {
      if (typeof tmpCarInfo == "undefined")
        return;
      var json = tmpCarInfo;
      //设置车款金额
      $("#show_money").val(Math.round(json.referPrice * 10000));
      $(".selected-car span").html();
      //车船使用税
      var rdoVehicleTax = $("#show_chechuantax");
      //交强险
      if (json.seatNum != "0" && json.seatNum > 6) {
        $("input[name='r_jiaoqiang']").eq(1).attr("checked", true);
      }
      else {
        $("input[name='r_jiaoqiang']").eq(0).attr("checked", true);
      }
      //是否国产
      if (json.isGuoChan == "" || json.isGuoChan == "True") {
        $("input[name='r_boliposui']").eq(2).attr("checked", true);
      }
      else {
        $("input[name='r_boliposui']").eq(1).attr("checked", true);
      }
      //根据排量选择车船税的级别
      var displacement = json.exhaustforfloat;
      var vehicleAndVesselTaxInfo = GetVehicleAndVesselTaxInfo(displacement);
      if (typeof vehicleAndVesselTaxInfo != "undefined")
        $("input[name='r_checuantax'][value=" + vehicleAndVesselTaxInfo.Level + "]").attr("checked", true);
      //车船使用税减免信息
      vehicleAndVesselTaxRelief = json.traveltax;
      //		//计算车船使用税
      //		CalculateVehicleAndVesselTax();
      //		calcTotal();
      calcAutoCashAll();
      //设置车型信息标签传递
      setCalcToolUrl(carId);
      $("#container").show();
      $("#master_container,#carinfo_container").hide();
    }
  });
}

//车船使用税
function CalculateVehicleAndVesselTax() {
  var taxLevel = $("input[name='r_checuantax']:checked").val();

  var vehicleAndVesselTaxValue = vehicleAndVesselTaxInfos[taxLevel].Tax;
  //var vehicleAndVesselTaxMessage = GetVehicleAndVesselTaxMessage();
  //车船使用税一般只能缴纳当年的，按月计算
  vehicleAndVesselTaxValue = vehicleAndVesselTaxValue * (12 - new Date().getMonth()) / 12;
  //计算车船使用税减免
  if (vehicleAndVesselTaxRelief == "免征") {
    vehicleAndVesselTaxValue = 0;
  }
  else if (vehicleAndVesselTaxRelief == "减半") {
    vehicleAndVesselTaxValue = vehicleAndVesselTaxValue / 2;
  }
  $('#show_chechuantax').html(Math.ceil(vehicleAndVesselTaxValue) + "元");
}
//设置连接地址
function setCalcToolUrl(carId) {
  var is6zuo = $("input[name='r_jiaoqiang']").eq(0).attr("checked");
  var compulsoryIdx = is6zuo ? 0 : 1;
  if (carId > 0)
    $(".m-tabs a").each(function () {
      var url = $(this).attr("href");
      var paraIndex = url.indexOf("?");
      if (paraIndex > 0)
        url = url.substring(0, paraIndex);
      if ($(this).html() == "保险计算")
        url += "?CarPrice=" + $("#show_money").val() + "&CompulsoryIdx=" + compulsoryIdx;
      else
        url += "?carid=" + carId;
      $(this).attr("href", url);
    });
}
//==========================通用方法=================================
//格式化字符串占位符
function formatString() {
  if (arguments.length == 0)
    return null;
  var str = arguments[0];
  var obj = arguments[1];
  for (var key in obj) {
    var re = new RegExp('\\{' + key + '\\}', 'gi');
    str = str.replace(re, obj[key]);
  }
  return str;
}
//格式化千位符
function formatCurrency(num) {
  num = num.toString().replace(/\$|\,/g, '');
  if (isNaN(num)) num = "0";
  sign = (num == (num = Math.abs(num)));
  num = Math.floor(num * 100 + 0.50000000001);
  num = Math.floor(num / 100).toString();
  for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
    num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
  return (((sign) ? '' : '-') + num);
}
//==========================汽车贷款=================================
//首付款：默认选择30%， 首付款=购车价格×首付比例，也可以不管首付比例，手动填写。
function calcDownPayments() {
  var shoufu = $("#s_shoufu a.current").eq(0).html().trim();
  var result = 0;
  switch (shoufu) {
    case "30%": result = 0.3; break;
    case "40%": result = 0.4; break;
    case "50%": result = 0.5; break;
    case "60%": result = 0.6; break;
    case "70%": result = 0.7; break;
    default: break;
  }
  return (Math.round($('#show_money').val() * result));
}
//贷款额=车辆购置价格-首付款
function calcLoanValue() {
  var loanValue = 0;
  loanValue = parseInt($('#show_money').val()) - parseInt(calcDownPayments());
  //alert(parseInt($('#show_money').val()));
  $('#show_daikuan').html(loanValue + "元");
}
//月首付
function calcMonthPayments() {
  var monthPercent = 0.005467;
  var loanMonths = 12;
  var years = parseInt($("#s_daikuan a.current").eq(0).html());
  switch (years) {
    case 1:
      monthPercent = 0.005125;
      break;
    case 2:
    case 3:
      monthPercent = 0.005125;
      break;
    case 4:
    case 5:
      monthPercent = 0.005333;
      break;
  }
  loanMonths = years * 12;
  $("#show_month").html("(" + loanMonths + "期)");
  var daikuan = Math.round(parseInt($('#show_daikuan').html()) * monthPercent * Math.pow((1 + monthPercent), loanMonths) / (Math.pow((1 + monthPercent), loanMonths) - 1));
  $('#show_yuefu').html(daikuan + "元");
}
//首付款总额=首付款+必要花费+商业保险
function calcFirstDownPayments() {
  //	if (!ValidateVehicleAndVesselTax()) {
  //		return;
  //	}
  var firstDownPayments = 0;
  firstDownPayments = parseInt(calcDownPayments()) +
      parseInt($('#show_gouzhitax').html()) +
      parseInt($('#show_chepai').html()) +
      parseInt($('#show_chechuantax').html()) +
      parseInt($('#show_jiaoqiang').html()) +
      parseInt($('#show_shangye').html());
  $('#show_shoufu').html(firstDownPayments + "元");
}
//计算贷款统计信息
function calcLoanTotal() {
  var month = parseInt($("#s_daikuan a.current").eq(0).html()) * 12;
  var total = parseInt($("#show_shoufu").html()) + month * parseInt($('#show_yuefu').html());
  var lixi = parseInt($('#show_yuefu').html()) * month - parseInt($("#show_daikuan").html());
  $("#show_loantotal").html("总计花费：" + formatCurrency(total) + "元，支付利息：" + formatCurrency(lixi) + "元");
}
//=========================保险=====================================
//计算公司报价
function calcCompany() {
  var is6zuo = $("input[name='r_jiaoqiang']").eq(0).attr("checked");
  var companyTotal = parseFloat($('#show_jiaoqiang').html()) + parseFloat($('#show_shangye').html());
  $("#show_company").html(companyTotal + "元");
}
//计算市场报价
function calcMarket() {
  var MarketTotal = (parseInt(parseFloat($('#show_jiaoqiang').html()) + (parseFloat($('#show_shangye').html()) * 0.7)));
  $("#show_market").html(MarketTotal + "元");
}