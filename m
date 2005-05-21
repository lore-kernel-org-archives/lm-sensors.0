From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 21 May 2005 10:50:49 +0000
Subject: [lm-sensors] Dell Optiplex GX110 PC87360
Message-Id: <20050521104951.24eb4ef3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1116622911.9107.4.camel@wlt.obsidian-studios.com>
In-Reply-To: <1116622911.9107.4.camel@wlt.obsidian-studios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi William,

> I am curious to know if you ever found a solution or got any sensors
> information using the pc87360 driver on a Dell Optiplex GX110?
> (...)
> I came across this
> http://archives.andrew.net.au/lm-sensors/msg28166.html
> 
> Any info would be greatly appreciated :)

Our conclusion in this case and a similar one a few days ago is that the
PC87364 Super-I/O chip found on Dell Optiplex GX110 systems is not used
for fan speed monitoring. The logical device is disabled or purpose, and
there is no benefit in activating it. The lines are simply not
physically wired.

The two previous cases differ in that the first one mentioned hardware
monitoring information being reported by the BIOS, while the second
couldn't see any there. It might be a purchase option, or different
hardware or BIOS revisions. At any rate my pc87360 driver isn't going to
be of any help for this system, sorry. If it has hardware monitoring
capabilities, these are hosted in a different chip.

-- 
Jean Delvare
