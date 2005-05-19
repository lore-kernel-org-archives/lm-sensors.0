From: rob.blomquist@verizon.net (Rob Blomquist)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: I2c (cvs upload) compile problem.
Message-Id: <200304102212.04870.rob.blomquist@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304092003.10837.rob.blomquist@verizon.net>
In-Reply-To: <200304092003.10837.rob.blomquist@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 10 April 2003 12:40 am, you wrote:
> > I uploaded the freshest i2c and lm_sensors packages by cvs tonight in
> > the hopes that my ASUS A7N8X board with its Nivida chips would be
> > detected. I am running a fresh build of Mandrake 9.1, with the
> > 2.4.21-0.13mdk kernel running.
>
> You mean you *downloaded* the packages?
Yes, I dowloaded them by cvs last night.

> > I get a compile error in "make install" right at the begininning:
>
> That's bad. Let's fix it.
>
> > [root@timmy2 i2c]# make install
> > (...)
> > install: `/lib/modules/2.4.21-0.13mdksmp' is a directory
> > install: `2.4.21-0.13mdkenterprise' is a directory
> > install: `2.4.21-0.13mdk' is a directory
> > make: *** [install-kernel] Error 1
>
> Can you show me the output of the following commands:
>
> uname -r
>
$ uname -r
2.4.21-0.13mdk


> grep UTS_RELEASE
> /lib/modules/2.4.21-0.13mdk/build/include/linux/version.h|cut -f 2 -d'"'

[root@timmy2 robbo]# grep UTS_RELEASE 
/lib/modules/2.4.21-0.13mdk/build/include/linux/version.h|cut -f 2 -d'"'
2.4.21-0.13mdksmp
2.4.21-0.13mdkenterprise
2.4.21-0.13mdk
2.4.21-0.13mdksecure

I am quite mystified by all of these, as I am only using the kernel 
2.4.21-0.13mdk, and I downloaded the src.rpm for it, hopeing that it would 
work without a recompile of the same kernel. Why the f*ck would Mandrake put 
all these libraries on a machine that only ran one of the kernels? Argh. As 
you can see:

[root@timmy2 robbo]# cd /boot
[root@timmy2 boot]# ls
boot.0300                  kernel.h@                System.map@
config@                    kernel.h-2.4.21-0.13mdk  System.map-2.4.21-0.13mdk
config-2.4.21-0.13mdk      map                      us.klt
grub/                      message@                 vmlinuz@
initrd-2.4.21-0.13mdk.img  message-graphic          vmlinuz-2.4.21-0.13mdk
initrd.img@                message-text

Thanks a bunch.

Rob

-- 

Kirkland, Washington
