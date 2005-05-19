From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <20040216203940.04d022b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(Do you know how much I dislike mixed-case?)

> Thanx for your answer. Well, I had soem problems with gentoo kernels
> in the past, so I decided to use a vanilla kernel, with xfs patches
> and soem other small patches I needed (amongst them i2c).

Good move. The Gentoo kernels are know to be mostly not compliant with
lm_sensors anyway. BTW, if you can figure out why, please let us know.

> I will check back on the libs. I was already considering using the
> source and compiling it by hand.

I would recommend that you begin with uninstalling the Gentoo stuff
before installing your own. This is the best way to avoid conflicts.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
