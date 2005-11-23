From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Wed, 23 Nov 2005 11:01:09 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051123100021.GA29473@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Last night I reported ticket #2116[1] which is related to the kernel
hanging when attempting to set the sensor limits with sensors -s. I
started reading on the list of other open tickets on other chips to
see if I could find something similar, and I found ticket #2111[2]
reported by Keith.

The common thing between botf our problems is that:

1. We both use kernel 2.6.14 (either 2.6.14 or 2.6.14.2).
2. We both use the i2c-i801 driver.
3. We both have SMP enabled kernels running on P4 CPUs with HT enabled.

In my case I have the w83792d driver for my sensor chip while Keith is
using the lm85 driver. But since we both experience the same lockup
under the same conditions I'm more suspicious of the i2c-i801 driver
and how that driver is behaving in kernel 2.6.14 on SMP systems. Any
other experience where this driver is find under these conditions?

Please CC me as I'm not on the list.

Thanks
Daniel Nilsson

[1]: http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket!16
[2]: http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket!11
