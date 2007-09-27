From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Thu, 27 Sep 2007 17:53:12 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20070927175312.GA19842@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 26 Sep 2007, Hans de Goede wrote:
> Excellent work Jean! I've given this a test run on all my systems / test rigs 
> and it works great everywhere. I'll create patches for ksensors, gkrellm, and 
> gome's sensors-applet as time permits. I'm afraid this will take a while as 
> currently I'm very busy with stuff regarding the upcoming Fedora 8.

When you do, *please* make sure to rip out any ibm-acpi/thinkpad-acpi procfs
support from those applications.  I have *never* seen perfect ibm-acpi
procfs parsing code in my life, and I tried to track down every app that
could do it... most of it is either thruly hideous, or broken in minor ways.

I don't want to see any app ever touching the ibm-acpi/thinkpad-acpi procfs
interface again.  That interface is crap, and needs to die.  And most of the
userspace code talking to it is even worse crap.

Also, please remember that sysfs hwmon may return -ENXIO (sensor not
available at this time) for some hotpluggable sensors, -EBUSY (try again
later), -EIO (failure to communicate with sensor) and some other crap that
should not cause an app to beat the bit bucket or pestering the user off
with dumb modal notifications of errors... I don't know how these propagate
through libsensors4, though.  Jean?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
