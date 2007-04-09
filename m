From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 09 Apr 2007 12:50:03 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <461A367B.8040606@hhs.nl>
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

Oh and yet another thing, since when should all conversions be done in=20
userspace? I did exactly that with the abituguru 1/2 driver and there I had=
 to=20
change it to give the return the actual pin values in Volts and not registe=
r=20
values, iow do the conversion in the driver. You are contradicting yourself!

Sorry, but I'm pissed about this you're bashing a driver at which you haven=
't=20
even looked, even though it has been submitted for review in Januari!

Then I asked if it was a good idea if I would exchange reviews with Juerg a=
nd=20
his DME1737 driver, if that was ok with you. I _explictly_ asked this, and =
then=20
after the review and a new version was posted by Juerg, you said that you w=
ould=20
still have to review it yourself. What was the fricking point then in me=20
reviewing it in the first place? Why did you think I asked if it was ok for=
=20
others to review drivers?? I asked because I already was afraid that you wo=
uld=20
not accept reviews done by others, and tada you don't!

This attitude is (needlessly) slowing down lmsensors development, and might=
=20
very well be one of the reasons why there hardly is a development community=
=20
surrounding lmsensors.

Regards,

Hans





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
