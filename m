From: r.marek@assembler.cz (Rudolf Marek)
Date: Thu, 18 Jan 2007 00:35:35 +0000
Subject: [lm-sensors] [PATCH] W83793 fix VIDs
Message-Id: <45AEC0D7.2080006@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good night all,

w83793: ignore the VID readings when the motherboard has not designed the 
function.
 

Signed-off-by: Gong Jun <jgong at winbond.com> 

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

Jun, I fixed your patch, indent, regs and removed the "skip hack". Works on 
software emulator. Please check the patch, I should be already 90 minutes sleeping.

Good night,

Rudolf
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hwmon-patch-w83793-vid-display.patch_fixed
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070118/defa4e49/attachment.pl 
