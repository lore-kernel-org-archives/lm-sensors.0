From: Martin Peres <martin.peres@free.fr>
Date: Sun, 13 Feb 2011 20:00:16 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <4D583850.1050806@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr> <20110213171640.GB13323@ericsson.com>
In-Reply-To: <20110213171640.GB13323@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: nouveau <Nouveau@lists.freedesktop.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Le 13/02/2011 18:16, Guenter Roeck a =E9crit :
> On Sun, Feb 13, 2011 at 07:18:44AM -0500, Martin Peres wrote:
>> Hi,
>>
>> I am working on power management on the nouveau driver and I need a way
>> to get data out of and send commands to the i2c drivers from the kernel
>> space.
>>
>> We can already change the clocks of the card, but we need a way to
>> monitor the temperature and bump the fan speed if needed.
>> Another problem with letting users mess with the i2c driver by
>> themselves is that some cards use the i2c driver for fan management
>> while others don't. This is why I would like to introduce nouveau as an
>> hwmon driver, exporting the temperature, fan management and clock speeds
>> so as we can use the thermal zone to monitor the temperature and react
>> when needed.
>>
>> So far, we use:
>> - w83l785ts
>> - w83781d
>> - adt7473 (most common one)
>> - f75375
>> - lm99
>>
>> With the help of Matthew Garret, I updated his previous proposal for an
>> in-kernel API for hwmon. The patch should apply cleanly on Linux
>> 2.6.38-rc4. This patch only provides the API, no modification to the
>> drivers has been completed yet.
>>
>> Looking forward to your review and feedback.
>>
>> Martin
>>  From 059b647b7b8bd98c04cf48b4062048b8ae963593 Mon Sep 17 00:00:00 2001
>> From: Martin Peres<martin.peres@ensi-bourges.fr>
>> Date: Sun, 13 Feb 2011 11:35:17 +0100
>> Subject: [PATCH] hwmon API update
>>
>> Original creator: Matthew Garrett<mjg@redhat.com>
>>
>> Signed-off-by: Martin Peres<martin.peres@ensi-bourges.fr>
> This is an extremely complex change just for the benefit of one driver,
> with a huge potential of misuse. The changes required in each driver
> to actually implement the API are substantial, and pretty much only add
> complexity to each hwmon driver with no real benefit.
>
> The cost gets even larger if one has to consider that some may want or
> have to to backport drivers to earlier kernel versions. This patchset
> would result in significant efforts to do such backports.
>
> For the API itself, there are lots of functions with similar parameters,
> and those parameters are needed in the drivers to determine which attribu=
te
> is affected. A single function would have accomplished the same, as the d=
rivers
> will need case statements anyway to identify the actual attribute to be r=
ead
> or written. What we end up here with is a large number of functions to be
> supported by each driver, all with pretty much the same set of arguments.
>
> I don't know what current thinking is about kernel size increases, but it
> looks like this patch will result in quite significant kernel size increa=
se
> (some 18*8 =3D 144 bytes per driver for all the pointers, plus the actual
> functions, adds up to a lot). Again this would be with no benefit for most
> of the users of the hwmon subsystem. Sure, one can argue that the size in=
creases
> will only occur if the drivers are actually loaded, but that is a pretty =
weak
> argument since the code size increase will still show up in each driver.
>
> In summary I am not in favor for this change. Maybe Jean thinks different=
ly,
> but for my part I don't plan to approve it.
>
> Guenter
Actually, it is not completely true. This API isn't mandatory for the=20
drivers to implement. We could only modify the drivers we need in=20
nouveau and leave the others untouched but this is only good for as a=20
transition from the sysfs-only interface to the new interface.

I agree that changing hwmon in the way we are asking is a big change in=20
philosophy, but what are you suggesting? We can't just re-implement the=20
needed i2c drivers in nouveau and the only way we can access the already=20
existing i2c drivers is through sysfs.

The real question is why hwmon only is targeted for the userland?=20
Another question is, why is the actual code of the drivers buried so=20
deep inside the implementation details of the sysfs interface (this is=20
what makes it so painful to update)?

Actually, this proposal could save space as once this interface is=20
adopted by some drivers, all the sysfs-related code could be shared in=20
hwmon.c.

Another proposal could be to access the drivers through sysfs, but I=20
don't know if it is possible and I think it would be abusing the sysfs=20
interface anyway.

I think you now understand our situation a bit better, do you have any=20
suggestion? I really wish to find an agreement on this as not sharing=20
the code is not an option for me.

Martin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
