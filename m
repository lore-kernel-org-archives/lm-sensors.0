From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: w83792d_driver-1.0.1.patch: Winbond W83792D driver for
Message-Id: <20050316113024.3254ef6e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

> I finished fixing the point 1 "alarms" and point 3 "fan speeds in
> /proc" MDS provided me, and tested it briefly. But I don't think the
> "hardware-level" alarm mechanism is better than "software-level",
> besides the above reason, I also find such phenomenon:
> Step 1:
> #sensors:
> VCoreA:    +1.47 V  (min =  +1.40 V, max =  +1.60 V)
> 
> Step 2:
> modify the low limit into 1.5V, then run #sensors -s:
> 
> Step 3:
> VCoreA:    +1.47 V  (min =  +1.50 V, max =  +1.60 V)  ALARM
> 
> Step 4:
> VCoreA:    +1.47 V  (min =  +1.50 V, max =  +1.60 V)
> The ALARM will disappear when run "sensors" again, although the
> measured value is larger than low limit. Same as when I mentioned
> above
> 
> Step 5:
> When I modify the low limit back from 1.5 V into 1.4V, run #sensors
> -s, Then run #sensors, I find the "ALARM" appears again, while the
> measured value is between the limits at this time:
> VCoreA:    +1.47 V  (min =  +1.40 V, max =  +1.60 V)  ALARM
> It's not reasonable, don't you think so?

Sounds like an "interrupt mode" to me (as opposed to "comparator mode").
The alarm bits raise on state change and wear off when read. In
comparator mode you would obtain what you'd expect (alarm bit always
reflecting the result of the comparison).

If the W83792D can be reprogramed in comparator mode AND this does NOT
affect any physical output, then just do that. If the alarm bits DO
affect an output, then you should not change the mode, which means that
you cannot use hardware alarms if the chip is in interrupt mode.

As a side note, same is true for several other drivers, which would need
to be fixed.

> My another question is:
> There are 4 files which have been modified by me this time:
> kernel/chips/w83792d.c
> lib/chips.c
> lib/chips.h
> prog/sensors/chips.c
> Since I can NOT access lm_sensors CVS here, If I need to commit them,
> Need I generate another patch to lm_sensors-2.9.0, and send the patch
> to you? Or just you the above 4 files?

Get a CVS snapshot here:
http://secure.netroedge.com/~lm78/archive/lm_sensors-daily.tar.gz
And provide a patch against that.

Thanks,
-- 
Jean Delvare
