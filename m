From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 14 Jan 2007 18:07:01 +0000
Subject: [lm-sensors] [PATCH] W83793: fix the fan input detection
Message-Id: <45AA7145.1000908@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Our driver does not check for second possible location, where the fan in pin can 
be routed. Personally I think looking just for "enable monitor" would be enough, 
but lets extend the scheme we have already in the driver, so we won't break it.

This patch extends the fan configuration detection, catches the cases when
alternative pins are used to route the fan input.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-w83793-fan-enable.patch
Type: text/x-patch
Size: 920 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070114/c9fb416a/attachment.bin 
