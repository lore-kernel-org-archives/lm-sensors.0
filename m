From: kelledin@users.sourceforge.net (Kelledin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <200307262038.18330.kelledin@users.sourceforge.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, final patchsets.

i2c-alpha.patch just includes Oleg's i2c-elektor fixes (the 
i2c-velleman fix has already made it to CVS).

lm_sensors-alpha.patch includes various one-line fixes to drivers 
(mostly missing headers).  Most of these drivers (like i2c-i810, 
i2c-amd8111, i2c-nforce2) are currently useless on Alpha, but 
may one day be useful (remember the AMD Irongate northbridge?)  
Besides, if we're going to leave them in the standard build 
vector, we should at least have them not break the build.

i2c-tsunami... well... the file I got from Oleg is the same as 
what's already in CVS.  I did some minor fixes (the struct 
initialization change and a few added includes), but I lack the 
knowledge/hardware to get it working.

Since i2c-tsunami just reads an SPD, I say let Oleg get to it 
when he gets to it.  I don't think very many people will be 
broken-hearted over not being able to read their DIMM clock or 
some other such thing. ;)

For now, i2c-tsunami build targets are commented out in 
kernel/busses/Module.mk.  They should be re-enabled when the 
driver works again.

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-alpha.patch
Type: text/x-diff
Size: 1187 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030726/9e3a3a14/i2c-alpha.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-alpha.patch
Type: text/x-diff
Size: 4192 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030726/9e3a3a14/lm_sensors-alpha.bin
