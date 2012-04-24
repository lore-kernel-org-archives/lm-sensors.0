From: Nikola Pajkovsky <npajkovs@redhat.com>
Date: Tue, 24 Apr 2012 10:24:54 +0000
Subject: [lm-sensors] [PATCH] eepromer/24cXX: fix leaking file descriptor
Message-Id: <d53426eaec2f3212842b5a44a0fbc2d1c97f44e3.1335263046.git.npajkovs@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Nikola Pajkovsky <npajkovs@redhat.com>
---
 eepromer/24cXX.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/eepromer/24cXX.c b/eepromer/24cXX.c
index 00a21fd..ab86c33 100644
--- a/eepromer/24cXX.c
+++ b/eepromer/24cXX.c
@@ -79,9 +79,10 @@ int eeprom_open(char *dev_fqn, int addr, int type, struct eeprom* e)
 		return -1;
 
 	// get funcs list
-	if((r = ioctl(fd, I2C_FUNCS, &funcs) < 0))
+	if((r = ioctl(fd, I2C_FUNCS, &funcs) < 0)) {
+		close(fd);
 		return r;
-
+	}
 	
 	// check for req funcs
 	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_BYTE );
-- 
1.7.9.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
