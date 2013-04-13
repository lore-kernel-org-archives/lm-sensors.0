From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 13 Apr 2013 01:32:30 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] thermal threshold and notification v2.0
Message-Id: <20130413013230.GB14726@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365541282-19366-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1365541282-19366-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: lm-sensors@lm-sensors.org, fenghua.yu@intel.com, tony.luck@intel.com, bp@alien8.de, linux-pm@vger.kernel.org

On Tue, Apr 09, 2013 at 02:01:18PM -0700, Srinivas Pandruvada wrote:
> 
> v2.0
> As suggested by Guenter Roeck, used the previous development in this area
> as starting point. The first patch is same as what Guenter Roeck submitted
> before except for checkpatch error for strtoul.As per this patch, the following
> additional coretemp sysfs entries will be added:
> tempX_threshold1 - Reflects value of CPU thermal threshold T0.
> tempX_threshold1_triggered
> 	         - Reflects status of CPU thermal status register bit 6
> 		   (THERM_STATUS_THRESHOLD0).
> tempX_threshold2 - Reflects value of CPU thermal threshold T1.
> tempX_threshold2_triggered
> 	         - Reflects status of CPU thermal status register bit 8
> 		   (THERM_STATUS_THRESHOLD1).
> 
> 
> The notification mechanism is implemented for package level by using uevent.
> Also a debugfs interface is added to check count of interrupts and worker fn
> scheduling.
> 
> 
> v1.0
> 
> This is clear that there is reluctance in adding thresholds in coretemp sysfs,
> during previous attempts. Proably because of lake of use cases.
> But this time use case may be more compelling.
> 
> We have many small form factor devices like ultrabooks, slate PCs in the market.
> Unfortunately these devices reach maximum temperature with relatively less
> workloads, causing BIOS to do thermal throttling. There are real performance
> issues due to aggressive BIOS action to control thermals and also thermal breakdown
> in some cases.
> 
> Even the most expensive laptops, don't have correct ACPI thermal configuration,
> so that kernel thermal driver can act. In some case even the trip point is higher
> than critical temperature setting.
> 
> Intel has developed several drivers, which can be used to cool the system very efficiently.
> They include RAPL based cooling driver, Powerclamp driver and P state driver.
> To utilize these cooling device a closed loop user mode program is required, which
> will utilize these method and dynamically compensate for high CPU temperatures,
> without relying on any configuration data.
> One such solution is developed is "Linux thermal daemon". More details can be
> obtained from 
> "https://github.com/01org/thermal_daemon/blob/master/ThermalDaemon_Introduction.pdf".
> This daemon polls for cpu temperature and apply compensation once the CPU reach target
> temperature. 
> 
> This polling can be mostly avoided, by getting notification for the temperature, where
> it needs to wake up and get ready for apply compensation. In most of the normal use 
> cases, there may not be any threshold events. So very minimal number of user space
> notification for thermal thresholds.
> 
> Notification are added only for package level thresholds, to minimize events. Also
> interrupts are enabled only when a non tj_max(default) value is written to thresholds.
> 
> Once thresholds are violated, it uses a rate control of 5 seconds, reducing the number
> of interrupts, when temperature is hanging around trip point. Using the sticky log bit,
> it sends kboject uevent change notification for corresponding package sysfs.
> Once the thermal daemon receives notification, it can change to new threshold or act
> immediately to reduce CPU temperature.*
> 
> Guenter Roeck (1):
>   hwmon: (coretemp) Add support for thermal threshold attributes
> 
> Srinivas Pandruvada (3):
>   x86, mcheck, therm_throt: Process package thresholds
>   hwmon: (coretemp) : Add notification support
>   hwmon: (coretemp) : Add debugfs to support thresholds
> 
>  Documentation/hwmon/coretemp             |   8 +
>  arch/x86/include/asm/mce.h               |   7 +
>  arch/x86/kernel/cpu/mcheck/therm_throt.c |  63 ++++++-
>  drivers/hwmon/coretemp.c                 | 292 +++++++++++++++++++++++++++++--
>  4 files changed, 356 insertions(+), 14 deletions(-)
> 
Rui,

can you have a look at this series ?

I would like to get some feedback from thermal subsystem supporters if hwmon
is really the right place for this. I may be wrong, but it seems to me it would
better fit into thermal.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
