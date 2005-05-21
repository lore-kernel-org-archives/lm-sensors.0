From: support@obsidian-studios.com (William L. Thomson Jr.)
Date: Sat, 21 May 2005 17:13:01 +0000
Subject: [lm-sensors] Dell Optiplex GX110 PC87360
Message-Id: <1116688315.7866.11.camel@wlt.obsidian-studios.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1116622911.9107.4.camel@wlt.obsidian-studios.com>
In-Reply-To: <1116622911.9107.4.camel@wlt.obsidian-studios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 2005-05-21 at 10:49 +0200, Jean Delvare wrote:
>
> Our conclusion in this case and a similar one a few days ago is that the
> PC87364 Super-I/O chip found on Dell Optiplex GX110 systems is not used
> for fan speed monitoring. The logical device is disabled or purpose, and
> there is no benefit in activating it. The lines are simply not
> physically wired.

Ok I have another dell machine I was able to identify and load the
driver for the hardware chip. However it only has fan support, and seems
it's not even being used. Totally different model and series, FYI it's a
Dimension XPS B600r.

> The two previous cases differ in that the first one mentioned hardware
> monitoring information being reported by the BIOS, while the second
> couldn't see any there.

I will have to check but I think this one does have hardware monitoring
stuff in the bios.

>  It might be a purchase option, or different
> hardware or BIOS revisions.

I am big about making sure I am running the latest stable bios release.
Which is common on older hardware to find a newer bios than currently in
use. However knowing Dell, it could go either way :)

>  At any rate my pc87360 driver isn't going to
> be of any help for this system, sorry. If it has hardware monitoring
> capabilities, these are hosted in a different chip.

Great, I will dig some more. I tried compiling in all chips, and seeing
if any others were activated or attempted. Seems only the pc87360 was,
so I guess I am SOL on this machine. No big deal, it's schedule for
replacement this year. I will just make sure the replacement has a chip
I can work with and get info from :)


-- 
Sincerely,
William L. Thomson Jr.
Support Group
Obsidian-Studios, Inc.
http://www.obsidian-studios.com

