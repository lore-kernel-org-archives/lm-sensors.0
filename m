From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sun, 05 Aug 2007 14:51:07 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <46B5E3DB.1060205@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de> <20070805135500.GF6221@jupiter.solarsys.private>
In-Reply-To: <20070805135500.GF6221@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

Mark M. Hoffman wrote:
> It's more likely the patch before that:
> 
> 	hwmon/w83627ehf: Preserve speed reading when changing fan min

I reverted this patch alone and rebooted, still the same problem.
After reboot:
   0 RPM for case fan,
   correct CPU fan speed, drops to 1/16 after kmsensors' first refresh
After unloading and reloading the driver:
   correct speed of case fan,
   correct CPU fan speed, drops to 1/16 after kmsensors' first refresh

> I'll reexamine the patch series here.  If you have time, it would help if you
> could do a git bisect.  Use this command:
> 
> $ git bisect start v2.6.23-rc2 v2.6.22-rc5 drivers/hwmon/w83627ehf.c
> 
> Doing it this way will force you to reboot between tests; I think we would
> need that anyway.

I'll try to reserve the time for that on some evening next week.
Thanks,
-- 
Stefan Richter
-===-=-== =--- --=-http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
