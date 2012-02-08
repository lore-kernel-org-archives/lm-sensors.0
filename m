From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 16:06:58 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <20120208160658.GA21537@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 08, 2012 at 09:55:31AM -0500, Jean Delvare wrote:
> On Wed, 8 Feb 2012 06:16:41 -0800, Guenter Roeck wrote:
> > On Wed, Feb 08, 2012 at 06:39:46AM -0500, Patrick Marty wrote:
> > > Guenter,
> > > 
> > > I have tested all driver versions with the 3 linux kernels installed
> > > on my system :
> > >    * 3.0.0-15-generic
> > >    * 3.0.0-12-generic
> > >    * 2.6.38-13-generic
> > > 
> > > I have re-compiled and re-installed each driver version for each kernel version.
> > > 
> > > All versions work with kernel 2.6.38-13 ( but you probably already
> > > know that ) and ... all versions fail with kernels 3.0.0.* ( I mean I
> > > got an error message when loading the driver with modprobe )
> > > 
> > > I have also tested all driver versions with linux running from an usb
> > > key with kernel 3.0.0-12-generic.
> > > 
> > > And all versions worked ! No error after loading the driver :)
> > > 
> > > The main differences I could think of with the linux installed on my
> > > hard drive with the linux from usb key were :
> > >    * not the same gcc version :
> > >       * 4.6.1 on usb key
> > >       * 4.4.6 on hard drive
> > >    * not the same graphic card driver
> > >       * nouveau driver on usb key
> > >       * nvidia driver on hard drive
> > > 
> > > So I have also tried all driver versions compiled with gcc 4.6.1 with
> > > linux kernel 3.0.0-15-generic ( I unload the driver with modprobe -r
> > > ... before reloading it and I checked with dmesg & lsmod that the
> > > driver was loaded :) ).
> > > And all versions worked :)
> > > 
> > > So It seems that compiling with gcc 4.4.6 is the source of the problem.
> > > And compiling the driver with gcc 4.6 solved it.
> > > Do you have any idea why ?
> > > 
> > Puzzled. I am copying Jean and the list ... Jean, any idea ? Compiler bug ?
> 
> Yes, this really looks like a compiler bug.
> 
> There's at least one known kernel miscompilation issue with gcc 4.4.4:
> http://gcc.gnu.org/bugzilla/show_bug.cgi?idE312
> 
> > > I can send you the .o & .ko files compiled with gcc 4.6 if you need them.
> >
> > Would be great if you could do that, with -DDEBUG as suggested by Jean
> > in his other e-mail, to let us find the offending source.
> > 
> > Please keep Jean and the list copied on your replies. We'll need as much support
> > as we can get on this one.
> 
> Unfortunately none of my systems has gcc 4.4... I have 4.3, 4.5 and 4.6.
> 
I have 4.4.3 and 4.4.5 (and 4.5.1, and 4.6.1). Never had any problems with it, though.

Given the bug report above, I don't think it would help much to even try
any of those versions anyway; we would need 4.4.6.

Would it be worthwhile trying to track this down further ? 4.4.6 is the latest gcc
version from the 4.4 series, so the problem might bite us again.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
