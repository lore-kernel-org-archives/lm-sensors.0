From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 10:01:39 +0000
Subject: Re: [lm-sensors] Help wanted: individual alarm files
Message-Id: <20071007120139.7dccbb1c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701220005.1dda9d8f@hyperion.delvare>
In-Reply-To: <20070701220005.1dda9d8f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 1 Jul 2007 22:00:05 +0200, Jean Delvare wrote:
> The future libsensors assumes that all hardware monitoring drivers
> follow the standard sysfs interface defined in
> Documentation/hwmon/sysfs-interface. They all mostly do already, except
> for one thing: alarms. Most drivers are still only exposing a single
> file with all alarms in a bit-vector, in chip-dependent order. In order
> to let the new libsenors display the alarms properly, we must add
> individual alarm files to these drivers. For some drivers, fault and/or
> beep files need to be added too.
>=20
> Here's the current status, to the best of my knowledge.

Updated list:

Recently converted:
adm1021.c (Krzysztof Helt)
lm78.c (Jean Delvare)
lm85.c (Jean Delvare)
lm87.c (Jean Delvare)
thmc50.c (Krzysztof Helt)
w83791d.c (Charles Spirakis)
w83792d.c (Gong Jun)

Superseded by a newer driver:
fscher.c
fscpos.c

Still need to be converted:
adm1025.c
adm1026.c
adm1031.c
adm9240.c
asb100.c
gl518sm.c
gl520sm.c
it87.c
lm77.c
lm80.c
lm92.c
max1619.c
pc87360.c
sis5595.c (Ivo Manco volunteered)
smsc47m1.c
via686a.c
vt8231.c
w83627hf.c (Carlos Olalla Mart=EDnez volunteered)
w83781d.c

The list is shorter, thanks to everyone who helped so far. More help
would of course be appreciated, as we are about to release lm-sensors
3.0.0 and it needs these individual alarm files. I will try to convert
some more drivers this afternoon, next on my list is w83781d.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
