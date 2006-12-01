From: dean@arctic.org (dean gaudet)
Date: Fri, 01 Dec 2006 23:47:17 +0000
Subject: [lm-sensors] [patch] incomplete mtp008.c port to 2.6.18.2
Message-Id: <Pine.LNX.4.64.0612011544190.1218@twinlark.arctic.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0611172040300.15092@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.64.0611172040300.15092@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 19 Nov 2006, Jean Delvare wrote:

> On Fri, 17 Nov 2006 20:48:59 -0800 (PST), dean gaudet wrote:
> > - the mtp008 seems to hang and start reporting all zeroes/constant 
> > garbage.  i'm skeptical this is just my hacked code though because the 
> > BIOS "System Health Monitor" has the exact same problem after a few 
> > minutes.
> 
> I found the following in our FAQ:
> "Also, MTP008 chips seem to randomly refuse to respond, for unknown
> reasons. You can see this as 'XX' entries in i2cdump."
> So it might be a known issue with this chip. Which makes me wonder if
> it's worth having a driver if it'll stop working after only a few
> minutes. Unless this is a bug in the original drivers and we manage to
> fix it, of course.

i tried some more and had no luck avoiding this problem... and even 
managed to cause it to shut off power to the cpu fans!  that made me a bit 
nervous, and since i had a deadline for putting those boxes online i 
decided to just live without sensors, alas.  (fortunately they're in a 
redundant config, so i'm not so worried.)

thanks for the info though... i might try more in the future.

-dean

