From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Nov 2007 14:26:58 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 patch for (gnome) sensors-applet
Message-Id: <20071118152658.466e4dc8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4738C247.4030501@hhs.nl>
In-Reply-To: <4738C247.4030501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 15 Nov 2007 10:52:01 +0100, Hans de Goede wrote:
> Hans de Goede wrote:
> > While coordinating my work with the Fedora net-snmp maintainer I got=20
> > attended that upstream us already working on this:
> > http://sourceforge.net/mailarchive/message.php?msg_name=AE77C0A0A0DC9B4=
9BAA800A119E82EA207CD5D83%40EDM-GOA-EXCC-1A.goa.ds.gov.ab.ca=20
> >=20
> >=20
> > However the upstream work is a complete rewrite of the sensors code in =

> > net-snmp, as I have no idea when that will be stable and I don't want t=
o=20
> > completely break the development branch of Fedora (quite a few things=20
> > require net-snmp) I'll also be writing a patch against the current=20
> > stable net-snmp release, I already took a look and the code is quite=20
> > isolated, fixing this for the current stable net-snmp release should be=
=20
> > quite easy.
>=20
> Scrap that, upstream has finished lm_sensors-3.x support and the Fedora=20
> net-snmp maintainer has decided to backport the sensors infra changes +=20
> lm_sensors-3.x.x support to the current stable net-snmp, patch available =
here:
> http://cvs.fedoraproject.org/viewcvs/devel/net-snmp/net-snmp-5.4.1-sensor=
s3.patch?rev=3D1.1

This is excellent news. One less project for us to take care of :)

> Shall I add this to the wiki? Its a bit intrusive.

You can always add a link to the patch for interested people. Then
every distribution will decide whether to apply it or not.

A less intrusive patch for net-snmp stable would also be nice to have,
but only if someone actually has the time to work on that (I don't.)

Thanks and congrats to the net-snmp and Fedora folks involved!

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
