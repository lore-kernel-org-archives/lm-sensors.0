From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Apr 2013 19:43:22 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] thermal threshold event notification
Message-Id: <20130404194321.GA24956@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365102689-12581-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1365102689-12581-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 04, 2013 at 12:11:25PM -0700, Srinivas Pandruvada wrote:
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
>  
> This patch adds two entries to coretemp sysfs.
> tempX_notify_threshold_1
> tempX_notify_threshold_2
> 
> These two settings acts on "Package level", not on core level. So it will only appear
> if there is support for package temperature. Many of recent Intel processors, support
> package temperatures
> When any valid value is written to these files, it will directly set corresponding CPU MSR,
> in the corresponding package and read back directly from MSR. Since package MSR, affects
> all cores in package, setting will be applicable to all CPU's in the package minimizing
> read, writes and notifications. Also package threshold interrupts are enabled only when,
> a non zero value is written to thresholds.
> 
> Once thresholds are violated, it uses a rate control of 5 seconds, reducing the number
> of interrupts, when temperature is hanging around trip point. Using the sticky log bit,
> it sends kboject uevent change notification for corresponding package sysfs.
> Once the thermal daemon receives notification, it can change to new threshold or act
> immediately to reduce CPU temperature.
> 
> 
> Srinivas Pandruvada (4):
>   x86, mcheck, therm_throt: Process package thresholds
>   hwmon: (coretemp) Add threshold support
>   hwmon: (coretemp) : Add notification support
>   drivers/hwmon/coretemp : Debug fs interface
> 
>  arch/x86/include/asm/mce.h               |   7 +
>  arch/x86/kernel/cpu/mcheck/therm_throt.c |  50 ++++-
>  drivers/hwmon/coretemp.c                 | 319 +++++++++++++++++++++++++++++--
>  3 files changed, 361 insertions(+), 15 deletions(-)
> 
Key question: Why does the thermal subsystem not work for you ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
