var isBlack; //++
var isRed; //++
var isYellow; //++
var isGreen; //++
/*-- Draw Headset --*/
	var image0 = new Array("images/headset/f3-black.png","images/headset/f3-red.png","images/Headset/f3-yellow.png","images/Headset/f3-green.png");
	var image1 = new Array("images/headset/f4-black.png","images/headset/f4-red.png","images/Headset/f4-yellow.png","images/Headset/f4-green.png");
	var image2 = new Array("images/headset/t7-black.png","images/headset/t7-red.png","images/Headset/t7-yellow.png","images/Headset/t7-green.png");
	var image3 = new Array("images/headset/t8-black.png","images/headset/t8-red.png","images/Headset/t8-yellow.png","images/Headset/t8-green.png");
	var image4 = new Array("images/headset/pz-black.png","images/headset/pz-red.png","images/Headset/pz-yellow.png","images/Headset/pz-green.png");
	//var smallNoteInertial = new Array();
	//smallNoteInertial = document.getElementsByName("smallNoteInertial");
	var smallNote = new Array();
	smallNote = document.getElementsByName("smallNote");
	var noteValue = new Array(); // store value of each note
	$(document).bind("EmoStateUpdated",function(event,userId,es){
	
		var signalStatus = es.IS_GetWirelessSignalStatus();
		//console.log(signalStatus);
		if(signalStatus !=0)
		{
		var contactQualityChannels = new Array();
		contactQualityChannels = es.IS_GetContactQualities();
			noteValue[0] = contactQualityChannels[0];
			noteValue[1] = contactQualityChannels[1];
			noteValue[2] = contactQualityChannels[2];
			noteValue[3] = contactQualityChannels[3];
			noteValue[4] = contactQualityChannels[4];
		}
		else
		{
			var i =0;
			for(i=0;i<5;i++)
			{
				noteValue[i] =0;
			}
		}
		/*-- Update headset small --*/
		isBlack = 0; //++
		isRed = 0; //++
		isYellow = 0; //++
		isGreen = 0; //++
		/*-- End update --*/
		drawNote();
	});
	
	function noteStatus(noteValue,i)
	{
		// O: Black
		// 1: Red
		// 2: Orange
		// 3: Orange
		// 4: Green
		var returnImg = new Image();
		if(i==0)
		{
		switch(noteValue)
		{
			case 0:
				returnImg.src = image0[0];
				isBlack++;
				break;
			case 1:
				returnImg.src = image0[1];
				isRed++;
				break;
			case 2:
				returnImg.src = image0[2];
				isYellow++;
				break;
			case 3:
				returnImg.src = image0[2];
				isYellow++;
				break;
			case 4:
				returnImg.src = image0[3];
				isGreen++;
				break;
			default :
				returnImg.src = image0[0];
		}
		}
		else if(i==1)
		{
			switch(noteValue)
		{
			case 0:
				returnImg.src = image1[0];
				isBlack++;
				break;
			case 1:
				returnImg.src = image1[1];
				isRed++;
				break;
			case 2:
				returnImg.src = image1[2];
				isYellow++;
				break;
			case 3:
				returnImg.src = image1[2];
				isYellow++;
				break;
			case 4:
				returnImg.src = image1[3];
				isGreen++;
				break;
			default :
				returnImg.src = image1[0];
		}
		}
		else if(i==2)
		{
			switch(noteValue)
		{
			case 0:
				returnImg.src = image2[0];
				isBlack++;
				break;
			case 1:
				returnImg.src = image2[1];
				isRed++;
				break;
			case 2:
				returnImg.src = image2[2];
				isYellow++;
				break;
			case 3:
				returnImg.src = image2[2];
				isYellow++;
				break;
			case 4:
				returnImg.src = image2[3];
				isGreen++;
				break;
			default :
				returnImg.src = image2[0];
		}
		}
		else if(i==3)
		{
			switch(noteValue)
		{
			case 0:
				returnImg.src = image3[0];
				isBlack++;
				break;
			case 1:
				returnImg.src = image3[1];
				isRed++;
				break;
			case 2:
				returnImg.src = image3[2];
				isYellow++;
				break;
			case 3:
				returnImg.src = image3[2];
				isYellow++;
				break;
			case 4:
				returnImg.src = image3[3];
				isGreen++;
				break;
			default :
				returnImg.src = image3[0];
		}
		}
		else if(i==4)
		{
			switch(noteValue)
		{
			case 0:
				returnImg.src = image4[0];
				isBlack++;
				break;
			case 1:
				returnImg.src = image4[1];
				isRed++;
				break;
			case 2:
				returnImg.src = image4[2];
				isYellow++;
				break;
			case 3:
				returnImg.src = image4[2];
				isYellow++;
				break;
			case 4:
				returnImg.src = image4[3];
				isGreen++;
				break;
			default :
				returnImg.src = image4[0];
		}
		}
		return returnImg;
	}

	function drawNote()
	{
		smallNote[0].src = noteStatus(noteValue[0],0).src; //AF3 = 0, T7 = 1, Pz = 2, T8 = 3, AF4 = 4;
		smallNote[1].src = noteStatus(noteValue[4],1).src;
		smallNote[2].src = noteStatus(noteValue[1],2).src;
		smallNote[3].src = noteStatus(noteValue[3],3).src;
		smallNote[4].src = noteStatus(noteValue[2],4).src;
		var maxStatus;
		maxStatus = Math.max(isBlack,isRed,isYellow,isGreen);
		if (maxStatus==isBlack) loadSignalQuality(0);
		if (maxStatus==isRed) loadSignalQuality(1);
		if (maxStatus==isYellow) loadSignalQuality(2);
		if (maxStatus==isGreen) loadSignalQuality(3);
	}
	