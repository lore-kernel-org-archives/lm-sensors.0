From: DarKRaveR@verfeiert.org (DarKRaveR@verfeiert.org)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <17310096923.20040216222052@verfeiert.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

For now, just a wild guess, but it seemed, that gentoo sources using
the preemptible kernel patch (Was it preemptible or preemptive ?) tend
to freeze temporary in a non reproduceable way. Since the patch
mangles the scheduling and certainly the most inner parts of the
kernel I could imagine it might influence lm sensors too.

Just a thought to consider that kinda popped up my mind, since I saw a
couple of gentoo boxes with 2.4.x series that all had problems with
kernels including this patch.

We all switched the feature off and rebuilt the kernel, but I guess
most users use the premade gentoo scripts and there it seems to be
turned on by default.

Intristing question would be: Do others (non gentoo) folks use that
patch, do they have problems with it, esp. with lm_sensors?

My 2 cents.

-Sven

Monday, February 16, 2004, 8:39:40 PM, you wrote:

JD> (Do you know how much I dislike mixed-case?)

>> Thanx for your answer. Well, I had soem problems with gentoo kernels
>> in the past, so I decided to use a vanilla kernel, with xfs patches
>> and soem other small patches I needed (amongst them i2c).

JD> Good move. The Gentoo kernels are know to be mostly not compliant with
JD> lm_sensors anyway. BTW, if you can figure out why, please let us know.

>> I will check back on the libs. I was already considering using the
>> source and compiling it by hand.

JD> I would recommend that you begin with uninstalling the Gentoo stuff
JD> before installing your own. This is the best way to avoid conflicts.




-- 
Best regards,
 DarKRaveR                            mailto:DarKRaveR@verfeiert.org
