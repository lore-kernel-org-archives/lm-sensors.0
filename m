From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:40:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1031) Fix broken links in
Message-Id: <11858460011957-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

The Analog Devices chip information pages moved to a different location.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 Documentation/hwmon/adm1031 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/adm1031 b/Documentation/hwmon/adm1031
index 130a383..be92a77 100644
--- a/Documentation/hwmon/adm1031
+++ b/Documentation/hwmon/adm1031
@@ -6,13 +6,13 @@ Supported chips:
     Prefix: 'adm1030'
     Addresses scanned: I2C 0x2c to 0x2e
     Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADM1030
+               http://www.analog.com/en/prod/0%2C2877%2CADM1030%2C00.html
=20
   * Analog Devices ADM1031
     Prefix: 'adm1031'
     Addresses scanned: I2C 0x2c to 0x2e
     Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADM1031
+               http://www.analog.com/en/prod/0%2C2877%2CADM1031%2C00.html
=20
 Authors:
         Alexandre d'Alton <alex@alexdalton.org>
--=20
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
