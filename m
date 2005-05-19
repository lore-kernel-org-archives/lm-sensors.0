From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: ADM1031 / ADM1030 Driver
Message-Id: <1083188185.5337.5.camel@megapc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is a patch that adds support for adm1030 / adm1031 chip on the
linux-2.6.6-rc3 kernel.

Tested with adm1030 chip.

If the code is ok, I'll add documentation (how to use and inline
comments) in order to submit the final version.

Jean: Concerning via686a chip driver, temps seems to be OK on my
computer.

Alex.

Patch attached because my client wraps lines.




-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-adm1031-2.6.6-rc3.diff
Type: text/x-patch
Size: 34129 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040428/324f3f3a/patch-adm1031-2.6.6-rc3.bin
