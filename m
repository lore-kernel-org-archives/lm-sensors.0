From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Question concerning sensors chips.c alarm handling
Message-Id: <Pine.LNX.4.58.0409071447260.8167@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I was looking in the sensors program's chips.c file at the various
print_*() routines and found the following code:

	if (!sensors_get_feature(*name,SENSORS_ADM1025_ALARMS,&cur))	
	    alarms = cur + 0.5;
  	else {
	    printf("ERROR: Can't get alarm data!\n");
	    alarms = 0;
	}

repeated in various routines for various chips.  Why is 0.5 added to 
the alarm mask value?

Thanks...james

P.S.  Looking at implenting a print routine for the lm93, and was 
basically looking at copying code from LM87 print routine and going
from there.
