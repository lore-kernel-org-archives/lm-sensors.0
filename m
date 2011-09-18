From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Sep 2011 20:04:14 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110918220414.5c153b36@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Sep 2011 09:46:32 -0700, Guenter Roeck wrote:
> On Sun, Sep 18, 2011 at 09:30:22AM -0400, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Sat, 17 Sep 2011 09:31:38 -0700, Guenter Roeck wrote:
> > > The lm90 driver with its LM90_HAVE_BROKEN_ALERT flag has the same problem.
> > > Sure, one can simply disable alerts forever after the first alert is triggered,
> > > as the driver does right now, but that is really just as helpful as having
> > > no alerts at all.
> > 
> > This isn't what the lm90 driver is doing. Look at the end of
> > lm90_update_device(), alarms are re-enabled if needed. I agree that it
> > isn't bullet proof, as it only works if user-space is reading at least
> > one value repeatedly, but it's way better than what you described.
>
> Ah, I missed that. Not much better, though. It means that applications
> would have to start polling after the first alarm is seen on a device,
> and keep doing so until the last alarm is gone.

Correct. Following your idea, this could be replaced by a kernel
thread / tasklet / whatever that would only run when needed.

I wonder if someday hardware vendors will start doing their work
properly so that we don't have to bloat our driver code? Probably not :(

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
