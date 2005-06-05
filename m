From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Jun 2005 20:42:05 +0000
Subject: [lm-sensors] [PATCH 2.6] drivers/i2c/chips/it87.c: use dynamic
Message-Id: <20050605204238.2cdbbbc1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050605115325.27cd4429.khali@linux-fr.org>
In-Reply-To: <20050605115325.27cd4429.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> From what I recall Greg was 'inspired' ;-) by your code to find a nice
> way to aggregate the attributes into arrays, and hence it didn't get
> applied right away. If we haven't got some nice solution for that at
> the moment then this might as well be applied, although I do wonder if
> creating an array and attribute group manually and registering all the
> attributes as a group would be cleaner for now?

Ah, thanks for reminding me, I had somehow forgotten that episode.

However, I have plans to modify the it87 driver to only create the sysfs
files for channels which are really in use [1]. For example, I have an
IT8705F chip on my new motherboard, which has 3 unused voltage channels,
2 unused temperature channels and 1 unused fan channel. The driver will
still create the sysfs interface for them at the moment. I think this
isn't good. So it would probably be wiser to wait for me to implement
this, and then see whether using arrays of attributes still makes sense
(and how), rather than the other way around.

So I think we should apply the currently available patch for the it87
driver, and work on top of that later as time permits.

[1] Actually I have many more plans for the it87 driver than just this
one. It's amazing how easier it is to hack on any given driver once you
do have hardware to test your changes :)

Thanks,
-- 
Jean Delvare
