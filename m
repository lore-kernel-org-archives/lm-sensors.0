From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Jun 2009 12:53:15 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090624145315.1436db6a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 24 Jun 2009 14:32:45 +0200, Konstantin Kletschke wrote:
> Hi Jean,
> 
> Am 2009-06-24 14:10 +0200 schrieb Jean Delvare:
> 
> > Note that the >> doesn't buy you anything, > is enough. These are
> > virtual files.
> 
> My zsh has no_clobber enabled and the shell insists on >> even on
> virtual files therefore :-) 

The usual way to counter no_clobber is >|, not >>.

> > This is very odd. Which kernel are you running exactly? I have a hard
> 
> Exactly I am running 2.6.30-rc7, the guy reporting this in the ubuntu
> forum did this februrary 28th, so on another kernel.

Would you be able and willing to apply a patch to your kernel and
rebuild it, if I come up with something?

> > time understanding how this can happen at all. Does writing to pwm3
> > change the value of pwm2, too?
> 
> echo into pwm1 changes nothing:
> 
> > cat pwm1 pwm2 pwm3
> 77
> 55
> 78
> > echo "99" >> pwm1
> > cat pwm1 pwm2 pwm3
> 77
> 55
> 78
> 
> echo into pwm2 changes pwm1:
> 
> > cat pwm1 pwm2 pwm3
> 77
> 55
> 78
> > echo "99" >> pwm2
> > cat pwm1 pwm2 pwm3
> 99
> 55
> 78
> 
> echo into pwm3 changes pwm3:
> 
> > cat pwm1 pwm2 pwm3
> 99
> 55
> 78
> > echo "100" >> pwm3
> > cat pwm1 pwm2 pwm3
> 99
> 55
> 100

This is all very confusing, I admit. I would like you to unload the
w83627ehf driver and try to read from / write to the chip directly. For
this you'll need the isadump and isaset tools (part of lm-sensors.)

Registers pwm1, pwm2 and pwm3 are at 0x01, 0x03 and 0x11, respectively.
You can see their raw value using the following command (as root):

isaset 0x295 0x296 0x4e 0 # set bank to 0
isadump 0x295 0x296

Then I would like you to write to each register, then check the result.
The value written doesn't matter as long as it is different from the
current value of all 3 registers in question:

isaset 0x295 0x296 0x01 0xaa
isadump 0x295 0x296

isaset 0x295 0x296 0x03 0xbb
isadump 0x295 0x296

isaset 0x295 0x296 0x11 0xcc
isadump 0x295 0x296

If this works fine then that would be a bug in the driver. If it
doesn't, that would be a hardware bug.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
