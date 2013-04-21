From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Apr 2013 16:42:22 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (nct6775) Constify strings
Message-Id: <1366562543-29314-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

nct6775_sio_names should be a constant pointer to an array of
constant strings.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 04ccfff..14da90e 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4035,7 +4035,7 @@ static struct platform_driver nct6775_driver = {
 	.remove		= nct6775_remove,
 };
 
-static const char *nct6775_sio_names[] __initconst = {
+static const char * const nct6775_sio_names[] __initconst = {
 	"NCT6775F",
 	"NCT6776D/F",
 	"NCT6779D",
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
