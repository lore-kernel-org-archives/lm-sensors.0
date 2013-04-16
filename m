From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 16 Apr 2013 04:53:27 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] thermal threshold event notification
Message-Id: <20130416045327.GA2551@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365102689-12581-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20130404194321.GA24956@roeck-us.net>
 <515DDDF0.9020904@linux.intel.com>
 <20130406032431.GA25103@roeck-us.net>
 <51622E08.3020902@linux.intel.com>
 <20130408152653.GC20919@roeck-us.net>
 <1366084864.2323.23.camel@rzhang1-mobl4>
In-Reply-To: <1366084864.2323.23.camel@rzhang1-mobl4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, fenghua.yu@intel.com, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org

On Tue, Apr 16, 2013 at 12:01:04PM +0800, Zhang Rui wrote:
> Hi,
> 
> On Mon, 2013-04-08 at 08:26 -0700, Guenter Roeck wrote:
> > On Sun, Apr 07, 2013 at 07:40:08PM -0700, Srinivas Pandruvada wrote:
> > > Hi Guenter,
> > > 
> > > Thanks for your quick response. Please see my answers in-line.
> > > 
> > > Thanks,
> > > Srinivas
> > > 
> > > On 04/05/2013 08:24 PM, Guenter Roeck wrote:
> > > >On Thu, Apr 04, 2013 at 01:09:20PM -0700, Srinivas Pandruvada wrote:
> > > >>On 04/04/2013 12:43 PM, Guenter Roeck wrote:
> > > >>>On Thu, Apr 04, 2013 at 12:11:25PM -0700, Srinivas Pandruvada wrote:
> > > >>>>This is clear that there is reluctance in adding thresholds in coretemp sysfs,
> > > >>>>during previous attempts. Proably because of lake of use cases.
> > > >>>>But this time use case may be more compelling.
> > > >>>>
> > > >>>>We have many small form factor devices like ultrabooks, slate PCs in the market.
> > > >>>>Unfortunately these devices reach maximum temperature with relatively less
> > > >>>>workloads, causing BIOS to do thermal throttling. There are real performance
> > > >>>>issues due to aggressive BIOS action to control thermals and also thermal breakdown
> > > >>>>in some cases.
> > > >>>>
> > > >>>>Even the most expensive laptops, don't have correct ACPI thermal configuration,
> > > >>>>so that kernel thermal driver can act. In some case even the trip point is higher
> > > >>>>than critical temperature setting.
> > > >>>>
> > > >>>>Intel has developed several drivers, which can be used to cool the system very efficiently.
> > > >>>>They include RAPL based cooling driver, Powerclamp driver and P state driver.
> > > >>>>To utilize these cooling device a closed loop user mode program is required, which
> > > >>>>will utilize these method and dynamically compensate for high CPU temperatures,
> > > >>>>without relying on any configuration data.
> > > >>>>One such solution is developed is "Linux thermal daemon". More details can be
> > > >>>>obtained from
> > > >>>>"https://github.com/01org/thermal_daemon/blob/master/ThermalDaemon_Introduction.pdf".
> > > >>>>This daemon polls for cpu temperature and apply compensation once the CPU reach target
> > > >>>>temperature.
> > > >>>>
> > > >>>>This polling can be mostly avoided, by getting notification for the temperature, where
> > > >>>>it needs to wake up and get ready for apply compensation. In most of the normal use
> > > >>>>cases, there may not be any threshold events. So very minimal number of user space
> > > >>>>notification for thermal thresholds.
> > > >>>>
> > > >>>>This patch adds two entries to coretemp sysfs.
> > > >>>>tempX_notify_threshold_1
> > > >>>>tempX_notify_threshold_2
> > > >>>>
> > > >>>>These two settings acts on "Package level", not on core level. So it will only appear
> > > >>>>if there is support for package temperature. Many of recent Intel processors, support
> > > >>>>package temperatures
> > > >>>>When any valid value is written to these files, it will directly set corresponding CPU MSR,
> > > >>>>in the corresponding package and read back directly from MSR. Since package MSR, affects
> > > >>>>all cores in package, setting will be applicable to all CPU's in the package minimizing
> > > >>>>read, writes and notifications. Also package threshold interrupts are enabled only when,
> > > >>>>a non zero value is written to thresholds.
> > > >>>>
> > > >>>>Once thresholds are violated, it uses a rate control of 5 seconds, reducing the number
> > > >>>>of interrupts, when temperature is hanging around trip point. Using the sticky log bit,
> > > >>>>it sends kboject uevent change notification for corresponding package sysfs.
> > > >>>>Once the thermal daemon receives notification, it can change to new threshold or act
> > > >>>>immediately to reduce CPU temperature.
> > > >>>>
> > > >>>>
> > > >>>>Srinivas Pandruvada (4):
> > > >>>>   x86, mcheck, therm_throt: Process package thresholds
> > > >>>>   hwmon: (coretemp) Add threshold support
> > > >>>>   hwmon: (coretemp) : Add notification support
> > > >>>>   drivers/hwmon/coretemp : Debug fs interface
> > > >>>>
> > > >>>>  arch/x86/include/asm/mce.h               |   7 +
> > > >>>>  arch/x86/kernel/cpu/mcheck/therm_throt.c |  50 ++++-
> > > >>>>  drivers/hwmon/coretemp.c                 | 319 +++++++++++++++++++++++++++++--
> > > >>>>  3 files changed, 361 insertions(+), 15 deletions(-)
> > > >>>>
> > > >>>Key question: Why does the thermal subsystem not work for you ?
> > > >>Thermal is bigger issue in Ultrabooks, Slate PCs and other small
> > > >>form factor devices.
> > > >>Linux ACPI thermal driver depends on ACPI configuration to activate
> > > >>active/passive control. So if you have garbage data or not optimized
> > > >>data, the current Linux driver can't control thermals. There are
> > > >>multiple platforms with bad ACPI data. Some of them have "ACPI
> > > >>threshold > critical temp"
> > > >>
> > > >I wasn't talking about ACPI, I was talking about the Linux thermal subsystem
> > > >in drivers/thermal. There is no single mention of "ACPI" in that directory.
> > > 
> > > <Thermal drivers also  resides outside this directory. ACPI also
> > > registers as thermal zone similar to other example you mentioned
> > > below. ACPI is the only means to configure per platform thermal trip
> > > points in thermal zones in PC platform.
> > > >
> > > >
> > > >>Currently all these systems, rely on BIOS fan and T state control.
> > > >>Once T states are used the performance gets hurt. Also we had cases
> > > >>of thermal breakdown.
> > > >>
> > > >>In addition there are several new methods to cool the system,
> > > >>developed by Intel and are in latest Linux kernel. They are
> > > >>specially designed to cool the system when needed.
> > > >>
> > > >So, again, why can't you use the thermal subsystem ?
> > > <Thermal zone needs to show temperature.  This will be duplicate
> > > what coretemp.X is showing. I want to prevent identical information
> > > be displayed at two different sysfs>
> > > Also the db8500 example you are giving, uses a pre-configured
> > > thresholds loaded during probe().
> > > There is no thermal ABI to set thresholds at run time. Basically
> > > when a temperature is above a trip temp, corresponding cooling
> > > devices will be activated.
> > > So I still I have to write a platform driver to set thresholds, and
> > > then registers with thermal zone. This will show as another
> > > packagetemp.x at sysfs like coretemp.x.
> > > 
> > > So please let me know how to set dynamic thresholds?
> > > >
> > > 
> > > >The db8500_thermal driver in drivers/thermal is quite similar to what
> > > >you try to accomplish. I would suggest to look into it and use a similar
> > > >approach. I really don't see how this fits into the hwmon subsystem.
> > > <Is this logic based on that hwmon shouldn't have write interface
> > > and used only for monitoring?  I think some hwmon driver already
> > > have write interface like gpiofan.>
> > 
> > That isn't the point. hwmon is static in nature, not dynamic. Its scope is
> > hardware monitoring, not thermal management. This is what the thermal subsystem
> > is for. Yes, presumably you would need a platform driver to set the thresholds.
> > Another question, though, would be if you want or need a user space component in
> > the first place or if you can implement all required functionality in a thermal
> > driver.
> > 
> Agreed.
> 
> I read the slides at
> https://github.com/01org/thermal_daemon/blob/master/ThermalDaemon_Introduction.pdf
> 
> According to your slides, you have four kinds of cooling devices,
> 1. RAPL cooling device driver
> 2. P states control
> 3. Intel power clamp driver
> 4. T states
> and four trip points (according to the picture in page 9).
> 
> I think you will use, say RAPL for trip point 0 (the bigger the number
> is, the higher temperature the trip point is), both RAPL and P state
> control for trip point1, ..., all of the cooling devices for trip point
> 3, etc, right?
> 
> IMO, all of these actions fit into the Linux/Thermal subsystem
> naturally.
> 
> so my question would be why do you prefer to do it by user space
> component?
> 
Even if a user space component is needed or desired, I would much prefer
if the thermal subsystem would be enhanced to support it instead of
creating a hwmon overlay and duplicate what the thermal subsystem
tries to accomplish.

I think we will at some point need a neat way of passing hwmon
information into the thermal subsystem (neat -> without requiring
from each hwmon driver to also register with the thermal subsystem),
but that is a different problem.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
