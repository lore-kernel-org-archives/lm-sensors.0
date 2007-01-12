From: r.marek@assembler.cz (Rudolf Marek)
Date: Fri, 12 Jan 2007 12:30:27 +0000
Subject: [lm-sensors] [PATCH] W83793: ignore the temperature readings when
Message-Id: <45A77F63.5080808@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

w83793: ignore the temperature readings when its channel is disabled.

Signed-off-by: Gong Jun <jgong at winbond.com>
Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

Looks OK to me, Jean. I just fixed the the indentation, strip version to p1, and
renamed the temp_enable to has_temp, to be coherent with what he have until now.
Please apply.

Thanks,
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-patch-w83793-temp-display.patch
Type: text/x-diff
Size: 2361 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070112/fc3294ae/attachment.bin 
