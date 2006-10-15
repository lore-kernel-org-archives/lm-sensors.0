From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 15 Oct 2006 20:32:07 +0000
Subject: [lm-sensors] [PATCH 2/3] coretemp driver
Message-Id: <45329AC7.3040008@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Here comes the updated coretemp driver, minor fixes, added the special sysfs
file temp1_label to with content of "Core X" to handle the dynamic labels -
which would be nice to have in future.

Please test the driver, as I still do not have access to any Core based system
(hopefully soon I will).

Thanks,
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: add-coretemp-driver.patch
Type: text/x-patch
Size: 11830 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061015/46dc8727/attachment-0001.bin 
