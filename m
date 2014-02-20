From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 20 Feb 2014 20:24:23 +0000
Subject: [lm-sensors] [PATCH] sensors.conf.default: Add default voltage settings for nct6791
Message-Id: <20140220212423.0bd23f8f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Guenter, do I get it right that the NCT6791 has the same voltage input
constraints as the NCT6775 and NCT6776?

Are there other Nuvoton chips that should be added to the list?

Index: etc/sensors.conf.default
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- etc/sensors.conf.default	(r=E9vision 6222)
+++ etc/sensors.conf.default	(copie de travail)
@@ -308,7 +308,7 @@
 #    set in8_max  3.0 * 1.10
=20
=20
-chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"
+chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*" "nct=
6791-*"
=20
     label in0 "Vcore"
     label in2 "AVCC"


--=20
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
