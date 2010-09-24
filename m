From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 24 Sep 2010 17:14:24 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <4C9CDC70.5020508@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5heiclngqe.wl%tiwai@suse.de>	<20100924135802.GA18109@ericsson.com>	<s5hlj6r1b5p.wl%tiwai@suse.de>	<20100924163005.7704f63e@endymion.delvare> <4C9CC219.4090304@tremplin-utc.net>
In-Reply-To: <4C9CC219.4090304@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>

On 09/24/10 16:22, =C9ric Piel wrote:
> Op 24-09-10 16:30, Jean Delvare schreef:
>> Well, as long as the driver lives in drivers/hwmon and the hwmon
>> subsystem is maintained, it seems fair to consider the driver
>> maintained.
>>
>> That being said, I indeed would like all non-hwmon drivers to go away
>> from drivers/hwmon. Originally we were waiting for iio to settle first,
>> but apparently this is taking forever. The 4 drivers I would like to
>> kick are: ams, hdaps, lis3lv02d and applesmc. They are primarily
>> accelerometer device drivers. Not sure where to put them,
>> drivers/accel(erometer), drivers/misc, drivers/misc/accel(erometer),
>> drivers/input/accel(erometer)... Opinions welcome.
> As maintainer of the lis3lv02d driver, I'd completely support the move to=
o.
>=20
> IMHO, an accelerometer is just another input device (usually with 2 or 3
> axes),
That is not actually all that true in general. There are an awful lot of pa=
rts
that aren't even vaguely designed for 'human' input.
In some restricted cases I'm happy to agree though and that definitely incl=
udes
3 axis sensors with input specific features like those your driver covers.

> so moving them to drivers/input/accel would make sense.
Propose a move on linux-input and see what the response is.  Currently
they are going in drivers/input/misc, but that is probably just because the=
re
aren't enough of them yet to justify their own directory.

Dmitry is taking them slowly (mainly I think because he wants the interface=
s to
be more pinned down).   The adxl34x driver is already there, Hemanth's
cma3000 is close (either dropping some knobs in sysfs or working out
naming that everyone interested can agree on).  I would imagine the awkward
bits will be things like freefall detectors that no one can reasonably argue
are a conventional form of 'human' input.

As an aside, we are trying to work out a unified interface between IIO and
input for some elements and a userspace bridge where that doesn't make sens=
e.
There are ongoing (if rather quiet) discussions on this on linux-input / lk=
ml.
http://lkml.org/lkml/2010/9/21/167 I would certainly welcome any comments /=
=20
suggestions anyone would like to make.  The intent here is to pin down the
naming conventions as independently as possible of the actual subsystem han=
dling
the device, but to keep them general enough as to be able to cover a wide r=
ange
of different sensors.
=20
Cheers,

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
