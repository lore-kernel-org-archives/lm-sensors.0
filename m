From: Tobias Klauser <tklauser@distanz.ch>
Date: Sun, 17 Feb 2008 14:39:24 +0000
Subject: [lm-sensors] [PATCH] hwmon: Storage class should be before const
Message-Id: <20080217143924.GA9350@distanz.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the
beginning of the declaration specifiers in a declaration is an
obsolescent feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/hwmon/thmc50.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index 04dd769..a42a03c 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -52,9 +52,9 @@ I2C_CLIENT_MODULE_PARM(adm1022_temp3, "List of adapter,address pairs "
  */
 #define THMC50_REG_INTR				0x41
 
-const static u8 THMC50_REG_TEMP[] = { 0x27, 0x26, 0x20 };
-const static u8 THMC50_REG_TEMP_MIN[] = { 0x3A, 0x38, 0x2C };
-const static u8 THMC50_REG_TEMP_MAX[] = { 0x39, 0x37, 0x2B };
+static const u8 THMC50_REG_TEMP[] = { 0x27, 0x26, 0x20 };
+static const u8 THMC50_REG_TEMP_MIN[] = { 0x3A, 0x38, 0x2C };
+static const u8 THMC50_REG_TEMP_MAX[] = { 0x39, 0x37, 0x2B };
 
 #define THMC50_REG_CONF_nFANOFF			0x20
 
-- 
1.5.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
