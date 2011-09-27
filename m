From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 27 Sep 2011 17:13:26 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: (coretemp) Add support for
Message-Id: <1317143606.3888.86.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316536503-26883-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316536503-26883-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-09-27 at 10:33 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Again, sorry for the late review.
> 
> On Tue, 20 Sep 2011 09:35:03 -0700, Guenter Roeck wrote:
> > Add support for T0 and T1 temperature thresholds using the new sysfs ABI
> > attributes tempX_thresholdY and tempX_thresholdY_triggered.
> >
> > This patch is based on commit c814a4c7c4aad795835583344353963a0a673eb0, which
> > was reverted. For details on the threshold registers, see IA Manual vol 3A,
> > which can be downloaded from here:
> >         http://download.intel.com/design/processor/manuals/253668.pdf
> >
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  Documentation/hwmon/coretemp |    8 ++
> >  drivers/hwmon/coretemp.c     |  160 +++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 158 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
> > index 84d46c0..3c8dd70 100644
> > --- a/Documentation/hwmon/coretemp
> > +++ b/Documentation/hwmon/coretemp
> > @@ -35,6 +35,14 @@ the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
> >  All Sysfs entries are named with their core_id (represented here by 'X').
> >  tempX_input   - Core temperature (in millidegrees Celsius).
> >  tempX_max     - All cooling devices should be turned on (on Core2).
> > +tempX_threshold1 - Reflects value of CPU thermal threshold T0.
> > +tempX_threshold1_triggered
> > +              - Reflects status of CPU thermal status register bit 6
> > +                (THERM_STATUS_THRESHOLD0).
> > +tempX_threshold2 - Reflects value of CPU thermal threshold T1.
> > +tempX_threshold2_triggered
> > +              - Reflects status of CPU thermal status register bit 8
> > +                (THERM_STATUS_THRESHOLD1).
> 
> It's questionable whether we want to map the status bits to _triggered
> files. I'd rather map the log bits THERM_LOG_THRESHOLD[01] to
> _triggered, because these attributes are direction-neutral, and sticky.
> The status bits merely show the result of the real-time comparison
> between the current temperature and the threshold value, this is
> something user-space can compute by itself.
> 
> If we really want to expose the status bits, these shouldn't be
> considered an alarm (as the thresholds can be used as low or high
> temperature limits). _above may be a suitable suffix. But then again
> I'm not sure if we really want to expose this.
> 
Using THERM_LOG_THRESHOLD is fine with me, and I agree it makes more
sense. Only question is what to do after it was read. Auto-reset it, or
provide a write function to reset it ?

I agree with the rest of your comments, and will make the necessary
changes.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
