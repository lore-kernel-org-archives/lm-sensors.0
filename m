From: Nicolas.Mailhot@laPoste.net (Nicolas Mailhot)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: Sensors and linux 2.6.0-test4-bk8 question
Message-Id: <1062952680.9123.0.camel@rousalka.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1062934034.7923.2.camel@rousalka.dyndns.org>
In-Reply-To: <1062934034.7923.2.camel@rousalka.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ton Hospel <linux-kernel@ton.iguana.be>
Cc: linux-kernel@vger.kernel.org, lm78@stimpy.netroedge.com

Ton Hospel replied to me
|> I know libsensors is not yet 2.6 aware, but I thought sensed values
|> where available in sysfs if one wanted to manually read them. Since I
|> have via hardware:

|If there is any interest, I have a perl program that does a configurable=20
|display for 2.6.

Sure there is interest:)

|>=20
|> Now there is no sensor-related message as far as I can see in my dmesg,
|> and I do not seem to find any temperature/fan related info in /sys:
|>=20

|You still need the bus and chip drivers before anything appears.
|Which ones is basically the same as with the old lmsensors stuff, so
|look in their docs.

But how can I check the damn things work ? Sensors writers seem to=20
have eschewed the nice messages every other driver writer put in dmesg to
tell me their stuff is correctly loaded.

For example I have :
"SMBus Via Pro adapter at 5000"

in "/sys/devices/pci0000:00/0000:00:11.0/i2c-3/name" so I suppose via-pro
at least is loaded (fully ?). Which should be the bus stuff I think. For
the chip stuff that would be VIA686A (?) But how am I supposed to check the=
=20
darn thing works with nothing in dmesg ? I've already combed sysfs for clue=
s=20
and found nothing.

Regards,

--=20
Nicolas Mailhot
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Ceci est une partie de message
	=3D?ISO-8859-1?Q?num=E9riquement?=3D =3D?ISO-8859-1?Q?_sign=E9e?Url : http=
://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030907/7edabeeb/=
attachment.bin
