From: r.marek@assembler.cz (Rudolf Marek)
Date: Fri, 22 Sep 2006 22:26:32 +0000
Subject: [lm-sensors] [PATCH] w83l785ts - fix unchecked return codes from
Message-Id: <45146318.3030408@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Following patch fixes the w83l785ts driver. It adds error checking to 
device_create file and also cares to destroy the files upon exit. Compile tested.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83l785ts.patch
Type: text/x-patch
Size: 1563 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060923/b2a70001/attachment.bin 
