From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 05 Jul 2011 19:56:46 +0000
Subject: [lm-sensors] [PATCH] hwmon: (asus_atk0110) fix memory leak
Message-Id: <20110705195646.GA21684@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The object returned by atk_gitm is dynamically allocated and must be
freed.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>

---
 drivers/hwmon/asus_atk0110.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index dcb78a7..00e9851 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -674,6 +674,7 @@ static int atk_debugfs_gitm_get(void *p, u64 *val)
 	else
 		err = -EIO;
 
+	ACPI_FREE(ret);
 	return err;
 }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
