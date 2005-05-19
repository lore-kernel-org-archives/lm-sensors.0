From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: 2.6.12-rc2-mm3: Information: i2c sysfs names
Message-Id: <srhp61pjnhoombm6t5k5vapdhjl3u0i096@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <349m611ifev8aphbqe7h289hovvqlaqn17@4ax.com>
In-Reply-To: <349m611ifev8aphbqe7h289hovvqlaqn17@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 24 Apr 2005 19:03:51 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

Lots of stuff about sysfs naming, there's a minor buglet in 
the lists presented in the first post, a few sysfs names with 
two embedded numbers need s/Y_/1_/ to fix second number, 
latest info, script, lists on:

  http://scatter.mine.nu/hwmon/sysfs-names/

I'm still resisting the urge to do this in perl :)

--Grant.
