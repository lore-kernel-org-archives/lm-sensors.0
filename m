From: "Mathias G" <mathias_g@tuxedo.ath.cx>
Date: Tue, 28 Jan 2014 05:48:49 +0000
Subject: Re: [lm-sensors] FanControl can not auto"load"
Message-Id: <c4b5beae94a8f8102653a5c91bc6ddf9.squirrel@tuxedo.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390846853.4041.38.camel@X4-955>
In-Reply-To: <1390846853.4041.38.camel@X4-955>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frederic

I read about problems with the loading order of modules, with the result
that the hwmon0, hwmon1 assignment gets mixed on reboot and thus the
fancontrol config gets invalid.
If you manually try to invoke fancontrol, you should get an error message
about wrong config.

The problem is described here for exeample:
http://ubuntuforums.org/showthread.php?t10061

The easiest fix would be to blacklist the k10temp module, reboot, ensure
that k10temp is not loaded and then rerun the pwm_config.
Reboot to check if fancontrol works.
-- 
Kind regards
 Mathias


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
