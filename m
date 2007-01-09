From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 09 Jan 2007 07:28:36 +0000
Subject: [lm-sensors] [PATCH] w83793 update
Message-Id: <45A34424.80700@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Following patch fixes the driver to match the information in datasheet 1.0. AMD 
SI interface is marked as reserved, computing formula for 5VDD and 5VSB is updated.

Signed-off-by: Gong Jun <JGong at winbond.com>
Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

Jean, please apply.

Thanks,
Rudolf

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-patch-w83793-datasheet-refresh.patch
Type: text/x-patch
Size: 2584 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070109/1b99ab33/attachment.bin 
