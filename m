From: harald.dunkel@t-online.de (Harald Dunkel)
Date: Sun, 28 May 2006 17:24:40 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <4479DCD8.2000408@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <446DF157.80805@t-online.de>
In-Reply-To: <446DF157.80805@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Attached is a new version of the f75387 driver. The fan speed is
correct now, except that the missing fan is not detected. fan1_input
is 550, not 0.

All values are still read-only.

What is the procedure to get support for a new chip into the
lm-sensors package?


Regards

Harri

-------------- next part --------------
A non-text attachment was scrubbed...
Name: f75387.c
Type: text/x-csrc
Size: 18315 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060528/dca48a78/f75387.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060528/dca48a78/signature.bin
