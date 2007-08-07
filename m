From: "George Joseph \(dev\)" <gtj.devel@peakin.com>
Date: Tue, 07 Aug 2007 01:49:16 +0000
Subject: Re: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2 - mostly working
Message-Id: <22E26940476D1E48AA6F292B5316C9C33895@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
In-Reply-To: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hmmm.  2.6.16 is definitely not going to work but 2.6.21 should compile
fine.  In fact, I just tried it again on a freshly untarred 2.6.21.6
with no errors.  If you tried the older driver, make sure it's
completely cleaned out. Did the patch apply cleanly?

I've got some info on C1E and EIST on the XBX2 specifically at
http://www.peakin.com/xbx2/index.html



> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org 
> [mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of 
> Sebastian Flothow
> Sent: Monday, August 06, 2007 6:07 PM
> To: lm-sensors
> Subject: Re: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2 
> - mostly working
> 
> Am 4. Aug 2007 um 17:16 Uhr schrieb George Joseph ((dev)):
> 
> > There's a later version of the driver at
> > http://www.peakin.com/download/asc76xx-2.6.21.patch
> > If you want to try it.
> 
> I can't compile it - I tried with Gentoo's 2.6.16.52-xen, 
> 2.6.21-gentoo-r4, as well as vanilla 2.6.21.6. Building the kernel 
> always fails with this output:
> 
>    CC [M]  drivers/hwmon/asc76xx.o
> drivers/hwmon/asc76xx.c: In function 'asc76xx_detect':
> drivers/hwmon/asc76xx.c:1077: error: 'struct asc76xx_chip' has no 
> member named 'smb_addr'
> make[2]: *** [drivers/hwmon/asc76xx.o] Error 1
> make[1]: *** [drivers/hwmon] Error 2
> make: *** [drivers] Error 2
> 
> 
> >> | in1_input:1187
> >>
> >> Vccp, BIOS says 1.300 though.
> >
> > The vccp reading is probably correct and the result of C1E 
> kicking in.
> > This reduces the voltage and multiplier when the CPU is 
> idle.  The CPU
> > runs at it's max voltage when in the BIOS screens which is 
> why you see
> > 1.300 there.  Try loading the CPU and take the reading again.
> 
> Indeed, with one core on full load I get 1302; 1293 when loading both 
> cores.
> I guess I ought to read up on those power states - do you happen to 
> have a pointer to a good reference?
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
