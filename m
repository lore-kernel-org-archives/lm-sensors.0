From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 04 Mar 2011 01:01:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add tachometer pulses per fan
Message-Id: <20110304010118.GC31318@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299108238-14822-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299108238-14822-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 03, 2011 at 05:36:36PM -0500, Jean Delvare wrote:
> On Wed, 2 Mar 2011 15:23:58 -0800, Guenter Roeck wrote:
> > Some fan control chips support a configuration register to set the number of
> > tachometer pulses per fan revolution. Add an ABI attribute to support this
> > configuration register.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  Documentation/hwmon/sysfs-interface |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > index c6559f1..134c6a4 100644
> > --- a/Documentation/hwmon/sysfs-interface
> > +++ b/Documentation/hwmon/sysfs-interface
> > @@ -187,6 +187,12 @@ fan[1-*]_div	Fan divisor.
> >  		Note that this is actually an internal clock divisor, which
> >  		affects the measurable speed range, not the read value.
> >  
> > +fan[1-*]_pulses	Number of tachometer pulses per fan revolution.
> 
> It might be good to specify that this is a characteristic of the fan
> connected to the device's input, so you have to set the value in
> accordance with the fan model.
> 
> > +		Integer value, typically between 1 and 4.
> > +		RW
> > +		Should only be created if the chip has a register to configure
> > +		the value.
> 
> You could mention that, in the absence of register (and thus attribute)
> the value assumed by all devices is 2 pulses per fan revolution because
> almost all fans do this.
> 
Both make sense. I'll make those changes.

> 
> I'm fine with this new attribute. We'll need support in libsensors too,
> so that users can change the settings through configuration file +
> "sensors -s".
> 
Ok. Note though that I still have the other changes (support for new attributes)
pending against the sensors command.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
