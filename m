From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Date: Wed, 04 Jun 2008 22:57:53 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <48471DF1.70505@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost>	<4846EBF5.2030406@tremplin-utc.net> <20080604225830.1dff64fc@hyperion.delvare>
In-Reply-To: <20080604225830.1dff64fc@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, pavel@ucw.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

04-06-08 22:58, Jean Delvare wrote/a =E9crit:
> Hi Eric,
>=20
> On Wed, 04 Jun 2008 21:24:37 +0200, =C9ric Piel wrote:
>> We haven't received any review for this driver since last week's post by
>> Yan :-( That's why I'm adding explicitly as receivers of this email all
>> the people who have reviewed the first two previous takes. Apologies for
>> the possible multiple receptions.
>>
>> It would be _really really kind_ if some of you could take some time and
>> comment (or simply ACK ;-) ) this code. It adds support for hardware
>> which can be found in mostly every HP Compaq laptop less than three
>> years old. It's quite worthy.
>>
>> Mark, as maintainer of the hwmon tree, would accept this driver? Let us
>> know if there are things we need to change.
>=20
> If you didn't receive any answer, my guess is that it's because you're
> trying to add this driver to the wrong tree. Why would this driver go
> in drivers/hwmon and be reviewed by hwmon folks, when it doesn't expose
> a single hwmon attribute to user-space?
>=20
> I guess you thought putting the driver there would be fine because
> that's where the hdaps and ams drivers are, but IMHO the hdaps and ams
> drivers should never have been placed in drivers/hwmon. These devices
> really aren't hardware monitoring chips is the traditional sense of the
> term. They are different chips, serving different purposes and
> deserving a totally different interface. They'd better live in a
> different subsystem and be maintainer by a different crew with interest
> in these devices and hardware to test the drivers.
>=20
> This discussion thread might sched some light on a possible approach:
> http://marc.info/?l=3Dlm-sensors&m=121127824726050&w=3D2
>=20
> So my advice is that you don't wait for a review from the hwmon people,
> because apparently we don't have much interest in this type of device,
> so you'll be waiting forever. You're much better adding the mdps driver
> to drivers/misc through Andrew Morton, at least until someone takes
> care of creating a subsystem for this type of devices and move all
> existing drivers there.
Hi Jean,
I understand your argumentation. Indeed, this driver has nothing
specially related to hwmon, excepted that all the other accelerometers
so far have been put in hwmon. I've got nothing against redoing the
patch to move the code to drivers/misc. Andrew, would you accept it?

> Would someone object to moving the hdaps and ams (and possibly
> applesmc) drivers to drivers/misc?
Yeah, applesmc seems a bit less obvious because it also exposes really
some hardware sensors. Any idea how to handle this? Just leave it in
hwmon for now?

So, the rational about moving all these drivers to drivers/misc/ would
be that it shows they have no relation with hwmon, and they are
maintained separately. This would be a temporary place until the
"accelerometer" subsystem exists by it own, right?
If everyone is happy with this idea, I can submit a separate patch to
move them.

See you,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
