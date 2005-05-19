From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: lm_sensors SiS730
Message-Id: <20011113151159.K5776@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
In-Reply-To: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


My computer is strange, it's originally a RH5.2, but it's had many
things updated by hand including the kernel, compilers, libs, etc.

In a nutshell, I'm using a receint 2.4.x kernel with i2c patches.  Get
the i2c distro from the lm-sensors download page, and do a cd
i2c;mkpatch/mkpatch.pl . /usr/src/linux > /usr/src/i2c.patch;cd
/usr/src/linux;patch -p1 <../i2c.patch  Built the kernel with I2C
support (dev and proc).  Got Lm_sensors2 (use CVS), edited Makefile to
find the I2C headers in the kernel, did a 'make' and a 'make install'. 
sensorslib is installed in /usr/local/lib, so make sure your
ld.so.conf is up-to-date, and then do a 'ldconfig'.  insmod the
modules, and run 'sensors'.  Salt and pepper to taste, serve hot. 


Phil

On Tue, Nov 13, 2001 at 02:22:13PM -0800, Bob Ramstad wrote:
> Phil, thanks so much for the quick reply!
> 
> If you have a sec, I'd appreciate it very much if you could tell me
> what linux distro you're using and what commands you put where to get
> things running... the INSTALL and QUICKSTART docs are pretty good, but
> nothing beats a cut and paste from a running config...  thanks in
> advance!
> 
> -- Bob

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
