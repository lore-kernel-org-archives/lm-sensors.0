From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 14 Nov 2007 10:18:30 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 patch for (gnome) sensors-applet
Message-Id: <473ACB76.1080804@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4738C247.4030501@hhs.nl>
In-Reply-To: <4738C247.4030501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
>=20
> On Tue, 13 Nov 2007 22:08:48 +0100, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> So, are you done with your porting work? If so, and if you didn't find
>>> any problem with the new libsensors API, is there any reason to delay
>>> the release of lm-sensors 3.0.0 any further?
>> I'm not done with my porting work, next on the list is net-snmp, which l=
ooks=20
>> easy to fix, I'll take a shot at it tomorrow. Then we also have an xfce =
applet=20
>=20
> I am interested in net-snmp as well, so maybe we can work on this
> together. Well, you'll certainly be quicker than me on the code, but I
> can review your patch and push it in opensuse.
>=20

Hmm,

While coordinating my work with the Fedora net-snmp maintainer I got attend=
ed=20
that upstream us already working on this:
http://sourceforge.net/mailarchive/message.php?msg_name=AE77C0A0A0DC9B49BAA=
800A119E82EA207CD5D83%40EDM-GOA-EXCC-1A.goa.ds.gov.ab.ca

However the upstream work is a complete rewrite of the sensors code in=20
net-snmp, as I have no idea when that will be stable and I don't want to=20
completely break the development branch of Fedora (quite a few things requi=
re=20
net-snmp) I'll also be writing a patch against the current stable net-snmp =

release, I already took a look and the code is quite isolated, fixing this =
for=20
the current stable net-snmp release should be quite easy.

>> and kdelibs (although that might only depend on lm_sensors through net-s=
nmp).
>=20
> On my end (opensuse), I have kdegraphics and kdeutils which depend on
> net-snmp. Only kdebase depends on libsensors directly (for ksysguard.)
>=20

My bad I meant kdebase.


> P.S.: Please remember to add a short comment to your wiki edits so that
> others see what's happening.
>=20

Will do in the future.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
