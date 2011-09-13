From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Sep 2011 14:13:32 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110913161332.089d3e97@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 Sep 2011 18:58:26 +0530, R, Durgadoss wrote:
> Hi Guenter,
> 
> > > The temp1_max is supposed to be more than temp1_input and
> > > temp1_max_hyst is supposed to be lesser than temp1_input.
> > > By default the temp1_max_hyst is left at 0.
> > >
> > Should be set to something useful. Also, it does not have to be less
> > than temp1_input, as long as it is less than temp1_max (which was my
> > understanding). Worst case you would get another interrupt (when the
> > temperature crosses temp1_max_hyst from below) which you would ignore.
> 
> Yes. I agree with you.
> I have no clue on what exact value to set to max and max_hyst initially.
> Can we set temp1_max to 70 and temp1_max_hyst to 50 ?

If anything, then the answer depends on the CPU, as it depends on
TjMax. But more likely, no, we don't want to set these values, as we do
NOT initialize limits in hwmon drivers [1]. The whole point of the
hwmon sysfs interface is to let the user set the limits they want in
sensors.conf. Ideally each CPU would have sane defaults, and failing
that, the BIOS should set appropriate values.

> > Interrupts should be enabled, and you can send uevents and sysfs notifications
> > whenever a threshold is crossed. All you would have to do is to keep the old
> > alarm
> > state and send events whenever it changes.

But who should enable interrupts? And who will receive them? It really
sounds like a task for thermal management, NOT hardware monitoring.
Seems the boundary is getting blurrier every day...

I would like to avoid the case where merely loading the coretemp driver
results in CPU throttling or worse simply because the threshold
settings are wrong.

> > 
> > Example:
> > 	temp@, max_thresholdP, max`
> > 
> > 1st interrupt when temp reaches 50 -> ignore
> > 2nd interrupt when temp reaches 60 -> set alarm, send uevent and sysfs
> > notifications
> > 3rd interrupt when temp reaches 60 (from above) -> ignore
> > 4th interrupt when temp reaches 50 (from above) -> reset alarm, send uevent and
> > sysfs notifications
> 
> Thank you for the example.
> The example is very clear. I will submit a patch to add this functionality
> to coretemp.

Please do, it can only help us move forward. However I suspect that
more discussions and experiments will be needed to come up with the
right solution.

[1] One exception being a few chips which have high limits set to 0 as the
hardware default; in this case we change it to the maximum possible
value at driver initialization time.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
