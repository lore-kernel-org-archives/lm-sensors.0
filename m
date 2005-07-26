From: hvw59601@yahoo.com (Hugo Vanwoerkom)
Date: Tue, 26 Jul 2005 23:43:31 +0000
Subject: [lm-sensors] Support for Winbond W83687THF in Lm_sensors-2.9.1
Message-Id: <20050726214252.85202.qmail@web31008.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

A little while ago Jean Delvare helped me to set up
support for this in 2.6.x.

I am now trying to get it to work in 2.4.31. But the
w83627hf modules in 2.6.x and 2.9.1 are very
different.

I attach a patch I attempted. The module loads but no
sensors found.

Could someone with more knowledge than I take a look
at this please?

Thanks!

Hugo

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627hf.diff
Type: text/x-patch
Size: 3222 bytes
Desc: 128220096-w83627hf.diff
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050726/a751c9f7/w83627hf.bin
