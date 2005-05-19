From: jerry.mcmahan@saic.com (J. A. McMahan Jr.)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: eeprog ASCII readback fix
Message-Id: <008201c4f2ac$a5b66fb0$b601a8c0@Jerry>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fixes a minor bug in the eeprog program that causes it to skip
the first byte when printing out data read from the EEPROM in ASCII mode
(that is, without the hex switch, -x, enabled).

J. A. McMahan Jr.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: eeprog_fix.patch
Type: application/octet-stream
Size: 434 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050104/c72d3c32/eeprog_fix.obj
