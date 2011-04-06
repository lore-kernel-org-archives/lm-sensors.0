From: Natarajan Gurumoorthy <natg@google.com>
Date: Wed, 06 Apr 2011 02:50:47 +0000
Subject: Re: [lm-sensors] [PATCH] Make all it87 drivers SMP safe.
Message-Id: <BANLkTinSAOxNkjxMGewfPUc0-bjf9MesGA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302038697-28985-1-git-send-email-natg@google.com>
	<20110405223814.GA21350@ericsson.com>
	<BANLkTimQDVYe53K-M173iQtmkHzKg6Djyg@mail.gmail.com>
	<20110406000528.GB21350@ericsson.com>
	<BANLkTi==zj3PoNuqf2=THaHzevvHHsuh=w@mail.gmail.com>
	<20110406004312.GA21882@ericsson.com>
In-Reply-To: <20110406004312.GA21882@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

Guenter,
      Thank you for spotting the fact the everything goes south if you
disable "watchdog". I am working on a solution. Looks like the ideal
place to store it87_io_lock.c will be drivers/misc and the IT87_LOCK
config will be placed before the MISC_DEVICES entry in
drivers/misc/Kconfig file. This will be similar to the
SENSORS_LIS3LV02D entry in that Kconfig file.

      Now going back to the partitioning do I send this change out as
a multi patch set consisting of 4 parts something as below:

patch 0 has a description

patch 1 has only the lock and related files
        drivers/misc/Kconfig
        drivers/misc/Makefile
        include/linux/it87_lock.h
        drivers/misc/it87_lock.c

patch 2 has drivers/watchdog changes
        drivers/watchdog/Kconfig
        drivers/watchdog/it8712f_wdt.c
        drivers/watchdog/it87_wdt.c

patch 3 has drives/hwmon changes
        drivers/hwmon/Kconfig
        drivers/hwmon/it87.c

Regards
Nat

On Tue, Apr 5, 2011 at 5:43 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
>
> On Tue, Apr 05, 2011 at 08:13:50PM -0400, Natarajan Gurumoorthy wrote:
> > Guenter,
> > =A0 =A0 =A0 How would you partition it out? Are you suggesting that we =
do
> > the following:
> >
> > Patch1:
> > =A0 =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> > =A0 =A0drivers/hwmon/it87.c =A0 =A0 =A0 =A0 =A0 | =A0 14 ++++++++++++-
> >
> > Patch2:
> > =A0 =A0drivers/watchdog/Kconfig =A0 =A0 =A0 | =A0 12 +++++++++++
> > =A0 =A0drivers/watchdog/Makefile =A0 =A0 =A0| =A0 =A01 +
> > =A0 =A0drivers/watchdog/it8712f_wdt.c | =A0 10 ++++----
> > =A0 =A0drivers/watchdog/it87_lock.c =A0 | =A0 27 ++++++++++++++++++++++=
+++
> > =A0 =A0drivers/watchdog/it87_wdt.c =A0 =A0| =A0 42 ++++++--------------=
-------------------
> >
> > Patch3:
> > =A0 =A0include/linux/it87_lock.h =A0 =A0 =A0| =A0 28 ++++++++++++++++++=
++++++++
> >
> No, not really. The include file is part of the locking code, and the seq=
uence is wrong.
>
> I personally would introduce the lock in the 1st patch.
> This would affect
> =A0 =A0 =A0 =A0drivers/watchdog/it87_lock.c
> =A0 =A0 =A0 =A0include/linux/it87_lock.h
> =A0 =A0 =A0 =A0drivers/watchdog/Makefile
> =A0 =A0 =A0 =A0drivers/watchdog/Kconfig
>
> The second patch would update the watchdog driver, affecting
> =A0 =A0 =A0 =A0drivers/watchdog/Kconfig
> =A0 =A0 =A0 =A0drivers/watchdog/it8712f_wdt.c
>
> and the last patch would update the hwmon driver.
> =A0 =A0 =A0 =A0drivers/hwmon/Kconfig
> =A0 =A0 =A0 =A0drivers/hwmon/it87.c
>
> Others may argue that patch 1 and 2 (introducing the lock and updating
> the watchdog driver) should be in a single patch, since the lock alone
> does not do anything without being used. This is a matter of opinion
> and really depends on the maintainer of the watchdog subsystem.
>
> Note that your patch has practical problems. If I disable WATCHDOG but en=
able
> the IT87 hwmon driver, I get:
>
> warning: (SENSORS_IT87) selects IT87_LOCK which has unmet direct dependen=
cies (WATCHDOG)
>
> during configuration, and undefined references to it87_io_lock when linki=
ng.
> So it looks like you might want to consider moving the locking code to a =
location
> outside the watchdog code.
>
> Thanks,
> Guenter



--
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
