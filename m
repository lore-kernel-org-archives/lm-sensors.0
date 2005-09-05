From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:49:02 +0000
Subject: [lm-sensors] [PATCH] I2C: Kill i2c_algorithm.id (2/7)
Message-Id: <11259567702144@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Kill i2c_algorithm.id (2/7)

Use the adapter id rather than the algorithm id to detect the i2c-isa
pseudo-adapter. This saves one level of dereferencing, and the
algorithm ids will soon be gone anyway.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e51cc6b3a365e170d3ebe51c2308fdd42e027a46
tree fb09b8c3b44047771a395c5430bdba1e42f4ac17
parent 975185880d55676b1352047e82a0cb84173c6c28
author Jean Delvare <khali@linux-fr.org> Thu, 11 Aug 2005 23:36:49 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:28 -0700

 drivers/i2c/busses/i2c-isa.c |    1 +
 include/linux/i2c-isa.h      |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -50,6 +50,7 @@ static struct i2c_algorithm isa_algorith
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
+	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
 	.class          = I2C_CLASS_HWMON,
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
diff --git a/include/linux/i2c-isa.h b/include/linux/i2c-isa.h
--- a/include/linux/i2c-isa.h
+++ b/include/linux/i2c-isa.h
@@ -28,9 +28,9 @@ extern int i2c_isa_del_driver(struct i2c
 
 /* Detect whether we are on the isa bus. This is only useful to hybrid
    (i2c+isa) drivers. */
-#define i2c_is_isa_client(clientptr) \
-        ((clientptr)->adapter->algo->id = I2C_ALGO_ISA)
 #define i2c_is_isa_adapter(adapptr) \
-        ((adapptr)->algo->id = I2C_ALGO_ISA)
+        ((adapptr)->id = (I2C_ALGO_ISA | I2C_HW_ISA))
+#define i2c_is_isa_client(clientptr) \
+        i2c_is_isa_adapter((clientptr)->adapter)
 
 #endif /* _LINUX_I2C_ISA_H */

