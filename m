From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 28 Sep 2007 17:07:05 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20070928190705.18c7d3e0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Thu, 27 Sep 2007 14:53:12 -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 26 Sep 2007, Hans de Goede wrote:
> > Excellent work Jean! I've given this a test run on all my systems / test rigs 
> > and it works great everywhere. I'll create patches for ksensors, gkrellm, and 
> > gome's sensors-applet as time permits. I'm afraid this will take a while as 
> > currently I'm very busy with stuff regarding the upcoming Fedora 8.
> 
> When you do, *please* make sure to rip out any ibm-acpi/thinkpad-acpi procfs
> support from those applications.  I have *never* seen perfect ibm-acpi
> procfs parsing code in my life, and I tried to track down every app that
> could do it... most of it is either thruly hideous, or broken in minor ways.
> 
> I don't want to see any app ever touching the ibm-acpi/thinkpad-acpi procfs
> interface again.  That interface is crap, and needs to die.  And most of the
> userspace code talking to it is even worse crap.

The code may be ugly, however you can't ask people to drop support for
the old interface to ibm-acpi/thinkpad-acpi now while the new interface
is not even released. Your driver changes have not reached upstream yet,
and when they do, only lm-sensors 3 (of which there is only a RC
available for now) will support them, lm-sensors 2 doesn't. So you
should expect user-space applications to keep their support for the old
interface for some time, for compatibility reasons.

> Also, please remember that sysfs hwmon may return -ENXIO (sensor not
> available at this time) for some hotpluggable sensors, -EBUSY (try again
> later), -EIO (failure to communicate with sensor) and some other crap that
> should not cause an app to beat the bit bucket or pestering the user off
> with dumb modal notifications of errors... I don't know how these propagate
> through libsensors4, though.  Jean?

libsensors4 returns -SENSORS_ERR_KERNEL ("Kernel interface error")
if it can't read a value from a sysfs attribute file.
-SENSORS_ERR_ACCESS_R ("Can't read") would probably be preferable. It
doesn't read the actual error value returned by the underlying driver,
so all errors are handled the same way. The application could probably
check the value of errno to find out, but this is not documented, and
mixing proprietary error codes with standard ones could be confusing.

Do you think that we should allocate new proprietary error codes for
specific errors returned by the drivers on failed reads?

Rejected writes are silently ignored. Not good. We should detect these
and return some error code. I'll commit a fix for that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
