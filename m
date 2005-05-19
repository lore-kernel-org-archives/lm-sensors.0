From: hfvogt@arcor.de (Hans-Frieder Vogt)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: [PATCH] i2c-amd8111 bug fix (compare i2c-nforce2 bug fix)
Message-Id: <200311302339.11863.hfvogt@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

a similar bug for the send/receive byte SMBus transfer as in the i2c-nforce2 
bus driver is also present in the i2c-amd8111 driver. The attached small 
patch corrects it. I have no board with AMD-8111 and therefore cannot test 
it, but the patch brings the AMD-8111 bus driver in line with the ACPI 2.0 
spec chapter 13.9, to which is is compliant according to the AMD-8111 data 
sheet (AMD document #24674). Can anybody with an AMD-8000 chip set based 
mainboard confirm the fix?

Hans-Frieder

--- lm_sensors2.orig/kernel/busses/i2c-amd8111.c        2003-08-03 
18:09:00.000000000 +0200
+++ lm_sensors2/kernel/busses/i2c-amd8111.c     2003-11-30 15:45:42.000000000 
+0100
@@ -198,7 +198,7 @@
 
		case I2C_SMBUS_BYTE:
 			if (read_write = I2C_SMBUS_WRITE)
-				amd_ec_write(smbus, AMD_SMB_DATA, data->byte);
+				amd_ec_write(smbus, AMD_SMB_CMD, command);
 			protocol |= AMD_SMB_PRTCL_BYTE;
 		break;


-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt@arcor.de
