From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Thu, 16 Sep 2010 15:42:43 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (adm1031) Replace update_rate
Message-Id: <20100916154243.GB25145@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284602835-7605-1-git-send-email-guenter.roeck@ericsson.com>
 <1284602835-7605-2-git-send-email-guenter.roeck@ericsson.com>
 <20100916171443.0322bdb6@hyperion.delvare>
In-Reply-To: <20100916171443.0322bdb6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, 16 Sep 2010, Jean Delvare wrote:
> On Wed, 15 Sep 2010 19:07:14 -0700, Guenter Roeck wrote:
> > The attribute reflects an interval, not a rate.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  Documentation/hwmon/sysfs-interface |   12 +++++-----
> >  drivers/hwmon/adm1031.c             |   43 +++++++++++++++++++---------------
> >  2 files changed, 30 insertions(+), 25 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > index ff45d1f..df0cdd2 100644
> > --- a/Documentation/hwmon/sysfs-interface
> > +++ b/Documentation/hwmon/sysfs-interface
> > @@ -91,13 +91,13 @@ name		The chip name.
> >  		I2C devices get this attribute created automatically.
> >  		RO
> >  
> > -update_rate	The rate at which the chip will update readings.
> > -		Unit: millisecond
> > +update_interval	The interval at which the chip or driver will update readings.
> 
> I think I prefer the original wording. The attribute is really about
> setting the register refresh rate at the hardware level. The fact that

Only, it doesn't set any rates in the hardware.  It sets the period
(interval).

If the unit of update_rate is changed to Hz, and the driver does
hardware_timer_milliseconds = 1000/update_rate_Hz, THEN it will be
correct to call it a rate...

I'd rather have it in Hz, actually.  I consider that more user-friendly.
But that's just personal preference.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
