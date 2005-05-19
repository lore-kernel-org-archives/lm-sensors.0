From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: 8xx i2c refers to unspecified chip errata
Message-Id: <20021118194651.GE18374@opus.bloom.county>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DD939B5.3D1F2B6E@paradyne.com> <IGEFJKJNHJDCBKALBJLLIEBKFIAA.joakim.tjernlund@lumentis.se> <20021118204248.0a3b6bda.khali@linux-fr.org>
In-Reply-To: <20021118204248.0a3b6bda.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: joakim.tjernlund@lumentis.se, mds@paradyne.com, linuxppc-embedded@lists.linuxppc.org, sensors@Stimpy.netroedge.com

On Mon, Nov 18, 2002 at 08:42:48PM +0100, Jean Delvare wrote:
> 
> > Patch was(and still is, I think) against linuxppc_2_4_devel. Don't
> > know your tree, is it not the same as linuxppc? Anyhow, too much time
> > has passed for me to remember all details and I don't have the time to
> > go back and do it all over again. I suggest you take the linuxppc
> > version, patch it and adopt it to your tree.
> 
> Why the hell are there two different trees? :'( Can't we work all
> together for a better result?

Because the linuxppc tree doesn't track the whole i2c tree, as that would
be quite silly. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
