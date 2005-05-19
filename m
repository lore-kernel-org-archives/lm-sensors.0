From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: Cant access procfs: lm-sensors-2.8.6 linux-2.6.7-gentoo-r11
Message-Id: <Pine.LNX.4.58.0407281316510.16161@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040728052617.GC19653@ool-44c29dc9.dyn.optonline.net>
In-Reply-To: <20040728052617.GC19653@ool-44c29dc9.dyn.optonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

>
> I used to use old userspace tools with my 2.6.* kernel.  When updating to
> 2.6.5, I noticed that I would need the newer lm_sensors 2.8.6.  I tried to
> change as little as possible in the transition, and I compiled the i2c modules
> for the new kernel as expected.

You made just make user_install correct to lm_sensors package downloaded
from us? (no gentoo package, maybe try the gentoo package instead)

If I undestand correctly you are using gentoo kernel.

We had always trouble with gentoo people and we cant support their kernel
version.

huh very strange message "permission denied"

Only thing I can advice is:

1) install "vanilla" - original linux kernel
2) install lm_sensors from our web site (make user_install)
3) make sure you dont have any old library in /usr/lib/ (delete all
libsensor*)


Again I'm sorry we cannot support gentoo modified kernels now.
Try to find some gentoo forum for help.

Regards

Rudolf
