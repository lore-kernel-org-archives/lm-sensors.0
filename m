From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: fscpos driver
Message-Id: <qCkbBoYk.1104914480.3006120.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stefan,

> Thanks a lot for the review - I managed to clean most of the issues you
> mentioned. Some of them were just copied from other modules, others were
> my own :)

If this means that some other 2.4 or 2.6 drivers would need fixing, just
tell me where and I'll fix them.

> > > static ssize_t show_revision(struct device *dev, char *buf)
> >
> > Is there a real use for this? You could instead simply dev_info() it
> > at module load time.
>
> Well, the information probably isn't too relevant, but is there a reason
> not to allow access to it?

It's not the way you want to look at things, or you will end up with a
driver way bigger than it could and should. We want to keep the drivers
to a minimum size, in order to save memory space and limit the possible
bugs and the maintainance effort. We should get rid of whatever isn't
explicitely needed. It can still be added later if there is a real need.

> Plus, if I remove it, "sensors -u" complains about "ERROR: Can't get
> feature `rev' data!"

Because libsensors knows about the feature, and "sensors -u" asks the
library for all features it knows about. I'll fix the library. BTW, as
long as "sensors" (non -u) doesn't show any error, it's OK.

> > > static ssize_t set_temp_status
> > > static ssize_t set_fan_status
> >
> > Hmm, isn't it odd that a "status" file can be written to? What are the
> > two bits for?
>
> It allows you to clear the alert state. I noticed this doesn't comply with
> the sysfs guidelines which say alarms are read-only but it's quite handy
> after doing stupid things such as stopping a fan altogether (which causes
> an alert state for said fan and "sensors" won't show any more fan data
> until the state has been cleared).

The driver, not the user, should take care of this. When one is reading
from the status file, the driver should automatically rearm any flag
that needs be. Don't the 2.4 fscpos and the 2.6 fscher drivers do it
that way?

> > > static ssize_t set_fan_min
> >
> > [..] shouldn't the value be divided by 60?
>
> Indeed, I fixed that. I do however still seem to get it wrong somehow:
> When I double the value, the fan appears to accelerate by 8*60 RPM. It
> might somehow be related to the ripple value but I just don't get it.

I don't know either. Did you test the 2.4 driver in similar conditions?
It's odd that the min value would affect the speed, since it supposedly
is only a limit to the alarm condition, not a speed target.

> > Don't mask, check the value for validity instead.
>
> For some registers (mainly watchdog_control) it's quite tricky to figure
> out all valid values (especially as messing with them might cause unwanted
> reactions such as spontaneous rebooting)...

For bit vector registers, masking might be fine. What is not OK however
is to mask a *range* with 0xff instead of simply checking that the value
is between 0 and 255 and return -EINVAL or similar if it isn't. It's
usually better to return an error to user-space than silently drop an
invalid value. Do the best you can.

> > > static ssize_t show_event
> > > static ssize_t show_control
> >
> > What are these? Do you have a use for them?
>
> I don't *REALLY* know whether they're that useful: Event seems to report
> all kinds of alerts which could also be gathered from other sources, but
> offers a single place to see whether everything is OK. The control
> register reports whether the alert LED is flashing. I haven't seen that
> LED (yet), nor would I know how to make it flash, but I thought I'll just
> implement access to all the information available.

Any reason why control is writable? I find it strange that something
called control would only return a status.

> And, as above, "sensors -u" complains if I remove them.

Does "sensors" complain as well? Does "sensors" display anything for
these two files? If it doesn't, I guess it shows that these files are
not really important and could possibly be removed.

> > If libsensors needs to be updated to support your new driver, a patch
> > will be welcome as well.
>
> I tried to stick with the interface provided by the old driver so I don't
> think libsensors will need to be updated.

Sometimes it isn't enough. For libsensors/sensors to work out of the box
with a new 2.6 driver, it is required that the new driver follows the
standard AND the old driver had relatively standard feature names as
well. You of course cannot control that second condition. That said, if
you have good results already, then I guess that the feature names were
correct.

Thanks,
--
Jean Delvare
