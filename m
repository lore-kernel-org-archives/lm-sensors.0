From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Mar 2010 08:40:48 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <20100309094048.0c923950@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 8 Mar 2010 13:39:19 -0800, Phillip Pi wrote:
> Another thing. Is this going to be harmful if I enable AMD's
> Cool'n'Quiet in its CMOS and use PowerNow-k8 module? I used to use it in 
> the past, but currently disabled for testingn purposes.

No, the powernow-k8 driver doesn't use the problematic I/O ports so it
won't cause any problem.

> modprobe powernow-k8
> echo ondemand >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> echo 1 >/sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice_load


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
