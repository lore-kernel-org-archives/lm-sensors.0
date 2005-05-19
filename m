From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c-1.8.4 and lm_sensors-2.8.5 -- a comment
Message-Id: <20040420160008.GA30809@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
In-Reply-To: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 20, 2004 at 02:48:29PM +0200, Jean Delvare wrote:
> Well, in my mind the -b flag was working well enough and was what people
> needed. I remember one user cross-compiling modules for an embedded
> system those root disk was mounted on the host system. I think that the
> -b flag was exactly what the guy wanted.
> 
> > Instead of running "/sbin/depmod -a -b $(DESTDIR)" and producing a
> > bunch of useless modules.* files, I would like to suggest that you
> > omit this and instead print a warning that depmod must be run after
> > the modules have been installed in their final location
> 
> I would much like to hear distribution packagers on this. Aurelien,
> Axel?

The script used to create the lm-sensors packages on Debian is not
calling the install rule of the Makefile. Instead all the modules are
copied to the target directory one by one. This is mainly because the
installed directory is not the default one (the modules are installed
into /lib/modules/`uname -r`/i2c or /lib/modules/`uname -r`/lm-sensors).

depmod is then called by the post-install and the post-remove scripts
of the packages.

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
