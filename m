From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Aug 2010 12:59:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pc87360) Fix device resource
Message-Id: <20100811145943.1a87a1e8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100707145841.58052281@hyperion.delvare>
In-Reply-To: <20100707145841.58052281@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Sat, 7 Aug 2010 05:23:20 -0600, Jim Cromie wrote:
> On Wed, Jul 7, 2010 at 6:58 AM, Jean Delvare <khali@linux-fr.org> wrote:
> 
> > It's not OK to call platform_device_add_resources() multiple times
> > in a row. Despite its name, this functions sets the resources, it
> > doesn't add them. So we have to prepare an array with all the
> > resources, and then call platform_device_add_resources() once.
> >
> > Before this fix, only the last I/O resource would be actually
> > registered. The other I/O resources were leaked.
> >
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Jim Cromie <jim.cromie@gmail.com>
> > Cc: stable@kernel.org
> > ---
> > Jim, do you still have your system with a PC8736x device? If you do,
> > can you please test this fix and report? Thanks.
> >
> >
> hi Jean,
> 
> I applied this patch, and it built w/o errors.
> Howver I have some distro (voyage 0.6.5) vs kernel issues
> to resolve before I have a solid testing env.
> It looks like 2.6.35 doesnt like udev 145, which shipped along with 2.6.30
> kernel
> 
> [   11.252182] udev: starting version 145
> [   11.252232] <3>udev: missing sysfs features; please update the kernel or
> disable the kernel's CONFIG_SYSFS_DEPRECATED option; udev may fail to work
> correctly

I can't help you much with this, I'm afraid. Just try what they say...

> and it does fail to work correctly;
> voyage:~# modprobe pc87360
> WARNING: Could not open 'kernel/drivers/hwmon/hwmon-vid.ko': No such file or
> directory
> FATAL: Could not open 'kernel/drivers/hwmon/pc87360.ko': No such file or
> directory
> 
> I'll try to straighten this out, and follow up on hotplug ml if I need help.

The errors above seem related to module dependencies and/or
installation, so I'd look at how and where the kernel modules were
installed on the system, if module-init-tools is up-to-date, try
running "depmod -a", see if "modprobe -c" complains. If nothing helps,
try running modprobe through strace, to see what exactly is failing.

> In the meantime, it looks like res_count isnt initialized before 1st use.
> 
> jimc@harpo linux-2.6.git]$ grep -n res_count drivers/hwmon/pc87360.c
> 1614: int err, i, res_count;
> 1627: res[res_count].start = extra_isa[i];
> 1628: res[res_count].end = extra_isa[i] + PC87360_EXTENT - 1;
> 1629: res[res_count].name = "pc87360",
> 1630: res[res_count].flags = IORESOURCE_IO,
> 1632: err = acpi_check_resource_conflict(&res[res_count]);
> 1636: res_count++;
> 1639: err = platform_device_add_resources(pdev, res, res_count);
> 
> Oddly, gcc doesnt complain about this,
> is this somehow hidden by zeroed memory due to __init on the function ??

This is indeed a bug, thanks a lot for finding and reporting it. It's
fixed now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
