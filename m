From: David Bartley <andareed@gmail.com>
Date: Tue, 01 Dec 2020 09:54:45 +0000
Subject: [PATCH] hwmon: (nct6683) Support NCT6687D.
Message-Id: <20201201095445.36512-1-andareed@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is found on many MSI motherboards.

Signed-off-by: David Bartley <andareed@gmail.com>
---
 Documentation/hwmon/nct6683.rst | 3 ++-
 drivers/hwmon/nct6683.c         | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/nct6683.rst b/Documentation/hwmon/nct6683.rst
index efbf7e9703ec..7ceab770ae4e 100644
--- a/Documentation/hwmon/nct6683.rst
+++ b/Documentation/hwmon/nct6683.rst
@@ -3,7 +3,7 @@ Kernel driver nct6683
 
 Supported chips:
 
-  * Nuvoton NCT6683D
+  * Nuvoton NCT6683D/NCT6687D
 
     Prefix: 'nct6683'
 
@@ -61,4 +61,5 @@ Board		Firmware version
 Intel DH87RL	NCT6683D EC firmware version 1.0 build 04/03/13
 Intel DH87MC	NCT6683D EC firmware version 1.0 build 04/03/13
 Intel DB85FL	NCT6683D EC firmware version 1.0 build 04/03/13
+MSI B550	N/A
 ======== =======================diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index 2d299149f4d2..53e8d0cb3231 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -63,6 +63,7 @@ static const char * const nct6683_chip_names[] = {
 
 #define SIO_NCT6681_ID		0xb270	/* for later */
 #define SIO_NCT6683_ID		0xc730
+#define SIO_NCT6687_ID		0xd590
 #define SIO_ID_MASK		0xFFF0
 
 static inline void
@@ -164,6 +165,7 @@ superio_exit(int ioreg)
 #define NCT6683_REG_CUSTOMER_ID		0x602
 #define NCT6683_CUSTOMER_ID_INTEL	0x805
 #define NCT6683_CUSTOMER_ID_MITAC	0xa0e
+#define NCT6683_CUSTOMER_ID_MSI		0x201
 
 #define NCT6683_REG_BUILD_YEAR		0x604
 #define NCT6683_REG_BUILD_MONTH		0x605
@@ -1218,6 +1220,8 @@ static int nct6683_probe(struct platform_device *pdev)
 		break;
 	case NCT6683_CUSTOMER_ID_MITAC:
 		break;
+	case NCT6683_CUSTOMER_ID_MSI:
+		break;
 	default:
 		if (!force)
 			return -ENODEV;
@@ -1352,6 +1356,9 @@ static int __init nct6683_find(int sioaddr, struct nct6683_sio_data *sio_data)
 	case SIO_NCT6683_ID:
 		sio_data->kind = nct6683;
 		break;
+	case SIO_NCT6687_ID:
+		sio_data->kind = nct6683;
+		break;
 	default:
 		if (val != 0xffff)
 			pr_debug("unsupported chip ID: 0x%04x\n", val);
-- 
2.27.0
