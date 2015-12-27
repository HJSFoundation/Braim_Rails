function ELSPlugin()
{
  return document.getElementById('plugin0');
}

function onloadPluginEmotiv()
{
  var isInternetExplorer = !!navigator.userAgent.match(/Trident.*rv\:11\./);
  if(!checkPluginExits()&&!isInternetExplorer)
  {
    var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
    if(is_chrome)
    {
      var chromeVersion = navigator.userAgent.match(/Chrom(e|ium)\/([0-9]+)\./);
      chromeVersion = chromeVersion ? parseInt(chromeVersion[2], 10) : false
      if(chromeVersion>=45)
      {
        alert("Your browser is Google's Chrome version 45 or higher which is not support our plugin. Please run the Cpanel website with Google's Chrome version lower 45 or another Web Browsers. Thanks.");
      }       
      else
      {
        alert("Did you install plugin or enable NPAPI? Please read instruction for more detail.");
        window.location.href=('Download/instruction.html');
      }
    }
    else
    {
      var confirmDownload = confirm("Please download and install Emotiv plugin before continuing. You may need to restart your browser to complete installation.");
      if (confirmDownload == true)
      {
        window.location.href=('Download/download.php');
      }
    }
  }
  else
  {
    var version = ELSPlugin().version;
    if(version==undefined&&isInternetExplorer)
    {
      var confirmDownload = confirm("Please download and install Emotiv plugin before continuing. You may need to restart your browser to complete installation.");
      if (confirmDownload == true)
      {
        window.location.href=('Download/download.php');
      }
    }
    if (version!=null)
    {
      if((platform.os.family == "OS X")||(platform.os.family == "iOS"))
       {
            if(version != "1.9.1.0")
      {
       var confirmUpdate = confirm("Please update new version of Emotiv plugin. You may need to restart your browser to complete installation.");
       if (confirmUpdate == true)
       {
        window.location.href=('Download/download.php');
       }
      }
       }
       else
       {
            if(version != "1.9.0.9")
      {
       var confirmUpdate = confirm("Please update new version of Emotiv plugin. You may need to restart your browser to complete installation.");
       if (confirmUpdate == true)
       {
        window.location.href=('Download/download.php');
       }
      }
       }
    }
  }
};

/*

function onloadPluginEmotiv()
{
  var isInternetExplorer = !!navigator.userAgent.match(/Trident.*rv\:11\./);
  if(!checkPluginExits()&&!isInternetExplorer)
  {
    var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
    if(is_chrome)
    {
      var chromeVersion = navigator.userAgent.match(/Chrom(e|ium)\/([0-9]+)\./);
      chromeVersion = chromeVersion ? parseInt(chromeVersion[2], 10) : false
      if(chromeVersion>=45)
      {
        alert("Your browser is Google's Chrome version 45 or higher which is not support our plugin. Please run the Cpanel website with Google's Chrome version lower 45 or another Web Browsers. Thanks.");
      }       
      else
      {
        alert("Did you install plugin or enable NPAPI? Please read instruction for more detail.");
        window.location.href=('https://cpanel.emotivinsight.com/BTLE/Download/instruction.html');
      }
    }
    else
    {
      var confirmDownload = confirm("Please download and install Emotiv plugin before continuing. You may need to restart your browser to complete installation.");
      if (confirmDownload == true)
      {
        window.location.href=('https://cpanel.emotivinsight.com/BTLE/Download/download.php');
      }
    }
  }
  else
  {
    var version = ELSPlugin().version;
    if(version==undefined&&isInternetExplorer)
    {
      var confirmDownload = confirm("Please download and install Emotiv plugin before continuing. You may need to restart your browser to complete installation.");
      if (confirmDownload == true)
      {
        window.location.href=('https://cpanel.emotivinsight.com/BTLE/Download/download.php');
      }
    }
    if (version!=null)
    {
      if((platform.os.family == "OS X")||(platform.os.family == "iOS"))
       {
      <?php
      // load file xml
      $xml = simplexml_load_file ( "https://cpanel.emotivinsight.com/BTLE/Download/version.xml" ) or die ( "Unable to load XML file." );
      foreach ( $xml->version->Mac as $version )
      ?>
      if(version != "<?php echo $version->number;?>")
      {
       var confirmUpdate = confirm("Please update new version of Emotiv plugin. You may need to restart your browser to complete installation.");
       if (confirmUpdate == true)
       {
        window.location.href=('https://cpanel.emotivinsight.com/BTLE/Download/download.php');
       }
      }
       }
       else
       {
        
      <?php
      // load file xml
      $xml = simplexml_load_file ( "https://cpanel.emotivinsight.com/BTLE/Download/version.xml" ) or die ( "Unable to load XML file." );
      foreach ( $xml->version->Windows as $version )
      ?>
      
      if(version != "<?php echo $version->number;?>")
      {
       var confirmUpdate = confirm("Please update new version of Emotiv plugin. You may need to restart your browser to complete installation.");
       if (confirmUpdate == true)
       {
        window.location.href=('https://cpanel.emotivinsight.com/BTLE/Download/download.php');
       }
      }
       }
    }
  }
};

*/

