From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 18 Jun 2007 12:37:49 +0000
Subject: [lm-sensors] question about dyn chip support generic temp print
Message-Id: <46767C9D.8040006@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

As said already I'm working on the fintek 71882 driver, I've currently give=
n it=20
a tempX_input tempX_max tempX_max_hyst and a tempX_crit, with the current d=
yn=20
chip + generic print support this results in:
CPU:            +38.0=B0C  (high =3D +80.0=B0C, hyst =3D  +4.0=B0C)  sensor=
 =3D transistor
temp1_crit:     +81.0=B0C

This is because currently for max + hyst chips the first line gets printed,=
 and=20
then for chips which have a crit to a sensors_get_label_and_valid is done o=
n=20
the sensors_feature_data describing tempX_crit. Wouldn't it be better to re=
use=20
the main temp label and value, resulting in:
CPU:            +38.0=B0C  (high =3D +80.0=B0C, hyst =3D  +4.0=B0C)  sensor=
 =3D transistor
CPU:            +38.0=B0C  (crit =3D +81.0=B0C)

Maybe change the label into all whitespace / "CPU (continued)"? The current=
=20
printout seems very wrong, but my suggested one doesn't feel right either.

Also as already "explained" in my previous question, this chip has one=20
hysteresis for both max and crit, now to make the current code work I would=
=20
need to put that twice into sysfs, which would result in to both changing i=
f=20
one gets written (I can make only one rw to make this obvious).

Or we need to add a tempX_hyst type, and update the generic temp print code=
 to=20
handle this scenario too.


Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
