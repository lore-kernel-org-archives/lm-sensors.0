From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 16 Apr 2013 05:12:00 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] thermal threshold and notification v2.0
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB59C6F3CD@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365541282-19366-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20130413013230.GB14726@roeck-us.net> <516C1AC0.6030403@linux.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB59C6EE10@BGSMSX101.gar.corp.intel.com>
 <1366088268.2323.48.camel@rzhang1-mobl4>
In-Reply-To: <1366088268.2323.48.camel@rzhang1-mobl4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Luck, Tony" <tony.luck@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "bp@alien8.de" <bp@alien8.de>

> -----Original Message-----
> From: Zhang, Rui
> Sent: Tuesday, April 16, 2013 10:28 AM
> To: R, Durgadoss
> Cc: Srinivas Pandruvada; Guenter Roeck; Yu, Fenghua; Luck, Tony; linux-
> pm@vger.kernel.org; lm-sensors@lm-sensors.org; bp@alien8.de
> Subject: RE: [lm-sensors] [PATCH 0/4] thermal threshold and notification v2.0
> 
> On Mon, 2013-04-15 at 11:53 -0600, R, Durgadoss wrote:
> > > -----Original Message-----
> > > From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-
> > > bounces@lm-sensors.org] On Behalf Of Srinivas Pandruvada
> > > Sent: Monday, April 15, 2013 8:51 PM
> > > To: Guenter Roeck
> > > Cc: Yu, Fenghua; Luck, Tony; linux-pm@vger.kernel.org; lm-sensors@lm-
> > > sensors.org; bp@alien8.de; Zhang, Rui
> > > Subject: Re: [lm-sensors] [PATCH 0/4] thermal threshold and notification
> v2.0
> > >
> > > On 04/12/2013 06:32 PM, Guenter Roeck wrote:
> > > > On Tue, Apr 09, 2013 at 02:01:18PM -0700, Srinivas Pandruvada wrote:
> > > >> v2.0
> > > >> As suggested by Guenter Roeck, used the previous development in
> this
> > > area
> > > >> as starting point. The first patch is same as what Guenter Roeck
> submitted
> > > >> before except for checkpatch error for strtoul.As per this patch, the
> > > following
> > > >> additional coretemp sysfs entries will be added:
> > > >> tempX_threshold1 - Reflects value of CPU thermal threshold T0.
> > > >> tempX_threshold1_triggered
> > > >> 	         - Reflects status of CPU thermal status register bit 6
> > > >> 		   (THERM_STATUS_THRESHOLD0).
> > > >> tempX_threshold2 - Reflects value of CPU thermal threshold T1.
> > > >> tempX_threshold2_triggered
> > > >> 	         - Reflects status of CPU thermal status register bit 8
> > > >> 		   (THERM_STATUS_THRESHOLD1).
> > > >>
> > > >>
> > > >> The notification mechanism is implemented for package level by using
> > > uevent.
> > > >> Also a debugfs interface is added to check count of interrupts and
> worker
> > > fn
> > > >> scheduling.
> > > >>
> > > >>
> > > >> v1.0
> > > >>
> > > >> This is clear that there is reluctance in adding thresholds in coretemp
> > > sysfs,
> > > >> during previous attempts. Proably because of lake of use cases.
> > > >> But this time use case may be more compelling.
> > > >>
> > > >> We have many small form factor devices like ultrabooks, slate PCs in
> the
> > > market.
> > > >> Unfortunately these devices reach maximum temperature with
> relatively
> > > less
> > > >> workloads, causing BIOS to do thermal throttling. There are real
> > > performance
> > > >> issues due to aggressive BIOS action to control thermals and also
> thermal
> > > breakdown
> > > >> in some cases.
> > > >>
> > > >> Even the most expensive laptops, don't have correct ACPI thermal
> > > configuration,
> > > >> so that kernel thermal driver can act. In some case even the trip point
> is
> > > higher
> > > >> than critical temperature setting.
> > > >>
> > > >> Intel has developed several drivers, which can be used to cool the
> system
> > > very efficiently.
> > > >> They include RAPL based cooling driver, Powerclamp driver and P state
> > > driver.
> > > >> To utilize these cooling device a closed loop user mode program is
> > > required, which
> > > >> will utilize these method and dynamically compensate for high CPU
> > > temperatures,
> > > >> without relying on any configuration data.
> > > >> One such solution is developed is "Linux thermal daemon". More
> details
> > > can be
> > > >> obtained from
> > > >>
> > >
> "https://github.com/01org/thermal_daemon/blob/master/ThermalDaemon
> > > _Introduction.pdf".
> > > >> This daemon polls for cpu temperature and apply compensation once
> the
> > > CPU reach target
> > > >> temperature.
> > > >>
> > > >> This polling can be mostly avoided, by getting notification for the
> > > temperature, where
> > > >> it needs to wake up and get ready for apply compensation. In most of
> the
> > > normal use
> > > >> cases, there may not be any threshold events. So very minimal
> number of
> > > user space
> > > >> notification for thermal thresholds.
> > > >>
> > > >> Notification are added only for package level thresholds, to minimize
> > > events. Also
> > > >> interrupts are enabled only when a non tj_max(default) value is
> written
> > > to thresholds.
> > > >>
> > > >> Once thresholds are violated, it uses a rate control of 5 seconds,
> reducing
> > > the number
> > > >> of interrupts, when temperature is hanging around trip point. Using
> the
> > > sticky log bit,
> > > >> it sends kboject uevent change notification for corresponding package
> > > sysfs.
> > > >> Once the thermal daemon receives notification, it can change to new
> > > threshold or act
> > > >> immediately to reduce CPU temperature.*
> > > >>
> > > >> Guenter Roeck (1):
> > > >>    hwmon: (coretemp) Add support for thermal threshold attributes
> > > >>
> > > >> Srinivas Pandruvada (3):
> > > >>    x86, mcheck, therm_throt: Process package thresholds
> > > >>    hwmon: (coretemp) : Add notification support
> > > >>    hwmon: (coretemp) : Add debugfs to support thresholds
> > > >>
> > > >>   Documentation/hwmon/coretemp             |   8 +
> > > >>   arch/x86/include/asm/mce.h               |   7 +
> > > >>   arch/x86/kernel/cpu/mcheck/therm_throt.c |  63 ++++++-
> > > >>   drivers/hwmon/coretemp.c                 | 292
> > > +++++++++++++++++++++++++++++--
> > > >>   4 files changed, 356 insertions(+), 14 deletions(-)
> > > >>
> > > > Rui,
> > > >
> > > > can you have a look at this series ?
> > > >
> > > > I would like to get some feedback from thermal subsystem supporters
> if
> > > hwmon
> > > > is really the right place for this. I may be wrong, but it seems to me it
> would
> > > > better fit into thermal.
> > > >
> > > > Thanks,
> > > > Guenter
> > >
> > > I am fine using thermal zones, but the coretemp will be duplicated in
> > > both coretemp and thermal sysfs and lot of code duplication. Also trip
> > > point in this case is not for activating any cooling device, but just to
> > > notify user space. So this will be a zone with no associated cdevs.
> >
> > Yes, this was the idea which we discussed in lm-sensors a few months ago.
> > [I could not locate the thread in the web]. Except that we will register as
> > 'thermal sensor' and not as 'thermal zones' because of the changes
> happening
> > to the thermal framework recently[1].
> >
> > This way, we can expose trip points and configure them, without having a
> > need to associate any cdevs.
> >
> Agreed.
> But note that this is also true in current code as well.

Yes, I agree.

Thanks,
Durga
> 
> thanks,
> rui
> > [1] https://lkml.org/lkml/2013/2/5/228
> 
> > Thanks,
> > Durga
> > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >
> > >
> > >
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
