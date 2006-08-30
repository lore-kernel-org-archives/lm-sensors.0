From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 30 Aug 2006 15:01:58 +0000
Subject: [lm-sensors] [proto-patch] hwmon/w83781d  fix unchecked rc's
Message-Id: <44F5A866.4090707@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


heres a *rough* compile-tested patch to fix unchecked-return-code warnings.

I dont have the chip, so I cant test it, so its a bit more cavalier than 
usual ;-)

frankly, I started this patch to unravel some heli-macros
(1st big chunk - not counting the +includes)
but then,
switched gears to address the hot-todo of the week.


I hope someone with the chip will pick it up, and take the useful bits.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: diff.w83781d-unchecked-rc-plus
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060830/96824f0b/attachment.pl 
