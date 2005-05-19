From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: I2C patch for Linux 2.4.23-rc1 [Was: i2c oops]
Message-Id: <20031126192943.7c464d8c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031115212538.677d0fd2.khali@linux-fr.org>
In-Reply-To: <20031115212538.677d0fd2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I would really appreciate if you could take some time to test my
> > patch and make sure it's working OK for you.
> 
> I haven't had time to try the patch in the last week.  Also, I just 
> recently tried 2.6.0-test10, and the sensors work beautifully with it.
> It uses a new sysfs that I was unfamiliar with.  Anyway, GKrellM seems
> to be able to read the sensor data from /sys just fine.  Thus, I guess
> I will not be using 2.4 kernel again since my system seems to be
> running better with the 2.6 kernel.

We are also in the process or porting all our userspace tools to
2.6/sysfs, but it's not finished yet.

> That said, thanks for all the work in patching the 2.4 kernel, and
> keep up the good work toward the 2.6 kernel.

Thanks :) We'll do our best.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
