From: Chen Gong <gong.chen@linux.intel.com>
Date: Tue, 02 Nov 2010 01:21:24 +0000
Subject: [lm-sensors] fix a minor error for sensors-detect
Message-Id: <4CCF6794.6030100@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Guenter

I can't access CVS easily from here and I don't know where to submit a 
lm-sensor tool patch, so I put it here.

I occasionally found on my board there is a sensor named asc7621 and
it had been supported since 2.6.34 (I get this info from lm-sensor wiki 
devices list), but sensors-detect doesn't update its status. Until now
it still shows "to-be-written". So I update it from "to-be-written" to 
"asc7621". Now it works fine.

So would you please help to merge it into lm-sensor tool ?

Thanks in advance !

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
