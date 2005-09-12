From: gregkh@suse.de (Greg KH)
Date: Mon, 12 Sep 2005 22:10:41 +0000
Subject: [lm-sensors] [PATCH] I2C: i2c-nforce2: drop unused define
Message-Id: <11265555192359@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: i2c-nforce2: drop unused define

One more cleanup in i2c-nforce2.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6b7839007098a6b5612d31690e11277d4242e6ae
tree e9221dec00fc57cdc82e513923c39c2beab6ca3a
parent 2251cf1a4b37bd483501614c2d78f5b8286f20d7
author Jean Delvare <khali@linux-fr.org> Tue, 06 Sep 2005 21:23:25 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 09 Sep 2005 14:34:21 -0700

 drivers/i2c/busses/i2c-nforce2.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -98,11 +98,6 @@ struct nforce2_smbus {
 #define NVIDIA_SMB_PRTCL_PEC			0x80
 
 
-/* Other settings */
-#define MAX_TIMEOUT 256
-
-
-
 static s32 nforce2_access(struct i2c_adapter *adap, u16 addr,
 		       unsigned short flags, char read_write,
 		       u8 command, int size, union i2c_smbus_data *data);

