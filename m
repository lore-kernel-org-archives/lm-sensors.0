From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 Aug 2010 17:08:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add tempX_emergency to sysfs ABI
Message-Id: <20100826170802.GC19423@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282838085-7210-1-git-send-email-guenter.roeck@ericsson.com>
 <20100826161022.GA1383@khazad-dum.debian.net>
In-Reply-To: <20100826161022.GA1383@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Randy Dunlap <rdunlap@xenotime.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, Aug 26, 2010 at 12:10:23PM -0400, Henrique de Moraes Holschuh wrote:
> On Thu, 26 Aug 2010, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > tempX_emergency will be used by max6696. It can also be used for other chips
> > supporting three upper temperature limits.
> > 
> >  Documentation/hwmon/sysfs-interface |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > index ff45d1f..1ceb2b9 100644
> > --- a/Documentation/hwmon/sysfs-interface
> > +++ b/Documentation/hwmon/sysfs-interface
> > @@ -310,6 +310,12 @@ temp[1-*]_crit_hyst
> >  		from the critical value.
> >  		RW
> >  
> > +temp[1-*]_emergency
> > +		Temperature emergency value, typically greater than
> > +		corresponding temp_crit values.
> > +		Unit: millidegree Celsius
> > +		RW
> > +
> 
> If we have two-level alarms: critical, then emergency, it is best to have
> that written down than to imply it by "typically greater than corresponding
> temp_crit"...
> 
Do you have a better wording in mind ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
