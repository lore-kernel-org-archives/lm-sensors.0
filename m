From: Tom Weichmann <tomcw@adelphia.net>
Date: Tue, 10 Apr 2007 11:58:08 +0000
Subject: Re: [lm-sensors] openCBM
Message-Id: <200704100801.11136.tomcw@adelphia.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_Hy3GGPZpxKv284l"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_Hy3GGPZpxKv284l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Spiro,

Thanks.  I just bought a XA1541 cable and dug out my old original 1541 drive.  
I downloaded the latest openCBM-0.4.0 and tried to build.

1st problem I had build died but I found the attached patch that made it work.  
I am using openSuSE 10.2:
tom@linux:~> uname -a
Linux linux 2.6.18.8-0.1-default #1 SMP Fri Mar 2 13:51:59 UTC 2007 i686 
athlon i386 GNU/Linux

This patch was listed for openSuSE 10.1, but it got me past that error.

Next I kept getting 'directory does not exist errors, so I commented the 
following sub directories out of the Makefile:

demo/flash demo/morse demo/rpm1541 docs mnib36

That was the only way I could get it to compile.  I figured that demo stuff 
and the docs were not that important.  Also mnib was listed as an optional 
sub dir.  Are any of these important?

After I did 'make dev' and 'make install' I followed the instructions on your 
web site:

/sbin/depmod
/sbin/modprobe parport 
these were OK

then /sbin/insmod cbm lp=0
insmod: can't read 'cbm': No such file or directory

so I went to my modules directory:

/lib/modules/2.6.18.8-0.1-default/kernel/drivers/

and created a cbm directory to install the module

/lib/modules/2.6.18.8-0.1-default/kernel/drivers/cbm

then put that directory into my config.make and compiles again.  After make 
install the cbm.ko was 
in /lib/modules/2.6.18.8-0.1-default/kernel/drivers/cbm but I still get the 
same error:

/sbin/depmod
/sbin/insmod cbm lp=0
insmod: can't read 'cbm': No such file or directory

----------

Another problem, but maybe related is that if I try to use one of the tools 
like cbmctrl I get errors too:

tom@linux:/usr/local/bin> cbmcopy --help
cbmcopy: error while loading shared libraries: libopencbm.so.0: cannot open 
shared object file: No such file or directory
tom@linux:/usr/local/bin> cbmctrl --help
cbmctrl: error while loading shared libraries: libopencbm.so.0: cannot open 
shared object file: No such file or directory


but libopencbm.so.0 is in the /usr/local/lib directory. (cbmctrl et al are 
in /usr/local/bin)

tom@linux:/usr/local/bin> ls -al  /usr/local/lib/ | grep libopencbm.so.0
lrwxrwxrwx  1 root root      15 2007-04-09 21:59 libopencbm.so -> 
libopencbm.so.0
lrwxrwxrwx  1 root root      19 2007-04-09 21:59 libopencbm.so.0 -> 
libopencbm.so.0.4.0
-rwxr-xr-x  1 root root   59021 2007-04-09 21:59 libopencbm.so.0.4.0


Can you give me some pointers to getting this to work?

Thanks,

Tom Weichmann



On Tuesday 10 April 2007 03:22, Spiro Trikaliotis wrote:
> Hello Tom,
>
> * On Mon, Apr 09, 2007 at 10:11:13PM -0400 Tom Weichmann wrote:
> > I'm not sure if it is OK to e-mail you directly with a problem, please
> > feel free to re-direct me with an apporiate place to ask questions.
>
> well, there is a opencbm-user mailing list at
> http://sourceforge.net/mail/?group_id=122047. Anyway, as no-one is using
> it, you can also mail me directly.
>
> What is your problem?
>
> Regards,
>    Spiro.

--Boundary-00=_Hy3GGPZpxKv284l
Content-Type: text/x-diff; charset="iso-8859-1";
	name="cbm_module.c-suse10.1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cbm_module.c-suse10.1.diff"

--- sys/linux/cbm_module.c.orig	2006-04-28 12:40:14.000000000 +0200
+++ sys/linux/cbm_module.c	2006-06-02 08:20:04.123747763 +0200
@@ -102,20 +102,20 @@
 
 #ifdef KERNEL_VERSION
 # ifdef DIRECT_PORT_ACCESS
-MODULE_PARM(port,"i");
+module_param(port,int,0444);
 MODULE_PARM_DESC(port, "IO portnumber of parallel port. (default 0x378)");
 
-MODULE_PARM(irq,"i");
+module_param(irq,int,0444);
 MODULE_PARM_DESC(irq, "IRQ number of parallel port. (default 7)");
 # else
-MODULE_PARM(lp,"i");
+module_param(lp,int,0444);
 MODULE_PARM_DESC(lp, "parallel port number. (default 0)");
 # endif  /* DIRECT_PORT_ACCESS */
 
-MODULE_PARM(cable,"i");
+module_param(cable,int,0444);
 MODULE_PARM_DESC(cable, "cable type: <0=autodetect, 0=non-inverted (XM1541), >0=inverted (XA1541). (default -1)");
 
-MODULE_PARM(reset,"i");
+module_param(reset,int,0444);
 MODULE_PARM_DESC(reset, "reset at module load: <0=smart reset, 0=no reset, >0 force reset (default: "
 #ifdef DIRECT_PORT_ACCESS
                 "-1"
@@ -123,7 +123,7 @@
                 "1"
 #endif
                 ")");
-MODULE_PARM(hold_clk,"i");
+module_param(hold_clk,int,0444);
 MODULE_PARM_DESC(hold_clk, "0=release CLK when idle, >0=strict C64 behaviour. (default 1)");
 
 MODULE_AUTHOR("Michael Klein");

--Boundary-00=_Hy3GGPZpxKv284l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_Hy3GGPZpxKv284l--
