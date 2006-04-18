From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Tue, 18 Apr 2006 18:43:14 +0000
Subject: [lm-sensors] Question on my mainboard
Message-Id: <200604182043.14544.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603282150.16130.dieter.jurzitza@t-online.de>
In-Reply-To: <200603282150.16130.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Rudolf,
dear listmembers,
after building the kernel with debugging active, I flood my /var/log/messages 
file (something like 100MByte per day).
What I get is attached. What is apparent to me is the fact that there are 
error messages every other time (I just attached several seconds) and non 
regular accesses (should happen every ten seconds) but no hang like before. 
So I have to wait a little more. If I am unlucky the delays introduced by the 
tons of printfs prevent sensors from crashing my sensor chip. But maybe some 
of you guys can understand why the errors are being reported.
Thank you in advance,
take care


Dieter Jurzitza


Tyan Tiger 2460, SuSE 9.3, kernel 2.6.11-SMP (have seen similar issues with 
older kernels, too).

-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------
-------------- next part --------------
A non-text attachment was scrubbed...
Name: logpart.bz2
Type: application/x-bzip2
Size: 1336 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060418/c2de2d8c/logpart.bz2
