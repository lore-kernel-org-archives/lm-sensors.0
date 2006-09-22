From: r.marek@assembler.cz (Rudolf Marek)
Date: Fri, 22 Sep 2006 22:36:06 +0000
Subject: [lm-sensors] [PATCH] w83792d - fix unchecked return codes from
Message-Id: <45146556.5020004@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Following patch fixes the w83792d driver. It adds error checking to 
device_create file and also cares to destroy the files upon exit.

I will test it as soon I will get the disk back to my test machine with this 
chip. Possible dates are: Saturday evening, Sunday and Monday for sure ;)
Until now, compiles without warnings.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83792d.patch
Type: text/x-patch
Size: 28882 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060923/6c3c4039/attachment-0001.bin 
