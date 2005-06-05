From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sun, 05 Jun 2005 20:45:31 +0000
Subject: [lm-sensors] [PATCH 2.6] drivers/i2c/chips/it87.c: use dynamic
Message-Id: <2538186705060511441a854152@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050605115325.27cd4429.khali@linux-fr.org>
In-Reply-To: <20050605115325.27cd4429.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ah, thanks for reminding me, I had somehow forgotten that episode.
> 
> However, I have plans to modify the it87 driver to only create the sysfs
> files for channels which are really in use [1]. For example, I have an
> IT8705F chip on my new motherboard, which has 3 unused voltage channels,
> 2 unused temperature channels and 1 unused fan channel. The driver will
> still create the sysfs interface for them at the moment. I think this
> isn't good. So it would probably be wiser to wait for me to implement
> this, and then see whether using arrays of attributes still makes sense
> (and how), rather than the other way around.
> 
> So I think we should apply the currently available patch for the it87
> driver, and work on top of that later as time permits.

Ah yes, ok.

> 
> [1] Actually I have many more plans for the it87 driver than just this
> one. It's amazing how easier it is to hack on any given driver once you
> do have hardware to test your changes :)

It's just gaining that hardware that's the problem...now if only I
could afford a board with an IPMI 2.0 BMC with 60 sensors ;-)

Thanks,
Yani
