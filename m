From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 20 Mar 2007 22:55:12 +0000
Subject: [lm-sensors] [PATCH] coretemp 2/3 Add the coretemp driver
Message-Id: <46006650.8000603@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

This is just the fixed version of the driver (the small typo Nicolas pointed 
out). Please can you test/apply to your stack once we know it is OK and once the 
1/3 patch is applied?

Thanks,

This patch adds the support for the digital temperature sensor found in recent 
Intel Core CPUs.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: add-coretemp-driver.patch
Type: text/x-patch
Size: 12657 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070320/13d3ad68/attachment.bin 
