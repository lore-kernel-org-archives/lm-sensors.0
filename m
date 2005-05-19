From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: Possible bug in i2c-nforce2
Message-Id: <20031128214830.35fbee8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031126205657.3f965e47.khali@linux-fr.org>
In-Reply-To: <20031126205657.3f965e47.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Hans-Frieder,

> Recent failure reports with the i2c-nforce2+eeprom combination led me
> to the conclusion that your i2c-norce2 module might not support
> i2c_smbus_write_byte() correctly. It is used in the eeprom driver and
> doesn't seem to set the address register as it should.

Mark D. Studebaker probably found and fixed that bug. The following change
was made to your driver:

Index: i2c-nforce2.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-nforce2.c,v
retrieving revision 1.6
retrieving revision 1.7
diff -u -r1.6 -r1.7
--- i2c-nforce2.c	3 Aug 2003 05:32:01 -0000	1.6
+++ i2c-nforce2.c	27 Nov 2003 02:37:43 -0000	1.7
@@ -143,7 +143,7 @@
 
 		case I2C_SMBUS_BYTE:
 			if (read_write = I2C_SMBUS_WRITE)
-				outb_p(data->byte, NVIDIA_SMB_DATA);
+				outb_p(command, NVIDIA_SMB_CMD);
 			protocol |= NVIDIA_SMB_PRTCL_BYTE;
 			break;
 

Comments on this change are welcome. If you confirm it's OK, I'll send a
patch to Greg KH to update the driver present in Linux 2.6.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
