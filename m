From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <10898500322333@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10898500313698@kroah.com>
References: <10898500251206@kroah.com>
In-Reply-To: <10898500251206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1784.13.11, 2004/07/09 15:08:41-07:00, alex@alexdalton.org

[PATCH] I2C: small ADM1030 fix

Please find an incremental patch that applies on top of the previous one
(the one from the first message of the thread) and that adds parenthesis
to the macro as pointed out by Mark.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1031.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c	2004-07-14 16:59:22 -07:00
+++ b/drivers/i2c/chips/adm1031.c	2004-07-14 16:59:22 -07:00
@@ -162,8 +162,8 @@
 	(AUTO_TEMP_MIN_FROM_REG(reg) - 5000)
 
 #define AUTO_TEMP_MAX_FROM_REG(reg)		\
-	AUTO_TEMP_RANGE_FROM_REG(reg) +		\
-	AUTO_TEMP_MIN_FROM_REG(reg)
+	(AUTO_TEMP_RANGE_FROM_REG(reg) +	\
+	AUTO_TEMP_MIN_FROM_REG(reg))
 
 static int AUTO_TEMP_MAX_TO_REG(int val, int reg, int pwm)
 {

