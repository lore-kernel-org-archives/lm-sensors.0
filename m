From: kflasch@gravity.phys.uwm.edu (Kevin Flasch)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: update to ticket 855
Message-Id: <Pine.LNX.4.33.0204241335490.15924-100000@butters.phys.uwm.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0204011057360.4335-100000@hypatia.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.33.0204011057360.4335-100000@hypatia.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 19 Apr 2002, Mark D. Studebaker wrote:

> One thing you can do is use 'prog/dump/i2cdump 0 0x2d'
> to dump the registers of the chip.
> Look for either FF at the alarm registers at 0x41 and 0x42,
> or maybe all FF's.
> This will eliminate the adm1025 driver as the problem.

I'm monitoring this on a machine now. When I have results, I will email you
them.

> If so then the problem is the bus driver or the chip itself.
>
> What bus driver are you using?

i2c-i801

If you mean something else by the bus driver, please let me know. This is what
I thought you meant.

 ----------------------------------------
   Kevin James Flasch
   http://www.uwm.edu/~kflasch/kflasch.gpg
