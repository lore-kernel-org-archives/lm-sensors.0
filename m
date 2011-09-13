From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 13 Sep 2011 15:20:06 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <1315927206.2455.225.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, 2011-09-13 at 10:13 -0400, Jean Delvare wrote:
> On Tue, 13 Sep 2011 18:58:26 +0530, R, Durgadoss wrote:
> > Hi Guenter,
> > 
> > > > The temp1_max is supposed to be more than temp1_input and
> > > > temp1_max_hyst is supposed to be lesser than temp1_input.
> > > > By default the temp1_max_hyst is left at 0.
> > > >
> > > Should be set to something useful. Also, it does not have to be less
> > > than temp1_input, as long as it is less than temp1_max (which was my
> > > understanding). Worst case you would get another interrupt (when the
> > > temperature crosses temp1_max_hyst from below) which you would ignore.
> > 
> > Yes. I agree with you.
> > I have no clue on what exact value to set to max and max_hyst initially.
> > Can we set temp1_max to 70 and temp1_max_hyst to 50 ?
> 
> If anything, then the answer depends on the CPU, as it depends on
> TjMax. But more likely, no, we don't want to set these values, as we do
> NOT initialize limits in hwmon drivers [1]. The whole point of the
> hwmon sysfs interface is to let the user set the limits they want in
> sensors.conf. Ideally each CPU would have sane defaults, and failing
> that, the BIOS should set appropriate values.
> 
Looking at the code again, we did have ttarget for max, didn't we ? Any
objections against using it ?

As for max_hyst, looks like we'll have the option to leave it at 0, or
to set it to something. You had a problem with leaving it at 0, so I
guess it will be up to you to suggest an alternative. Setting it to the
same value as max might be an alternative (and maybe keep interrupts
disabled in that case).

> > > Interrupts should be enabled, and you can send uevents and sysfs notifications
> > > whenever a threshold is crossed. All you would have to do is to keep the old
> > > alarm
> > > state and send events whenever it changes.
> 
> But who should enable interrupts? And who will receive them? It really
> sounds like a task for thermal management, NOT hardware monitoring.
> Seems the boundary is getting blurrier every day...
> 
> I would like to avoid the case where merely loading the coretemp driver
> results in CPU throttling or worse simply because the threshold
> settings are wrong.
> 
That is not how it works. The hwmon driver doesn't actually do anything.
Best current example is gpio-fan.c: If thresholds are crossed,
sysfs_notify is called for the affected alarm attributes, and a uevent
is generated for the hwmon kobject. The new EXYNOS4 driver has a similar
mechanism, though I had them take out sysfs notifications since those
only covered 0->1 alarm transitions and we don't have guidelines for how
to handle that (see below).

I don't see a problem with the notifications - it pretty much lets
userland decide what if anything to do, and does not handle anything in
the kernel. It enables the use of poll() on sysfs alarm attributes which
I think is useful and desirable, and it generates a uevent to enable
script handling, which I also think makes sense.

But on the other side I _did_ ask a couple of times on the list (I am
sure I copied you) if we should have guidelines for the use of
sysfs_notify() and kobject_uevent() in hwmon drivers. Unfortunately, I
didn't get any replies.

As for getting and handling interrupts, there another example for that.
The lm90 driver already implements alert handling. Today it only
generates a log message, but one could imagine generating a uevent
and/or sysfs notifications. Problem with sysfs notifications, though, is
that smbus alerts are only generated for 0->1 transitions, not for 1->0
transitions. This again leads to the question if and how to use
sysfs_notify() in such cases.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
