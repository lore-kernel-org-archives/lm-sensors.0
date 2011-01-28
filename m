From: Phillip Susi <psusi@cfl.rr.com>
Date: Fri, 28 Jan 2011 14:28:11 +0000
Subject: Re: [lm-sensors] Identifying i2c devices on Asus P8P67 sandybridge
Message-Id: <4D42D27B.5040004@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D40E39E.4030406@cfl.rr.com>
In-Reply-To: <4D40E39E.4030406@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 1/28/2011 4:25 AM, Jean Delvare wrote:
> FWIW, last time I experienced this, it was caused by a mouse connected
> to the serial port of the machine. Disconnecting the mouse fixed it.

All USB here.  I wonder if the SMM keyboard and mouse emulation could be
the problem?

> Also, there are various versions of memtest86 and memtest86+ around,
> trying a different version might work around the bug. OTOH, old
> versions probably won't know how to deal with DDR3.

I'll have to try the latest one tonight and see.  The one on my Ubuntu
Maverick install just instantly reboots.  The one on my Natty test flash
stick hangs after drawing the initial screen and a few lines of output.

> Oh well. The market of memory modules has gone crazy. And the number of
> timing values has literally exploded since DDR2. My BIOS offers to let
> me tweak each setting manually and I got totally frightened by the
> length of the list (of course I set it all back to auto and ran away.)

That's exactly how I felt.

> Anyway, I don't think this will be a big issue in practice. All I
> really meant was: take the output of decode-dimms with a grain of salt,
> while it should be OK on SDRAM and DDR, DDR2 and DDR3 support isn't too
> well tested and the reported values may be incorrect.

That's why I'm reporting it; so the bugs can be fixed ;)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
