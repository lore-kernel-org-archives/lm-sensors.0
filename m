From: Natarajan Gurumoorthy <natg@google.com>
Date: Wed, 06 Apr 2011 00:13:50 +0000
Subject: Re: [lm-sensors] [PATCH] Make all it87 drivers SMP safe.
Message-Id: <BANLkTi==zj3PoNuqf2=THaHzevvHHsuh=w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302038697-28985-1-git-send-email-natg@google.com>
	<20110405223814.GA21350@ericsson.com>
	<BANLkTimQDVYe53K-M173iQtmkHzKg6Djyg@mail.gmail.com>
	<20110406000528.GB21350@ericsson.com>
In-Reply-To: <20110406000528.GB21350@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

Guenter,
=A0 =A0 =A0 How would you partition it out? Are you suggesting that we do
the following:

Patch1:
=A0 =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
=A0 =A0drivers/hwmon/it87.c =A0 =A0 =A0 =A0 =A0 | =A0 14 ++++++++++++-

Patch2:
=A0 =A0drivers/watchdog/Kconfig =A0 =A0 =A0 | =A0 12 +++++++++++
=A0 =A0drivers/watchdog/Makefile =A0 =A0 =A0| =A0 =A01 +
=A0 =A0drivers/watchdog/it8712f_wdt.c | =A0 10 ++++----
=A0 =A0drivers/watchdog/it87_lock.c =A0 | =A0 27 +++++++++++++++++++++++++
=A0 =A0drivers/watchdog/it87_wdt.c =A0 =A0| =A0 42 ++++++------------------=
---------------

Patch3:
=A0 =A0include/linux/it87_lock.h =A0 =A0 =A0| =A0 28 ++++++++++++++++++++++=
++++

Nat

On Tue, Apr 5, 2011 at 5:05 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Tue, Apr 05, 2011 at 07:03:35PM -0400, Natarajan Gurumoorthy wrote:
>> Guenter,
>> =A0 =A0 =A0 =A0This patch patch applies a common fix to all IT87 driver.=
 Separating it
>> into 2 patches (one for drivers/hwmon and one for drivers/watchdog) does=
 not
>> seem to be the right thing to do. I think having all the patches in one =
file
>> makes it easier to understand the rationale behind the patch. The
>> it87_io_lock.c and it87_io_lock.h files are in drivers/watchdog director=
y and
>> the lock defined in it is needed by the changes in drivers/hwmon/it87.c
>>
>
> I dislike the idea of a single patch crossing multiple subsystems. Maybe =
you'll
> find another maintainer accepting your change as a single patch, but I wo=
n't.
>
> That doesn't mean that the patches would have to be committed into multip=
le trees.
> That is for the subsystem maintainers to sort out, and a different issue.
>
> Thanks,
> Guenter
>



--
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
