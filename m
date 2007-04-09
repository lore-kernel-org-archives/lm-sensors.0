From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 09 Apr 2007 12:26:06 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <461A30DE.80403@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
>=20
> On Sun, 08 Apr 2007 19:36:47 +0200, Hans de Goede wrote:
>> Hans-J=FCrgen Koch wrote:
>>> Am Sonntag 08 April 2007 15:51 schrieb Hans de Goede:
>>>
>>>> The abituguru3 has a register which contains a motherboard ID. The cur=
rent
>>>> driver uses this ID, to look up info about the motherboard in a somewh=
at
>>>> lenght table in the driver.=20
>>> Can you elaborate your design decision a bit? My first idea would be to=
 have
>>> a sysfs file that delivers that motherboard ID and then do the lookup in
>>> user space.
>=20
> I guess that the motherboard ID can be retrieved in user-space using
> dmidecode, can't it? So it might not even be needed to export it.
>=20

Nope, the motherboard ID used by the chip is a 16 bit unsigned int, not som=
e=20
kinda string like dmidecode gives.

>> As I don't want the abituguru3 driver to create entries in sysfs for sen=
sors=20
>> which aren't there, and as without the table in the driver I cannot be s=
ure=20
>> wether to create an in / temp / fan device for a given sensor address. L=
ast but=20
>> not least doing things this way allows me to always give a proper readin=
g=20
>> without userspace needing to "guess" any further nescesarry calculations=
 to get=20
>> from the reading to an actual measurement.
>=20
> This is absolutely not different from all other hardware monitoring
> drivers. And all other drivers handle it in user-space, because that's
> the right design. I see no valid reason why it would be different for
> your abituguru3 driver. All you need is one configuration file per
> motherboard.
>=20

Actually it is _very_ different. The uguru is not a chip, its more a piece =
of=20
software (looking from the driver POV) then a chip, thus sensors which aren=
't=20
there really aren't there, they are not just unconnected pins, they _really=
_=20
aren't there.

And afaik some drivers have magic and or module options to not generate=20
generate certain sysfs entries in certain cases, this is no different.

Also this is they way how Abit handles this. The windows software comes wit=
h an=20
ini-files, each named with the hex value of the ID, and that is used to=20
determine how to talk to the uguru (which addresses to use) and what to ask.

Last but not least, this way (with libsensors-support and/or dyn chip suppo=
rt),=20
the experience is truely plug and play, isn't that what we want in the end?

The same argument could be made for PCI ID tables in the kernel for hardwar=
e=20
not essential to booting (or through ramdisk, even for boot essential hardw=
are)=20
why have the PCI-id's in the kernel? Why not have them in userspace and alw=
ays=20
use the new_id sysfs files?

Again the same argument could be made for blacklists / whitelists for many =

things in the kernel. There always is a trade-off, between putting this inf=
o in=20
the kernel or in userspace. You yourself agreed, that given the limited amo=
unt=20
of motherboards featuring the uguru, it might even be an idea to add an exp=
ort=20
a dmi-info-table with the supported motherboards to the driver, how is this=
=20
different?

Regards,

Hans







_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
