From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 25 Nov 2008 21:20:05 +0000
Subject: [lm-sensors] [PATCH 0/3] adt7470 extra features
Message-Id: <20081125212005.22512.14523.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi all,

As I've been promising for a while, here are (I hope) the features needed
to make the adt7470 driver complete:

The first patch fixes a problem where the pwm outputs temporarily drop toward
zero while temperature sensors are being read.  Since the sensor read operation
can take upwards of a second, the most obvious symptoms of this problem are
fairly annoying: fan spins up for a while, fan spins down, fan spins up, fan
spins for a while... so the solution is to reprogram the chip for manual pwm
control while reading the temperature sensors.

The second patch automatically determines the number of temperature sensors
attached to the adt7470 so that we can shorten the sensor update interval as
much as possible.

The third patch creates a kernel thread that continually updates the temp
sensors so that the in-chip automatic control algorithm will run.  Per an
earlier discussion, the adt7470 can determine the correct pwm output on its
own, but it needs to be told to gather temperature data by hand.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
