From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [PATCH] i2c driver fix for 2.6.0-test11
Message-Id: <20031204222826.GB2541@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031204222752.GA2541@kroah.com>
In-Reply-To: <20031204222752.GA2541@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

ChangeSet 1.1505, 2003/12/04 14:14:33-08:00, khali@linux-fr.org

[PATCH] I2C: fix i2c_smbus_write_byte() for i2c-nforce2

This patch fixes i2c_smbus_write_byte() being broken for i2c-nforce2.
This causes trouble when that module is used together with eeprom (which
is also in 2.6). We have had three user reports about the problem.

Credits go to Mark D. Studebaker for finding and fixing the problem.


 drivers/i2c/busses/i2c-nforce2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Thu Dec  4 14:22:52 2003
+++ b/drivers/i2c/busses/i2c-nforce2.c	Thu Dec  4 14:22:52 2003
@@ -147,7 +147,7 @@
 
 		case I2C_SMBUS_BYTE:
 			if (read_write = I2C_SMBUS_WRITE)
-				outb_p(data->byte, NVIDIA_SMB_DATA);
+				outb_p(command, NVIDIA_SMB_CMD);
 			protocol |= NVIDIA_SMB_PRTCL_BYTE;
 			break;
 
