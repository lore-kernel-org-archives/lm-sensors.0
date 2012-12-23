From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 23 Dec 2012 21:10:56 +0000
Subject: Re: [lm-sensors] coretemp.c:(.text+0x12cc56e): undefined reference to `__divdi3'
Message-Id: <20121223211056.GA2945@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50d75e09.JvGELCmHUG8sX0lp%fengguang.wu@intel.com>
In-Reply-To: <50d75e09.JvGELCmHUG8sX0lp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 24, 2012 at 03:39:53AM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-staging
> head:   5722b1cb8c0d3bb13a0077de60cfe0a63a64fa17
> commit: 5722b1cb8c0d3bb13a0077de60cfe0a63a64fa17 hwmon: (coretemp) Report package power and energy consumption
> date:   25 hours ago
> config: make ARCH=i386 allyesconfig
> 
> All error/warnings:
> 
> drivers/built-in.o: In function `coretemp_rapl_work':
> coretemp.c:(.text+0x12cc56e): undefined reference to `__divdi3'
> drivers/built-in.o: In function `show_power_cap':
> coretemp.c:(.text+0x12cc611): undefined reference to `__divdi3'
> drivers/built-in.o: In function `coretemp_add_core':
> coretemp.c:(.cpuinit.text+0xfe1): undefined reference to `__divdi3'
> 
Fixed.

Thanks a lot for the service and note!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
