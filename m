From: Tobias Klauser <tklauser@distanz.ch>
Date: Thu, 20 May 2010 08:34:48 +0000
Subject: [lm-sensors] [PATCH 04/11] hwmon: Storage class should be before
Message-Id: <1274344488-8918-1-git-send-email-tklauser@distanz.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/hwmon/emc1403.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 28cca34..0e4b564 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -308,7 +308,7 @@ static const unsigned short emc1403_address_list[] = {
 	0x18, 0x2a, 0x4c, 0x4d, I2C_CLIENT_END
 };
 
-const static struct i2c_device_id emc1403_idtable[] = {
+static const struct i2c_device_id emc1403_idtable[] = {
 	{ "emc1403", 0 },
 	{ }
 };
-- 
1.6.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
