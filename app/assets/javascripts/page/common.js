			function getSignalQuality(i)
			{
				// 0: no
				// 1: red
				//2: yellow
				//3: green
				// default:no
				var image = new Array("/assets/epoc-no-signal.png",
				"/assets/epoc-bad-signal.png",
				"/assets/epoc-poor-signal.png",
				"/assets/epoc-good-signal.png");
				var returnImg = new Image();
				$("#signalQuality").text(i.toString());
				switch(i)
				{
					case 0:
						returnImg.src = image[0];
						break;
					case 1:
						returnImg.src = image[1];
						break;
					case 2:
						returnImg.src = image[2];
						break;
					case 3:
						returnImg.src = image[3];
						break;
					default :
						returnImg.src = image[0];
				}
				return returnImg;
			}
			
			function getWirelessQuality(i)
			{
				// 1: good
				// 2: no
				// default:no
				var image = new Array("/assets/wireless-no-signal.png",
				"/assets/wireless-good-signal.png");
				var returnImg = new Image();

				switch(i)
				{
					case 0:
						returnImg.src = image[0];
						break;
					case 1:
						returnImg.src = image[1];
						break;
					case 2:
						returnImg.src = image[1];
						break;
					default :
						returnImg.src = image[1];
				}
				return returnImg;
			}
			
			function getBatteryQuality(i)
			{
				// 0: empty
				// 1: low
				// 2: low
				// 3: half
				// 4: full
				// 5: full
				// default:empty
				var image = new Array("/assets/battery-empty.png",
				"/assets/battery-low.png",
				"/assets/battery-half.png",
				"/assets/battery-full.png"
				);
				var returnImg = new Image();
				switch(i)
				{
					case 0:
						returnImg.src = image[0];
						break;
					case 1:
						returnImg.src = image[1];
						break;
					case 2:
						returnImg.src = image[1];
						break;
					case 3:
						returnImg.src = image[2];
						break;
					case 4:
						returnImg.src = image[3];
					case 5:
						returnImg.src = image[3];
						break;
					default :
						returnImg.src = image[0];
				}
				return returnImg;
			}
			
			function loadSignalQuality(statusLevel){
				//alert("quality:1");
				var Notes=new Array();
				Notes=document.getElementsByName("signal_quality");
				for(i=0;i<Notes.length;i++)
					{
						//setcolor
						Notes[i].src = getSignalQuality(statusLevel).src;
					}
			}
			
			function loadWirelessQuality(wireSignal){
				//alert("quality:1");
				var Notes=new Array();
				Notes=document.getElementsByName("wireless_quality");
				for(i=0;i<Notes.length;i++)
					{
						//setcolor
						Notes[i].src = getWirelessQuality(wireSignal).src;
					}			
			}
			
			function loadBatteryQuality(chargeLevel){
				//alert("quality:1");
				var Notes=new Array();
				Notes=document.getElementsByName("battery_quality");
				for(i=0;i<Notes.length;i++)
					{
						//setcolor
						Notes[i].src = getBatteryQuality(chargeLevel).src;
					}
			}