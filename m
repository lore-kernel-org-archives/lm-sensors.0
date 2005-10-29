From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:02:53 +0000
Subject: [lm-sensors] [PATCH] i2c: Minor i2c-amd8111 cleanup
Message-Id: <1130533658412@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Minor i2c-amd8111 cleanup

I noticed a useless instruction in the i2c-amd8111 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
CC: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/i2c/busses/i2c-amd8111.c |    1 -
 1 file changed, 1 deletion(-)

---
commit 0f69a612f950f7508e556bf1b09390087d112115
tree f27080ba61dd0f51e328c25add031c61204f1c7f
parent 332bf92b3338e140cbcfc25f69911e8ca59788c7
author Jean Delvare <khali@linux-fr.org> Sun, 25 Sep 2005 16:58:22 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:07 -0700

 drivers/i2c/busses/i2c-amd8111.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index 49ff11e..6200c9a 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -244,7 +244,6 @@ static s32 amd8111_access(struct i2c_ada
 			break;
 
 		case I2C_SMBUS_BLOCK_PROC_CALL:
-			protocol |= pec;
 			len = min_t(u8, data->block[0], 31);
 			amd_ec_write(smbus, AMD_SMB_CMD, command);
 			amd_ec_write(smbus, AMD_SMB_BCNT, len);

