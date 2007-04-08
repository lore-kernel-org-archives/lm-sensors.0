From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Apr 2007 18:56:30 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <46193ADE.5000303@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hans-J=FCrgen Koch wrote:
> Am Sonntag 08 April 2007 19:36 schrieb Hans de Goede:
>> Hans-J=FCrgen Koch wrote:
>>> Am Sonntag 08 April 2007 15:51 schrieb Hans de Goede:
>>>> The abituguru3 has a register which contains a motherboard ID. The
>>>> current driver uses this ID, to look up info about the motherboard in a
>>>> somewhat lenght table in the driver.
>>> Can you elaborate your design decision a bit? My first idea would be to
>>> have a sysfs file that delivers that motherboard ID and then do the
>>> lookup in user space.
>> As I don't want the abituguru3 driver to create entries in sysfs for
>> sensors which aren't there, and as without the table in the driver I can=
not
>> be sure wether to create an in / temp / fan device for a given sensor
>> address.=20
>=20
> Good point. Anyway, most sensor drivers have no way of knowing which of t=
heir
> inputs are actually used. The LM93 driver I'm currently working on is a=20
> monster that creates about 160 (!) sysfs files. I don't find it easy to
> judge what's worse, having a few unused sysfs files or a large table in
> kernel space.
>=20

Only 160? My abituguru 1/2 driver creates 177 for my motherboard and even m=
ore=20
on some others (it can detect used versus unused inputs). And the abituguru=
3=20
driver can create 230 with known motherboards, and if i wouldn't use the ta=
ble=20
approach it would create 384 entries. Sorry I'm bragging here I couldn't he=
lp=20
myself, and hopefully this also makes it even clearer why I went with the t=
able=20
approach.

Also notice that the table (except for the used entry) could be made so tha=
t it=20
is freed after module initialisation (currently it isn't).

>> Last but not least doing things this way allows me to always give=20
>> a proper reading without userspace needing to "guess" any further
>> nescesarry calculations to get from the reading to an actual measurement.
>=20
> I agree that this is convenient, especially when reading sysfs values e.g.
> from a script (without a library that could do table lookups). This is
> probably a strong argument in favor of your table solution.
>=20

Yes its very convinient, in an ideal world all hwmon drivers would do this =
and=20
libsensors would not be necessary. This is in no way meant to say that othe=
r=20
drivers are written badly, I know the hardware makes it nearly impossible t=
odo=20
this for other drivers.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
