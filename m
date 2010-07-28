From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 28 Jul 2010 19:25:47 +0000
Subject: Re: [lm-sensors] [PATH V2 2/5] Package Level Thermal Control and
Message-Id: <1280345147.1830.57.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1280343653-26380-1-git-send-email-fenghua.yu@intel.com>
	 <1280343653-26380-3-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1280343653-26380-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, H Peter Anvin <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Chen Gong <gong.chen@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, Huaxu Wan <huaxu.wan@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Wed, 2010-07-28 at 15:00 -0400, Fenghua Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> This patch adds a hwmon driver for package level thermal control. The driver
> dumps package level thermal information through sysfs interface so that upper
> level application (e.g. lm_sensor) can retrive the information.
> 
> Instead of having the package level hwmon code in coretemp, I write a seperate
> driver pkgtemp because:
> 
> First, package level thermal sensors include not only sensors for each core,
> but also sensors for uncore, memory controller or other components in the
> package. Logically it will be clear to have a seperate hwmon driver for package
> level hwmon to monitor wider range of sensors in a package. Merging package
> thermal driver into core thermal driver doesn't make sense and may mislead.
> 
> Secondly, merging the two drivers together may cause coding mess. It's easier
> to include various package level sensors info if more sensor information is
> implemented. Coretemp code needs to consider a lot of legacy machine cases.
> Pkgtemp code only considers platform starting from Sandy Bridge.
> 
> On a 1Sx4Cx2T Sandy Bridge platform, lm-sensors dumps the pkgtemp and coretemp:
> 
> pkgtemp-isa-0000
> Adapter: ISA adapter
> physical id 0: +33.0°C  (high = +79.0°C, crit = +99.0°C)
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +32.0°C  (high = +79.0°C, crit = +99.0°C)
> 
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +32.0°C  (high = +79.0°C, crit = +99.0°C)
> 
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +32.0°C  (high = +79.0°C, crit = +99.0°C)
> 
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +32.0°C  (high = +79.0°C, crit = +99.0°C)
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>

That I provided feedback does not mean that I endorsed a "Reviewed-by"
signature. It is inappropriate to add such a signature without my
approval.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
