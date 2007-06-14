From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jun 2007 19:13:31 +0000
Subject: Re: [lm-sensors] sis5595
Message-Id: <20070614211331.27e3ac12@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

On Tue, 12 Jun 2007 19:42:29 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > If you can't get additional information, you can label in4 "CPU Temp",
> > observe the reading over a period of time, and set arbitrary limits
> > accordingly. Unfortunately we have no way to tell "sensors" that a
> > voltage input is actually a temperature value.
> 
> Is it possible other motherboards manufacturers have done something similar?

Well, it is possible to do this with virtually any voltage input of all
driver. But maybe this is more likely for the in4 of the sis5595
because it can already be used for temperature monitoring (although in
a technically different way.)

> Ifso would it be an idea to add a driver flag to rename all the in4 sysfs attr 
> to tempX sysfs attr, without changing the way how things are read?

Yes, this could be done, shouldn't be too expensive.

A more generic solution would be to implement this in libsensors. For
that we'd need a new sensors.conf directive to change the type of a
given sensor (from voltage to temp in this case). After all, the only
difference is the unit displayed after the value. There are a few
driver which could use this: pc87360, vt8231... which currently export
voltage value as temp* files for thermistor-based measurements.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
