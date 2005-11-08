From: Mingkun.Gu@GTECH.COM (Gu, Mingkun)
Date: Tue, 08 Nov 2005 16:26:02 +0000
Subject: [lm-sensors] Does i2c-i801 support SMBus block write -block read
Message-Id: <83B4F97F11FDDF4C98DFE32FF982A96A721AA6@cspmail2.gtk.gtech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

The i2c.h file has defined some constants for SMBus block process calls,
e.g. 

I2C_FUNC_SMBUS_BLOCK_PROC_CALL
I2C_FUNC_SMBUS_BLOCK_PROC_CALL_PEC
I2C_SMBUS_BLOCK_PROC_CALL
I2C_SMBUS_BLOCK_PROC_CALL_PEC

Does the i2c-i801 module in Kernel 2.6 support the block process calls?
If no, is there new patch which supports it?

Thanks
MK


-----------------------------------------
This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention,
distribution or disclosure by others is strictly prohibited. If you are
not the intended recipient (or authorized to receive for the
recipient), please contact the sender by reply email and delete all
copies of this message. Also, email is susceptible to data corruption,
interception, tampering, unauthorized amendment and viruses. We only
send and receive emails on the basis that we are not liable for any
such corruption, interception, tampering, amendment or viruses or any
consequence thereof.

