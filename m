From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 06 Apr 2011 21:35:07 +0000
Subject: Re: [lm-sensors] [PATCH] Make all it87 drivers SMP safe.
Message-Id: <BANLkTimeAh3pm=Z73hYPPfAJfu8J5=tPpw@mail.gmail.com>
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
In-Reply-To: <BANLkTimTfWrx-ezyerRTtZHrLdOOf2V19w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Natarajan Gurumoorthy <natg@google.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

On Wed, Apr 6, 2011 at 3:04 AM, Natarajan Gurumoorthy <natg@google.com> wro=
te:
> Guenter,
> =A0 =A0 =A0Thank you for your feedback. I found an easier way to deal with
> the it87_lock.c file. I do not need to move it to the driver/misc
> directory. The easier thing to do was to move the IT87_LOCK entry to
> the beginning of the drivers/watchdog/Kconfig file. This moves the
> entry before the "menuconfig WATCHDOG" entry. They use the exact same
> trick in drivers/misc/Kconfig file. The very first lines of
> drivers/watchdog/Kconfig file will look something like this:

Is the Kconfig even warranted?  I mean, if there is a shared resource
and it needs locking, then just apply the locking.   Where is the value
in adding another Kconfig?

Also the it87_lock.h file -- maybe you want to just call it it87.h -- then
if someone in the future cleans up the drivers and makes some macros
that can be shared across all the drivers, there is already a proper home
for such macros.  No point painting yourself in a corner and making the
file lock specific right from the beginning.

Paul.

>
> #
> # Watchdog device configuration
> #
>
> # This one has to live outside of the WATCHDOG conditional,
> # because it may be selected by drivers/hwmon/it87.c.
> config IT87_LOCK
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0default n
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0This defines the global lock needed by all IT87 driver=
s that
> =A0 =A0 =A0 =A0 =A0touch the Super I/0 chipset used on many motherboards.=
 This
> =A0 =A0 =A0 =A0 =A0is needed to serialize access to the registers in SMP
> =A0 =A0 =A0 =A0 =A0systems. All it87 drivers will select this Kconfig opt=
ion to compile
> =A0 =A0 =A0 =A0 =A0the lock into the kernel.
>
> menuconfig WATCHDOG
> =A0 =A0 =A0 =A0bool "Watchdog Timer Support"
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0If you say Y here (and to one of the following options=
) and create a
>
> Regards
> Nat
>
> On Tue, Apr 5, 2011 at 8:02 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
>> On Tue, Apr 05, 2011 at 10:50:47PM -0400, Natarajan Gurumoorthy wrote:
>>> Guenter,
>>> =A0 =A0 =A0 Thank you for spotting the fact the everything goes south i=
f you
>>> disable "watchdog". I am working on a solution. Looks like the ideal
>>> place to store it87_io_lock.c will be drivers/misc and the IT87_LOCK
>>> config will be placed before the MISC_DEVICES entry in
>>> drivers/misc/Kconfig file. This will be similar to the
>>> SENSORS_LIS3LV02D entry in that Kconfig file.
>>>
>> Almost, only afaik that is only used inside the misc directory, or at le=
ast
>> has some other components there. I don't really know how to handle this
>> situation correctly, except you could of course write a mfd driver to ha=
ndle
>> the generic parts.
>>
>>> =A0 =A0 =A0 Now going back to the partitioning do I send this change ou=
t as
>>> a multi patch set consisting of 4 parts something as below:
>>>
>>> patch 0 has a description
>>>
>>> patch 1 has only the lock and related files
>>> =A0 =A0 =A0 =A0 drivers/misc/Kconfig
>>> =A0 =A0 =A0 =A0 drivers/misc/Makefile
>>> =A0 =A0 =A0 =A0 include/linux/it87_lock.h
>>> =A0 =A0 =A0 =A0 drivers/misc/it87_lock.c
>>>
>>> patch 2 has drivers/watchdog changes
>>> =A0 =A0 =A0 =A0 drivers/watchdog/Kconfig
>>> =A0 =A0 =A0 =A0 drivers/watchdog/it8712f_wdt.c
>>> =A0 =A0 =A0 =A0 drivers/watchdog/it87_wdt.c
>>>
>>> patch 3 has drives/hwmon changes
>>> =A0 =A0 =A0 =A0 drivers/hwmon/Kconfig
>>> =A0 =A0 =A0 =A0 drivers/hwmon/it87.c
>>>
>> Something like that. I have some doubts about using drivers/misc,
>> but I guess you'll get feedback on that after you submit the patch set.
>>
>> Thanks,
>> Guenter
>>
>
>
>
> --
> Regards
> Nat Gurumoorthy AB6SJ
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
