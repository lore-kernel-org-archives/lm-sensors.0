From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 03 Jan 2008 13:05:42 +0000
Subject: [lm-sensors] [GIT PATCH] hwmon update against v2.6.24-rc6
Message-Id: <20080103130542.GB1389@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Linus:

Please pull from:
	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git release

You'll get one patch (attached) which fixes a bug in w83627ehf.
http://bugzilla.kernel.org/show_bug.cgi?id=9634

Thanks & regards,

commit 58e6e78119da2bdade9f6f588155f0320072b76b
Author: Jean Delvare <khali@linux-fr.org>
Date:   Thu Jan 3 07:33:31 2008 -0500

    hwmon: (w83627ehf) Be more careful when changing VID input level
   =20
    The VID input level change has been reported to cause trouble. Be more
    careful in this respect:
    * Only change the level on the W83627EHF/EHG. The W83627DHG is more
      complex in this respect.
    * Don't change the level if the VID pins are in output mode.
    * Only set the level to TTL if VRM 9.x is used.
   =20
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index b15c6a9..d5aa25c 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1276,23 +1276,31 @@ static int __devinit w83627ehf_probe(struct platfor=
m_device *pdev)
=20
 	data->vrm =3D vid_which_vrm();
 	superio_enter(sio_data->sioreg);
-	/* Set VID input sensibility if needed. In theory the BIOS should
-	   have set it, but in practice it's not always the case. */
-	en_vrm10 =3D superio_inb(sio_data->sioreg, SIO_REG_EN_VRM10);
-	if ((en_vrm10 & 0x08) && data->vrm !=3D 100) {
-		dev_warn(dev, "Setting VID input voltage to TTL\n");
-		superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
-			     en_vrm10 & ~0x08);
-	} else if (!(en_vrm10 & 0x08) && data->vrm =3D 100) {
-		dev_warn(dev, "Setting VID input voltage to VRM10\n");
-		superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
-			     en_vrm10 | 0x08);
-	}
 	/* Read VID value */
 	superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
-	if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80)
+	if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
+		/* Set VID input sensibility if needed. In theory the BIOS
+		   should have set it, but in practice it's not always the
+		   case. We only do it for the W83627EHF/EHG because the
+		   W83627DHG is more complex in this respect. */
+		if (sio_data->kind =3D w83627ehf) {
+			en_vrm10 =3D superio_inb(sio_data->sioreg,
+					       SIO_REG_EN_VRM10);
+			if ((en_vrm10 & 0x08) && data->vrm =3D 90) {
+				dev_warn(dev, "Setting VID input voltage to "
+					 "TTL\n");
+				superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
+					     en_vrm10 & ~0x08);
+			} else if (!(en_vrm10 & 0x08) && data->vrm =3D 100) {
+				dev_warn(dev, "Setting VID input voltage to "
+					 "VRM10\n");
+				superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
+					     en_vrm10 | 0x08);
+			}
+		}
+
 		data->vid =3D superio_inb(sio_data->sioreg, SIO_REG_VID_DATA) & 0x3f;
-	else {
+	} else {
 		dev_info(dev, "VID pins in output mode, CPU VID not "
 			 "available\n");
 		data->vid =3D 0x3f;

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
