From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 26 Jul 2007 12:30:11 +0000
Subject: Re: [lm-sensors] Someone could send me a sensors.conf for Fintek
Message-Id: <46A893D3.9000506@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A85915.5060802@wanadoo.fr>
In-Reply-To: <46A85915.5060802@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

S=E9bastien CRAMATTE wrote:
> Hello
>=20
> Someone could send me a sensors.conf for Fintek f71882fg chipset ?
> I've got a MSI P35 Platinum and I'm currently compiling a 2.6.20 kernel
> with  hwmon-f71882fg-new-driver-v2.patch under Ubuntu feisty
>=20
> Wich version of lm-sensors is required ? I've builded the *lm_sensors-2.1=
0.3
>=20

You need atleast lm_sensors-2.10.4 (recently released). Then an example con=
fig=20
will be included in sensors.conf.

We also have a config tuned for the MSI P965-Platinum here:
http://www.lm-sensors.org/wiki/Configurations/MSI/P965-Platinum

One you have things working, please post the output of sensors and the read=
ings=20
of the sensors as seen in your BIOS, then we can help you tweak sensors.con=
f=20
for your motherboard and when it works 100% include it in the wiki for othe=
rs.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
