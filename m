From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [patch] gcc-3.2 problems: i2c local vs. kernel headers
Message-Id: <20030429084309.34f78fc2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030319172417.GC14159@westend.com>
In-Reply-To: <20030319172417.GC14159@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Christian's solution doesn't work perfectly with gcc 3.2.2.  Since
> this is an earlier version than his I wouldn't expect a fix, but I
> thought I'd email in case this comes up again with other people and
> RedHat 9(pulled my hair out for a while).
> 
> The problem seems to be that old headers from /usr/include/linux are
> being picked up in 3.2.2 and I couldn't find a way to get gcc to use
> the right ones.  So I switched to gcc2.96 (on my Redhat 9,
> compat-gcc-7.3-2.96.118 provides /usr/bin/gcc296) in the Makefile and
> all worked fine.

I had similar problems as I switched to Slackware 9.0. The main problem
is that I first asked the distribution to install kernel headers (as a
package), and then installed and compiled my own kernel from sources.
Then, as I tried to compile i2c and lm_sensors for this new kernel,
headers were a complete mess. The clean solution I used is:

1* Remove the kernel headers package. This package installed all headers
directly in /usr/include, where non-kernel headers also live. These
files aren't needed once you have real kernel sources available.

2* Create the following symlinks (these are *directories*):
/usr/include/asm -> /usr/src/linux/include/asm
/usr/include/linux -> /usr/src/linux/include/linux
This of course assume that you have a complete kernel source tree at
/usr/src/linux.

After that, everything compiled smoothly, providing Christian's fix is
*also* used. I don't really know why it works (since the change isn't
supposed to actually change anything), but I know it did.

I hope it'll work for you as it worked for me ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
