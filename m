From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: [Fwd: Re: New bus driver: XSCALE iop3xx]
Message-Id: <3ED7959A.3DB2F9C7@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED786AE.6090502@edgedesign.us>
In-Reply-To: <3ED786AE.6090502@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

mkpatch doesn't work for 2.5 kernels, so don't mess with 
anything in the mkpatch directory unless your driver
works on 2.4 kernels.

Since you checked it into the HEAD branch and not the lk2-4 branch
I assume it's 2.5 only? If so work directly with Greg, and
you probably didn't need to check the driver into CVS at all.

Philip Edelbrock wrote:
> 
> Sorry, I'm going to have to punt these.
> 
> Phil
> 
> -------- Original Message --------
> From:   - Fri May 30 09:26:18 2003
> X-UIDL:         f3881e4bf6c98c6a
> X-Mozilla-Status:       0011
> X-Mozilla-Status2:      00000000
> Return-Path:    <peterm@remware.demon.co.uk>
> Received:       from anchor-post-31.mail.demon.net
> (anchor-post-31.mail.demon.net [194.217.242.89]) by Ren.netroedge.com
> (8.12.8p1/8.9.1) with ESMTP id h4UF9r4e028260 for <phil@edgedesign.us>;
> Fri, 30 May 2003 08:09:54 -0700
> Received:       from remware.demon.co.uk ([194.222.70.153]) by
> anchor-post-31.mail.demon.net with esmtp (Exim 3.35 #1) id
> 19Llch-0008tR-0V for phil@edgedesign.us; Fri, 30 May 2003 16:16:51 +0100
> Message-ID:     <3ED775E2.1010507@remware.demon.co.uk>
> Date:   Fri, 30 May 2003 16:16:50 +0100
> From:   Peter Milne <peterm@remware.demon.co.uk>
> User-Agent:     Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b)
> Gecko/20030507
> X-Accept-Language:      en-us, en
> MIME-Version:   1.0
> To:     Philip Edelbrock <phil@edgedesign.us>
> Subject:        Re: New bus driver: XSCALE iop3xx
> References:     <3ECF4C68.6020102@remware.demon.co.uk>
> <3ED4E4CB.2030008@netroedge.com> <3ED50359.20305@remware.demon.co.uk>
> <3ED50668.4010201@netroedge.com> <3ED5252D.5040404@remware.demon.co.uk>
> <3ED6969E.1000107@edgedesign.us>
> In-Reply-To:    <3ED6969E.1000107@edgedesign.us>
> Content-Type:   text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding:      7bit
> X-SpamBouncer:  1.5 (8/16/02)
> X-SBClass:      OK
> X-Spambayes-Classification:     ham; 0.00
> 
> Hi Phil
> 
> cvs access is good (after stopped typing in the hash and entered the
> clear text :-) ).
> 
> So I've checked in the driver comprising kernel/i2c-iop3xx.[ch], and
> Module.mk
> 
> But the next step of patching into the kernel has confused me, I hope
> you can help
> 
> I'm using a 2.5 series kernel, so I want to end up with an entry in
> drivers/i2c/Kconfig and drivers/i2c/Makefile;
> 
> It looks like mkpatch/mkpatch.pl will update the Makefile, but no sign
> of Kconfig.
> 
> I've messed with the old style Config.in, but am not sure if it is
> exactly right, or how to test.
> (running mkpatch.pl against my source tree yields a patch with no
> menction of my files, so I'm not
> sure if this is good or not!) So that was steps 127 thru 135.
> 
> I've appended the cvs diff in my mkpatch directory, looks harmless,
> should I check them in?.
> 
> Thanks for your help
> 
> Peter.
> 
> ************************************************************************
> 
> cvs diff in mkpatch
> 
> cvs server: Diffing .
> Index: Config.in
> =================================> RCS file: /home/cvs/i2c/mkpatch/Config.in,v
> retrieving revision 1.19
> diff -r1.19 Config.in
> 46a47,50
> >    if [ "$CONFIG_ARCH_IOP3XX" = "y" ]; then
> >       dep_tristate 'XSCALE IOP3xx on-chip i2C Algorithm'
> CONFIG_I2C_IOP3XX $CONFIG_I2C
> >    fi
> >
> Index: FILES
> =================================> RCS file: /home/cvs/i2c/mkpatch/FILES,v
> retrieving revision 1.14
> diff -r1.14 FILES
> 11a12,13
> > kernel/i2c-iop3xx.c             drivers/i2c/i2c-iop3xx.c
> > kernel/i2c-iop3xx.h             drivers/i2c/i2c-iop3xx.h
> Index: mkpatch.pl
> =================================> RCS file: /home/cvs/i2c/mkpatch/mkpatch.pl,v
> retrieving revision 1.47
> diff -r1.47 mkpatch.pl
> 244a245,248
> > XSCALE IOP3XX interface
> > CONFIG_I2C_IOP3XX
> >   This supports the internal Xscale 803xx i2c Bus Interface Units (biu)
> >
> 357a362
> > obj-$(CONFIG_i2C_IOP3XX)        += i2c-iop3xx.o
> 
> Philip Edelbrock wrote:
> 
> >
> > You're added.  Let me know if you have troubles logging in or
> > commiting files, and be read up before commiting files or making changes.
> >
> > BTW- bus drivers need to be commited, but device access can be done
> > through /dev/i2c device files in normal user space, if it helps.
> >
> >
> > Phil
> >
> > Peter Milne wrote:
> >
> >> Hi Phil
> >>
> >> Thanks; I was only at the stage of needing guest access :-), but
> >> since you mention it,
> >> please make me
> >>
> >
> >
