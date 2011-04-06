From: Natarajan Gurumoorthy <natg@google.com>
Date: Wed, 06 Apr 2011 21:45:21 +0000
Subject: Re: [lm-sensors] [PATCH] Make all it87 drivers SMP safe.
Message-Id: <BANLkTinT1td=kovSFRu=j5-qwHJ7na6v0Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302038697-28985-1-git-send-email-natg@google.com>
	<20110405223814.GA21350@ericsson.com>
	<BANLkTimQDVYe53K-M173iQtmkHzKg6Djyg@mail.gmail.com>
	<20110406000528.GB21350@ericsson.com>
	<BANLkTi==zj3PoNuqf2=THaHzevvHHsuh=w@mail.gmail.com>
	<20110406004312.GA21882@ericsson.com>
	<BANLkTinSAOxNkjxMGewfPUc0-bjf9MesGA@mail.gmail.com>
	<20110406030220.GB22535@ericsson.com>
	<BANLkTimTfWrx-ezyerRTtZHrLdOOf2V19w@mail.gmail.com>
	<BANLkTimeAh3pm=Z73hYPPfAJfu8J5=tPpw@mail.gmail.com>
In-Reply-To: <BANLkTimeAh3pm=Z73hYPPfAJfu8J5=tPpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

Paul,
     Comments are below.

On Wed, Apr 6, 2011 at 2:35 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On Wed, Apr 6, 2011 at 3:04 AM, Natarajan Gurumoorthy <natg@google.com> w=
rote:
>> Guenter,
>> =A0 =A0 =A0Thank you for your feedback. I found an easier way to deal wi=
th
>> the it87_lock.c file. I do not need to move it to the driver/misc
>> directory. The easier thing to do was to move the IT87_LOCK entry to
>> the beginning of the drivers/watchdog/Kconfig file. This moves the
>> entry before the "menuconfig WATCHDOG" entry. They use the exact same
>> trick in drivers/misc/Kconfig file. The very first lines of
>> drivers/watchdog/Kconfig file will look something like this:
>
> Is the Kconfig even warranted? =A0I mean, if there is a shared resource
> and it needs locking, then just apply the locking. =A0 Where is the value
> in adding another Kconfig?
>
The reason we are forced to do this is that all the it87 drivers are
usually modules. We need a global lock that is compiled into the
kernel if one or more of these drivers are selected. If none of them
are specified then the lock is not built into the kernel. The Kconfig
entry that I have put is not human selectable. When any IT87 driver is
selected it will select IT87_LOCK there by compiling the lock into the
kernel.

--=20
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
