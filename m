From: bepi@adria.it (Giuseppe Della Bianca)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [LM_SENSOR-2.8.7] lm_sensors.init and kernel 2.6.5
Message-Id: <200408111343.12044.bepi@adria.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408071426.51805.bepi@adria.it>
In-Reply-To: <200408071426.51805.bepi@adria.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Jean Delvare <khali@linux-fr.org>
]zac[
> already, so I'm glad someone finally proposed a patch to start with.
> Thanks!

Of nothing, it was just what I hoped.
Thanks to you for lm_sensors.

]zac[
> when running 2.4 it won't be used. So I decided to grep /proc/mounts
> instead.

True, my solution to use '/sys' is one bad solution,  the use of 'mounts' is 
one optimal solution.

]zac[
> it works OK for you? I can't test myself, since my distribution is not
> compatible with this kind of init script.

Yes, tested, I have only corrected the two ' ! $WITHSYS ' in ' $WITHSYS = "0" 
'  (' ! ' check only if the variable is empty).
It works correctly. 

> Thanks again.

Of nothing again.

To the next one. 

Regards
	Gdb


P.S. You have never thought to not only identify the sensor with the type but 
also considering to the model of motherboard?
This would have to concur, after a several time, of having a series of 
configurations that would have need of least modifications on many systems. 




-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors
Type: application/x-shellscript
Size: 3312 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040811/44592944/lm_sensors.bin
