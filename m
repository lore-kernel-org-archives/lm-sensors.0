From: kernel@kolivas.org (Con Kolivas)
Date: Fri, 15 Dec 2006 02:33:15 +0000
Subject: [lm-sensors] W83627DHG support patch
Message-Id: <200612151333.15725.kernel@kolivas.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all

Browsing the past archives I saw that the W83627DHG chip was a lot like the 
w83627ehf driver and support shouldn't be too hard to add. So I probed my own 
hardware to see what it returned and added a small patch to try to make it 
work. The output of  sensors after that seems accurate apart from AUX Temp 
which seems to jump around a bit. The cpu and system temperature, fan speeds 
and voltages that I have all seem pretty close too.

Here is a patch that I created for the 2.6.19 kernel that gave me the output I 
required. I doubt very much that this is the correct and final approach so it
may blow up your machine etc etc so for those who are desparate and want to
try it all the usual warnings apply and so on... :D

---
Hack for W83627DHG support from W83627EHF hwmon driver.

Signed-off-by: Con Kolivas <kernel at kolivas.org>

---
 drivers/hwmon/w83627ehf.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6.19-ck2/drivers/hwmon/w83627ehf.c
=================================--- linux-2.6.19-ck2.orig/drivers/hwmon/w83627ehf.c	2006-12-15 13:07:54.000000000 +1100
+++ linux-2.6.19-ck2/drivers/hwmon/w83627ehf.c	2006-12-15 13:18:23.000000000 +1100
@@ -66,6 +66,7 @@ static int VAL;		/* The value to read/wr
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
 
 #define SIO_W83627EHF_ID	0x8840
+#define SIO_W83627DHG_ID	0xA000
 #define SIO_ID_MASK		0xFFC0
 
 static inline void
@@ -1340,9 +1341,10 @@ static int __init w83627ehf_find(int sio
 
 	val = (superio_inb(SIO_REG_DEVID) << 8)
 	    | superio_inb(SIO_REG_DEVID + 1);
-	if ((val & SIO_ID_MASK) != SIO_W83627EHF_ID) {
-		superio_exit();
-		return -ENODEV;
+	if (((val & SIO_ID_MASK) != SIO_W83627EHF_ID) &&
+		((val & SIO_ID_MASK) != SIO_W83627DHG_ID)) {
+			superio_exit();
+			return -ENODEV;
 	}
 
 	superio_select(W83627EHF_LD_HWM);


-- 
-ck

