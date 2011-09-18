From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Sep 2011 13:30:22 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110918153022.3f431470@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 17 Sep 2011 09:31:38 -0700, Guenter Roeck wrote:
> The lm90 driver with its LM90_HAVE_BROKEN_ALERT flag has the same problem.
> Sure, one can simply disable alerts forever after the first alert is triggered,
> as the driver does right now, but that is really just as helpful as having
> no alerts at all.

This isn't what the lm90 driver is doing. Look at the end of
lm90_update_device(), alarms are re-enabled if needed. I agree that it
isn't bullet proof, as it only works if user-space is reading at least
one value repeatedly, but it's way better than what you described.

> My current solution is to revert to in-kernel polling while alarms are active.
> This way I can re-enable alerts after the alarms are no longer active,
> and the additional overhead is quite low since the polling thread only runs
> while there are active alarms.
> 
> If we declare that applications can only depend on 0->1 transitions, I would
> still need in-kernel polling to be able to re-enable alerts. As a result, we
> would end up with double polling - by the kernel _and_ by the application.
> That would really be undesirable.

I agree. I suggested user-space polling because I didn't know there was
a need for in-kernel polling. If you think that this will be the case
for most drivers, then I have no objection to specifying that drivers
should notify both directions or neither, i.e. no user-space polling.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
