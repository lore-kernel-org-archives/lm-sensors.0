From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Fri, 06 Jul 2007 09:01:39 +0000
Subject: [lm-sensors] Odp:  Sensors working on DL360?
Message-Id: <468e04f3cde05@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dnia 6-07-2007 o godz. 9:38 Bart van Kuik napisa=B3(a):
> Hi list,
>=20
> I'm trying to get sensor readouts on a Compaq DL360 (not the
later HP
> branded ones, but the series with a Pentium 3).

My bet it uses thmc50 driver which is just being ported to 2.6.
You can download my latest patch and try.

It does not work with lmsensors 2.x, you need to download the
latest lmsensors 3 branch.

It is I2C sensor. The I2C sensors were not scanned by your
detection script for unknown reason.

Regards,
Krzysztof


----------------------------------------------------
Zobacz, co m=F3wi=B1 wakacyjne przepowiednie tarota.
Czy b=EAd=B1 to wakacje Twoich marze=F1?
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd116.html&si=
d=1215



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
