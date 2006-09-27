From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:48 +0000
Subject: [lm-sensors] [PATCH 17/30] i2c-stub: Chip address as a module
Message-Id: <11593189802663-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-stub: Chip address as a module parameter

Add a mandatory chip_addr parameter to i2c-stub. This parameter
defines to which chip address the driver will respond, instead of
reponding to all addresses as before. The idea is to prevent the
users from loading i2c-stub at random and being then confused by
the results of sensors-detect or other user-space tools.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/i2c/i2c-stub    |   15 +++++++++++++--
 drivers/i2c/busses/i2c-stub.c |   19 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/i2c-stub b/Documentation/i2c/i2c-stub
index d6dcb13..9cc081e 100644
--- a/Documentation/i2c/i2c-stub
+++ b/Documentation/i2c/i2c-stub
@@ -6,9 +6,12 @@ This module is a very simple fake I2C/SM
 types of SMBus commands: write quick, (r/w) byte, (r/w) byte data, and
 (r/w) word data.
 
+You need to provide a chip address as a module parameter when loading
+this driver, which will then only react to SMBus commands to this address.
+
 No hardware is needed nor associated with this module.  It will accept write
-quick commands to all addresses; it will respond to the other commands (also
-to all addresses) by reading from or writing to an array in memory.  It will
+quick commands to one address; it will respond to the other commands (also
+to one address) by reading from or writing to an array in memory.  It will
 also spam the kernel logs for every command it handles.
 
 A pointer register with auto-increment is implemented for all byte
@@ -21,6 +24,11 @@ The typical use-case is like this:
 	3. load the target sensors chip driver module
 	4. observe its behavior in the kernel log
 
+PARAMETERS:
+
+int chip_addr:
+	The SMBus address to emulate a chip at.
+
 CAVEATS:
 
 There are independent arrays for byte/data and word/data commands.  Depending
@@ -33,6 +41,9 @@ If the hardware for your driver has bank
 chips) this module will not work well - although it could be extended to
 support that pretty easily.
 
+Only one chip address is supported - although this module could be
+extended to support more.
+
 If you spam it hard enough, printk can be lossy.  This module really wants
 something like relayfs.
 
diff --git a/drivers/i2c/busses/i2c-stub.c b/drivers/i2c/busses/i2c-stub.c
index 73f481e..8cf374d 100644
--- a/drivers/i2c/busses/i2c-stub.c
+++ b/drivers/i2c/busses/i2c-stub.c
@@ -27,6 +27,10 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 
+static unsigned short chip_addr;
+module_param(chip_addr, ushort, S_IRUGO);
+MODULE_PARM_DESC(chip_addr, "Chip address (between 0x03 and 0x77)\n");
+
 static u8  stub_pointer;
 static u8  stub_bytes[256];
 static u16 stub_words[256];
@@ -37,6 +41,9 @@ static s32 stub_xfer(struct i2c_adapter 
 {
 	s32 ret;
 
+	if (addr != chip_addr)
+		return -ENODEV;
+
 	switch (size) {
 
 	case I2C_SMBUS_QUICK:
@@ -122,7 +129,17 @@ static struct i2c_adapter stub_adapter  
 static int __init i2c_stub_init(void)
 {
-	printk(KERN_INFO "i2c-stub loaded\n");
+	if (!chip_addr) {
+		printk(KERN_ERR "i2c-stub: Please specify a chip address\n");
+		return -ENODEV;
+	}
+	if (chip_addr < 0x03 || chip_addr > 0x77) {
+		printk(KERN_ERR "i2c-stub: Invalid chip address 0x%02x\n",
+		       chip_addr);
+		return -EINVAL;
+	}
+
+	printk(KERN_INFO "i2c-stub: Virtual chip at 0x%02x\n", chip_addr);
 	return i2c_add_adapter(&stub_adapter);
 }
 
-- 
1.4.2.1


