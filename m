From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 28 Jan 2011 09:25:17 +0000
Subject: Re: [lm-sensors] Identifying i2c devices on Asus P8P67 sandybridge
Message-Id: <20110128102517.6f7da7b1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D40E39E.4030406@cfl.rr.com>
In-Reply-To: <4D40E39E.4030406@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 27 Jan 2011 23:51:00 -0500, Phillip Susi wrote:
> On 01/27/2011 12:14 PM, Jean Delvare wrote:
> >>> I am surprised by the tRAS though, it seems way too high, there may be a
> >>> bug in the script.
> >>
> >> It should be 6-8-6-24.
> >
> > Really? Is this what memtest86 is report? It's a long time since I last
> > saw a memory module with the 3 first digits not being the same.
> 
> memtest86 seems to hang or reboot.

FWIW, last time I experienced this, it was caused by a mouse connected
to the serial port of the machine. Disconnecting the mouse fixed it.

Also, there are various versions of memtest86 and memtest86+ around,
trying a different version might work around the bug. OTOH, old
versions probably won't know how to deal with DDR3.

> I am now quite confused because the 
> part number that I ordered was OCZ3P11600C6LV4GK and was listed on 
> newegg as having 6-8-6-24 timings.  That is the part number listed on 
> the retail packaging, but the SPD decodes with decode-dimms ( release 
> 3.0.3 ) as having part number OCZ3P1600C6LV2G with 7-7-7-33 timing.  The 
> Asus bios has an SPD decode utility that agrees with the part number, 
> but shows 7-7-7 for cas, trcp, trp, but 16 for tras, not 33.  Despite 
> showing tRas as 16 in the SPD, it defaults to driving it at 18.  It also 
> lists a bunch of additional timings, none of which are 33.  I can find 
> neither part number on OCZ's web site.

Oh well. The market of memory modules has gone crazy. And the number of
timing values has literally exploded since DDR2. My BIOS offers to let
me tweak each setting manually and I got totally frightened by the
length of the list (of course I set it all back to auto and ran away.)

Anyway, I don't think this will be a big issue in practice. All I
really meant was: take the output of decode-dimms with a grain of salt,
while it should be OK on SDRAM and DDR, DDR2 and DDR3 support isn't too
well tested and the reported values may be incorrect.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
