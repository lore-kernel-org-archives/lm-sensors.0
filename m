From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sun, 05 Aug 2007 17:13:34 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <46B6053E.2050708@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de> <20070805162141.GI6221@jupiter.solarsys.private>
In-Reply-To: <20070805162141.GI6221@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

Mark M. Hoffman wrote:
> Does this patch (against v2.6.23-rc2) fix it?
> 
> commit f15c50e703c14ff7d72c3cb34e8e55417476a290
> Author: Mark M. Hoffman <mhoffman@lightlink.com>
> Date:   Sun Aug 5 12:19:01 2007 -0400
> 
>     hwmon: read fan_div values during probe
>     
>     This patch forces the driver to read the fan divider values during early init.
>     Otherwise, a call to store_fan_min() could access uninitialized variables.

Alas not; there is no change.
(I applied on vanilla 2.6.23-rc2 and rebooted.)
-- 
Stefan Richter
-===-=-== =--- --=-http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
