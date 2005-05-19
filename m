From: lt@ncic.ac.cn (Liu Tao)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: [PATCH] <SMBus block read I2C emulation>, <i2c-2.8.1>
Message-Id: <200311271749.52305.lt@ncic.ac.cn>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

Here is the patch to support SMBus Block Read and SMBus Block Process Call
protocols under I2C emulation. It adds the I2C_M_RECV_LEN flag. 

To support the two protocols, an algorithm driver should handle the 
I2C_M_RECV_LEN flag in its master_xfer routin, and return
I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_READ_BLOCK_DATA or
I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_PROC_CALL
in its functionality routin.

Existing algorithm drivers won't be affected by this patch.

-- 
Regards,
Liu Tao
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c_smbus_emul.patch
Type: text/x-diff
Size: 3033 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031127/c17a759e/i2c_smbus_emul.bin
