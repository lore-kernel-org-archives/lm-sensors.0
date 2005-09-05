From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:47 +0000
Subject: [lm-sensors] [PATCH] I2C: max6875 documentation cleanup
Message-Id: <11259567644070@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: max6875 documentation cleanup

Fix a spelling error and change a sysfs name.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0283fe6c3bdbe9ca9aefa28b24883ec1dee3ccbd
tree df4e86f58dc1708606ad09d8aea7a872d7d1a8fe
parent a61fc683ae1b7871d8d81ac5025af1a923731547
author bgardner@wabtec.com <bgardner@wabtec.com> Wed, 27 Jul 2005 12:43:21 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:05 -0700

 Documentation/i2c/chips/max6875 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/chips/max6875 b/Documentation/i2c/chips/max6875
--- a/Documentation/i2c/chips/max6875
+++ b/Documentation/i2c/chips/max6875
@@ -49,14 +49,14 @@ $ modprobe max6875 force=0,0x50
 
 The MAX6874/MAX6875 ignores address bit 0, so this driver attaches to multiple
 addresses.  For example, for address 0x50, it also reserves 0x51.
-The even-address instance is called 'max6875', the odd one is 'max6875-dummy'.
+The even-address instance is called 'max6875', the odd one is 'max6875 subclient'.
 
 
 Programming the chip using i2c-dev
 ----------------------------------
 
 Use the i2c-dev interface to access and program the chips.
-Reads and write are performed differently depending on the address range.
+Reads and writes are performed differently depending on the address range.
 
 The configuration registers are at addresses 0x00 - 0x45.
 Use i2c_smbus_write_byte_data() to write a register and

