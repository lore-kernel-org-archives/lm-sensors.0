From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Jan 2006 15:38:29 +0000
Subject: [lm-sensors] [GIT PATCH] I2C and hwmon patches for 2.6.15
Message-Id: <20060108163829.49eb7eee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060106220642.GA19212@kroah.com>
In-Reply-To: <20060106220642.GA19212@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Greg,

> Here are some i2c and hwmon patches.  They add a new hwmon driver and
> fix a number of different bugs.  All of these have been in the last few
> -mm releases.
> 
> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> or from:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> if it isn't synced up yet.
> 
> The full patch series will sent to the sensors mailing list, if anyone
> wants to see them.

I checked the patches and everything is in order :) Thanks!

I also backported a few of these changes to i2c CVS and lm_sensors CVS.

-- 
Jean Delvare

