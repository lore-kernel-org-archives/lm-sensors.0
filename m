From: "Shem Multinymous" <multinymous@gmail.com>
Date: Sat, 01 Sep 2007 18:05:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters to
Message-Id: <41840b750709011105s6c434217t50d965a0b17df643@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com>
	 <20070828015029.GA10107@khazad-dum.debian.net>
	 <20070828131942.18449886@hyperion.delvare>
	 <20070828164440.GL32667@tree.beaverton.ibm.com>
	 <20070901171048.GA3883@ucw.cz>
In-Reply-To: <20070901171048.GA3883@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Jean Delvare <khali@linux-fr.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 9/1/07, Pavel Machek <pavel@ucw.cz> wrote:
> > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > index b3a9e1b..da546ce 100644
> > --- a/Documentation/hwmon/sysfs-interface
> > +++ b/Documentation/hwmon/sysfs-interface
> > @@ -304,6 +304,21 @@ curr[1-*]_input  Current input value
> >               Unit: milliampere
> >               RO
> >
> > +*********
> > +* Power *
> > +*********
> > +
> > +power[1-*]_input     Current power use
> > +                     Unit: milliWatt
> > +                     RO
> > +
> > +power[1-*]_max_input Historical maximum power use
> > +                     Unit: milliWatt
> > +                     RO
> > +
> > +power[1-*]_min_input Historical minimum power use
> > +                     Unit: milliWatt
> > +                     RO
>
> Should we add power?_10sec_avg_input? IIRC thinkpads export that,
> too.

Indeed, ThinkPads report both instantaneous power/current and a
rolling average (exponentially decaying, I think) over the last ~10
seconds. ACPI provides only the rolling average, and the out-of-tree
tp_smapi driver provides both.

More generally, linux/power_supply.h defines these attributes:

	POWER_SUPPLY_PROP_VOLTAGE_NOW,
	POWER_SUPPLY_PROP_VOLTAGE_AVG,
	POWER_SUPPLY_PROP_CURRENT_NOW,
	POWER_SUPPLY_PROP_CURRENT_AVG,

It would be nice if the power meter interface uses the same
conventions as the power supply interface, since the former is
essentially a subset of the latter. Userspace app that read power
meters via sysfs should work for power supplies too.

  Shem

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
