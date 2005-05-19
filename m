From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [patch] gcc-3.2 problems: i2c local vs. kernel headers
Message-Id: <20030429171548.GA32519@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030319172417.GC14159@westend.com>
In-Reply-To: <20030319172417.GC14159@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-04-29 08:43:09 +0200]:

> I had similar problems as I switched to Slackware 9.0. The main problem
> is that I first asked the distribution to install kernel headers (as a
> package), and then installed and compiled my own kernel from sources.
> Then, as I tried to compile i2c and lm_sensors for this new kernel,
> headers were a complete mess. The clean solution I used is:
> 
> 1* Remove the kernel headers package. This package installed all headers
> directly in /usr/include, where non-kernel headers also live. These
> files aren't needed once you have real kernel sources available.
> 
> 2* Create the following symlinks (these are *directories*):
> /usr/include/asm -> /usr/src/linux/include/asm
> /usr/include/linux -> /usr/src/linux/include/linux
> This of course assume that you have a complete kernel source tree at
> /usr/src/linux.

Please read this:

http://www.tldp.org/LDP/lfs/html/chapter06/kernel.html#AEN2385

Slackware and RedHat (glibc-kernheaders) are doing the right thing.

> After that, everything compiled smoothly, providing Christian's fix is
> *also* used. I don't really know why it works (since the change isn't
> supposed to actually change anything), but I know it did.

I haven't looked at this fix yet... but I will when I get the chance.
I have a RedHat 9 here I can try.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
