From: oe@hentges.net (Matthias Hentges)
Date: Sat, 30 Sep 2006 17:25:23 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for
Message-Id: <1159637123.4641.33.camel@mhcln03>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

I'm running a C2D (E6600) system here and would be happy to be of
assistance.

I've downloaded and compiled your latest version (I think heh) but the
resulting temperature is a bit off I think.

The CPU temp as reported by the SuperIO chip is 23.5 degrees,
you driver reports about 37000 (37 degrees? and which core? or is that
supposed to be the m/b diode?)
a little c program to read the coretemp from the CPU I have found
elsewhere on the net reports ~51 degrees for both cores on the same idle
system (the little program is attached, it's header says it's GPL).

If you need any testing done let me know. A hwmon sysfs interface to
both(!) coretemps would be most welcome =)



-- 
Matthias Hentges 

My OS: Debian SID. Geek by Nature, Linux by Choice
-------------- next part --------------
A non-text attachment was scrubbed...
Name: coretemp.c
Type: text/x-csrc
Size: 2435 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060930/8e36379b/attachment.bin 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060930/8e36379b/attachment-0001.bin 
