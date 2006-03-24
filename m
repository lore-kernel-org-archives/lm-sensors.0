From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 24 Mar 2006 09:01:46 +0000
Subject: [lm-sensors] [GIT PATCH] I2C and hwmon patches for 2.6.16
Message-Id: <20060324100146.835b24a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060323224306.GA32322@kroah.com>
In-Reply-To: <20060323224306.GA32322@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Greg,

> Here are some i2c and hwmon patches for against your current git tree.
> They all have been in the -mm tree for a few weeks and months.
> 
> They fix a number of various bugs and add some new drivers and features
> (hm, that was sure vague, see the changelog below for details...)

Vague, and wrong too ;) No new driver this time around.

I've checked all the patches and they match my own stack, so this is a
successful resync once again. Well done!

You still have 10 pending patches from me though (sent yesterday) and
there will most certainly be at least two more by the end of the week
(two RTC i2c drivers use tasklets in forbidden conditions and need to
be fixed.)

Thanks,
-- 
Jean Delvare