//check plugin is exist
function checkPluginExits()
{
  var L = navigator.plugins.length;
  for(var i = 0; i < L; i++)
  {
    console.log(
      navigator.plugins[i].name +
      " | " +
      navigator.plugins[i].filename +
      " | " +
      navigator.plugins[i].description +
      " | " +
      navigator.plugins[i].version +
      "<br>"
    );
    if(navigator.plugins[i].name=="EmotivBTLE")
    {
      return true;
      break;
    }
  }
  return false;
}
//if not exist and notify to download
/*window.onload=function()
{
console.log("abc");
  if(!checkPluginExits())
  {
    var confirmDownload = confirm("Download plugin (Please restart your browser after install plugin)?");
    if (confirmDownload == true)
    {
      window.location.href=('download.php');
    }
  }
  init();
};*/

var sysTime;
var engine;
var userIdProfile = 0;
function init()
{
  engine = EmoEngine.instance();
  onloadPluginEmotiv();
  //EdkDll.DebugLog = true;
  AddValidLicenseDoneEvent();
  EdkDll.ELS_ValidLicense();
  //sysTime = document.getElementById("txtInputTime");
  //sysTime.value = "00.0000";
}
function AddValidLicenseDoneEvent()
{
  EdkDll.addEvent(ELSPlugin(), 'valid', function(license){
    console.log("license");
    console.log(license);
    if(license.indexOf('"License":"EEG"') > -1) console.log("License is EEG License. You can get all data.");
    else if (license.indexOf('"License":"Non-EEG"') > -1) console.log("License is Non-EEG License. You can get all non-eeg data.");
    else console.log("The license is not valid. Please get valid license to get data");
    //console.log(ELSPlugin().ELS_IEE_EmoInitDevice());
    if((platform.os.family == "OS X")||(platform.os.family == "iOS"))
    {
      console.log("OS X");
      ELSPlugin().ELS_IEE_EmoInitDevice();
    }
    engine.IConnect();
    var x1 = EdkDll.IEE_GetSecurityCode();
    EdkDll.IEE_CheckSecurityCode(x1);
    updateEmoEngine();
      });
}
function updateEmoEngine()
{ 
  try
  {
    engine.IProcessEvents(500);
    setTimeout("updateEmoEngine()",50);
  }
  catch(e)
  {
    alert(e);
  }
}

// Handle UserAdded event
$(document).bind("UserAdded",function(event,userId){
  userIdProfile = userId;
  alert("Added User");
});
// Handle UserRemoved event
$(document).bind("UserRemoved",function(event,userId){
 //alert("Removed User");
});

$(document).bind("EmoStateUpdated",function(event,userId,es){
  var getTime = es.IS_GetTimeFromStart();
  var timefromStart = new String(getTime);
  var timeStart;
  if (getTime <10)
  {
    timeStart = timefromStart.substring(0,6);
  }
  else timeStart = timefromStart.substring(0,7);
  //sysTime.value = timeStart;
  var wireSignal= es.IS_GetWirelessSignalStatus();
  var batteryArr = es.IS_GetBatteryChargeLevel();
  
  loadBatteryQuality(batteryArr["chargeLevel"]);
  loadWirelessQuality(wireSignal);
});


// **************************  MAIN SCRIPT *************************//

$(window).load(function(){
  if(!checkPluginExits())
  {
    var confirmDownload = confirm("Download plugin (Please restart your browser after install plugin)?");
    if (confirmDownload == true)
    {
      window.location.href=('download.php');
    }
  }
  init();
});