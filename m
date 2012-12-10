From: Rene Rebe <rene@exactcode.com>
Date: Mon, 10 Dec 2012 21:30:08 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: add sysfs file to report OSK
Message-Id: <F7D71BD5-59D8-4DDA-9537-606DF222DBA5@exactcode.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121210145134.GA2097@hedwig.ini.cmu.edu> <20121210190905.GA24927@roeck-us.net> <20121210195414.GA642@polaris.bitmath.org> <4BC00520-E08A-43D0-AA2B-EA8154F3D160@suse.de> <4017A6C6-3074-44A5-AAAC-F4246946F151@exactcode.com> <28FE8A08-131B-4E20-BBC0-EEDDA129C1C8@suse.de>
In-Reply-To: <28FE8A08-131B-4E20-BBC0-EEDDA129C1C8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alexander Graf <agraf@suse.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, Guenter Roeck <groeck-dsl@sbcglobal.net>, "Gabriel L. Somlo" <somlo@cmu.edu>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


On 10.12.2012, at 22:24, Alexander Graf wrote:

> On 10.12.2012, at 21:43, Rene Rebe <rene@exactcode.com> wrote:
>=20
>> On 10.12.2012, at 21:19, Alexander Graf <agraf@suse.de> wrote:
>>>=20
>>> On 10.12.2012, at 20:54, Henrik Rydberg wrote:
>>>=20
>>>> Hi Guenter,
>>>>=20
>>>>> On Mon, Dec 10, 2012 at 09:51:35AM -0500, Gabriel L. Somlo wrote:
>>>>>> The AppleSMC contains two char[32] keys, OSK0 and OSK1, which are not
>>>>>> reported in the key count and index by default. These keys are used =
by
>>>>>> the OS X boot sequence, and normally don't matter when running Linux.
>>>>>>=20
>>>>>> This patch creates a sysfs entry which reports the value of these ke=
ys
>>>>>> as an ASCII string, to help emulators (such as QEMU) load OS X when
>>>>>> running on genuine Apple hardware.
>>>>>>=20
>>>>>> Signed-off-by: Gabriel L. Somlo <somlo@cmu.edu>
>>>>>> ---
>>>>>>=20
>>>>>> For extra context: To boot OS X as a guest, QEMU must (among others)
>>>>>> emulate the AppleSMC. To boot successfully, OS X insists on querying
>>>>>> the (emulated) SMC for the value of OSK0 and OSK1. Currently, these
>>>>>> values must be supplied on the QEMU command line as
>>>>>>=20
>>>>>> -device applesmc,osk=3D"...concatenated values of OSK0 and OSK1..."
>>>>>>=20
>>>>>> With the availability of /sys/devices/platform/applesmc.768/osk, the
>>>>>> emulated QEMU AppleSMC could acquire this string directly from the
>>>>>> (Apple-manufactured) host machine.
>>>>> Hmm ... this is a non-hwmon attribute which doesn't really belong int=
o hwmon
>>>>> in the first place ... like several other attributes in the same driv=
er.
>>>>>=20
>>>>> So I'll leave it up to the maintainer to decide if we should accept i=
t. Henrik ?
>>>>=20
>>>> Indeed, the reaons against this patch are too many. I was just about
>>>> to reply with the below:
>>>>=20
>>>> Gabriel,
>>>>=20
>>>> The OSK string seems constant accross machines, which renders the
>>>> patch rather pointless, no? And even if the OSK differs between a
>>>> couple of machines, the emulator could easily handle it gracefully.
>>>=20
>>> The point is that the return value of the OSK is a copyrighted string, =
we can not include in any other layer. The only way to make this legally sa=
vvy is to read the key from the host.
>>>=20
>>>>=20
>>>> There are also some technical issues with the patch below, to keep in
>>>> mind for future submissions.
>>>=20
>>> Sigh - most of the comments below go back to earlier review from me. He=
 basically had a version almost exactly like what you're asking him to do :=
). Funny how code style taste differs.
>>=20
>> And this is exactly the reason why I'm less and less motivated to waste =
my lifetime with upstream work ...
>=20
> It's nit that bad really. Gabriel can just send his earlier version again=
 with the ret variable name changed and then it shouldn't be an issue to ge=
t it in.
>=20
> Reading the key really is an important bit in creating a legally safe and=
 easy method to virtualize Mac OS X on Linux. Just believe us on this one :=
).

Sure, you do not need to convince me about that ;-)

--=20
  Ren=E9 Rebe, ExactCODE GmbH, Jaegerstr. 67, DE-10117 Berlin
  http://exactcode.com | http://t2-project.org | http://rene.rebe.de


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
