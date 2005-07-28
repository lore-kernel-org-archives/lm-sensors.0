From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 28 Jul 2005 23:08:33 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: fix typo in documentation
Message-Id: <20050728230843.702debf7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Fix a typo in the i2c documentation: the i2c bus scanning tool found in
lm_sensors is called i2cdetect, not i2c_detect.

 Documentation/i2c/functionality |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-rc3.orig/Documentation/i2c/functionality	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.13-rc3/Documentation/i2c/functionality	2005-07-28 19:01:25.000000000 +0200
@@ -115,7 +115,7 @@
 If you try to access an adapter from a userspace program, you will have
 to use the /dev interface. You will still have to check whether the
 functionality you need is supported, of course. This is done using
-the I2C_FUNCS ioctl. An example, adapted from the lm_sensors i2c_detect
+the I2C_FUNCS ioctl. An example, adapted from the lm_sensors i2cdetect
 program, is below:
 
   int file;


-- 
Jean Delvare
