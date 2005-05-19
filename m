From: druid@takeover.nl (Michiel Rook)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: porting adm9240 driver to kernel 2.6
Message-Id: <Pine.LNX.4.58.0403031717460.17938@chewie.solar.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello all,

I've been looking over the lm-sensors site(s) the past few weeks, and it
appears the adm9240 driver hasn't been ported (yet).
So, I've started porting the driver, and should have something up
for download this evening (CET).

It's working quite well, only issue remaining (that I can see) is that
prog/sensors/chips.c has some kind of hard-coded mappings for adm9240
sysfs values (2.5V, 1.5V, etc.), and I'm using the standard sysfs values
in0, in_min0, etc. I hope I did the right thing ;)

Regards,

Michiel Rook
