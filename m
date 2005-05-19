From: upgrdman@mindspring.com (Farrell Farahbod)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: help: sensors-detect
Message-Id: <1058553587.14394.0.camel@farrell.freemans.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F17172F.4050603@mindspring.com>
In-Reply-To: <3F17172F.4050603@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

oh..ya its a tar.gz....i jsut assumed it was a bz2 as most are :) my
bad.

i guess i will wait, thanks for the tip about dmidecode!

-farrell f.

On Fri, 2003-07-18 at 00:29, Jean Delvare wrote:
> > after i downloaded the tar.bz2 of lm_sensors (...)
> 
> Where that? We don't distribute tar.bz2 files.
> 
> > so after i installed the rpm, i ran /usr/sbin/sensors-detect (as
> > root,) and i get this error message: "...Could not find dmidecode,
> > which should have been installed with lm_sensors. Runing dmidecode
> > would help us determining your system vendor, which allows safer
> > operations...."
> > 
> > first, is this a big problem? if so, how would i go about fixing it?
> 
> Red Hat has an another RPM with dmidecode (that's why they don't ship it
> with the sensors package). I think it's in the kernel-utils package, but
> I am not a Red Hat user.
> 
> 
> > Probing for PCI bus adapters...
> > Use driver `i2c-riva' for device 01:00.0: GeForce2 MX
> > Probe succesfully concluded.
> >  
> > 
> >   We will now try to load each adapter module in turn.
> > Load `i2c-riva' (say NO if built into your kernel)? (YES/no):
> > 
> > i dont know if that kernel module is build into my kernel. i use the 
> > kernel rpms from redhat becuase every time i try to compile a kernel
> > by hand, using a kernel for kernel.org, i end up messing things up a
> > lot. by the way "uname -r" reports 2.4.20-18.9 if this is of any help.
> > and the rpm is optomized for athlon cpus.
> > 
> > anyway i chose yes to try to load the i2c-riva module, and i got this:
> > 
> > modprobe: Can't locate module i2c-riva
> > Loading failed (No such file or directory)... skipping.
> > ** Note: i2c-riva module is available at
> > ** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
> 
> This module is not part of the kernel nor of our distribution, so you
> don't have it unless you install it by yourself. I don't think you will
> find any RPM package for that, so since you don't seem to be willing to
> compile code by yourself, forget about it. 
> > now this isnt too big of a deal to me, becuase it seems to me those 
> > sensors are for my geforce2 card, and im replacing it in about a week
> > or two with a new geforce4 :) but either way...i suppose i should take
> > the opportunity to learn, and fix this problem.
> 
> It would work for your Geforce4 too, methinks, but that's not the point.
> 
> > so then it says:
> > (bla bla bla)
> 
> It says you don't have any supported device. You did not tell us but I
> guess you are using lm_sensors 2.7.0. You should wait for Red Hat to
> package our new 2.8.0 release (could take some weeks) which has support
> for many more devices. When it's ready, update your old package using
> the new one and run sensors-detect again.
