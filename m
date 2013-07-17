From: Satoshi Imamura <s.imamura@qub.ac.uk>
Date: Wed, 17 Jul 2013 21:35:43 +0000
Subject: Re: [lm-sensors] =?utf-8?q?=5BPATCH_v2=5D_hwmon=2C=09fam15h=5Fpower?=
Message-Id: <loom.20130717T230425-574@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Mr. Andreas Herrmann,

I'm trying to measure power consumption of AMD Opteron 6272 using fam15h_power.
Linux kernel version is 3.9.4.
Even when all cores are idle, fam15h_power shows about 85W.
However, the power consumption decreases to about 74W
 when a process is executed with all cores.

For Linux kernel 3.9.4, the patch for fam15h_power is already applied.
Moreover, "RunAvgRange" (p. 460 of BKDG for Family 15h) is 
 appropriately set to "0x9" as following:

% setpci -s 00:18.5 0xe0.l
% 00372c99

Why is the power consumption so high (85W) when all cores are idle?
Why does it decrease when a process is executed with all cores?
I would appreciate if you could give me a advice.

Sincerely yours,

Satoshi







_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
