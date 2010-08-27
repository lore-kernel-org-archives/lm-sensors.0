From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Fri, 27 Aug 2010 03:45:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add tempX_emergency to sysfs ABI
Message-Id: <20100827034516.GA29304@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282838085-7210-1-git-send-email-guenter.roeck@ericsson.com>
 <20100826161022.GA1383@khazad-dum.debian.net>
 <20100826175141.GA19646@ericsson.com>
In-Reply-To: <20100826175141.GA19646@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Randy Dunlap <rdunlap@xenotime.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, 26 Aug 2010, Guenter Roeck wrote:
> > > +temp[1-*]_emergency
> > > +		Temperature emergency value, typically greater than
> > > +		corresponding temp_crit values.
> > > +		Unit: millidegree Celsius
> > > +		RW
> > > +
> > 
> > If we have two-level alarms: critical, then emergency, it is best to have
> > that written down than to imply it by "typically greater than corresponding
> > temp_crit"...
> > 
> How about:
>         Temperature emergency max value, for chips supporting more than
>         two upper temperature limits. Must be equal or greater than
>         corresponding temp_crit values.
>         Unit: millidegree Celsius
>         RW

Much better, thank you.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
