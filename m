From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 22 Feb 2011 19:29:46 +0000
Subject: Re: [lm-sensors] Add support for LM75A.
Message-Id: <1298402986.24938.242.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219115159.2da19dfe@endymion.delvare>
In-Reply-To: <20110219115159.2da19dfe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-02-22 at 13:27 -0500, Lennart Sorensen wrote:
> On Tue, Feb 22, 2011 at 06:28:33PM +0100, Jean Delvare wrote:
> > But embedded systems (arm, blackfin, cris) typically instantiate it
> > explicitly.
> 
> Certainly some do.  We happen to boot a single fairly generic coldfire
> kernel on multiple similar boards, with slight differences in hardware.
> The number of LM75's for example varies.  So far that had worked fine with
> nothing really having to worry about which exact board it was booting on.
> 
> > You have an interesting definition of "just works", given that you're
> > sending a patch to fix a problem you've hit ;)
> 
> Well it just worked before, using prior LM75 chips.  The new chips are
> the problem for us.
> 
> > Can't it be added? This would be the sanest approach, protecting you
> > against similar issues in the future.
> 
> Well I can certainly start looking into that.  Adding command line
> argument passing for the coldfire certainly made a lot of things nicer,
> so perhaps adding some dtb like thing could too.  Sounds like a bigger
> job though.
> 
> > A bunch of new code? I don't expect this to need much code (but I admit
> > I never wrote this - I am not into embedded systems.) Did you only try?
> 
> When you have a uclinux user space with very little in it, adding more
> code to handle detection of LM75 variants and adding them to the driver
> would be more code for sure.  Maybe not that much, but still.
> 
> > My point was that you should say "National Semiconductor LM75A" and not
> > just LM75A, to avoid confusion with other brands.
> 
> Ah, I see.  I thought the LMxx was always National Semiconductor and
> that others used different letters.
> 
> > My experience with ID registers in I2C devices is that the revision
> > rarely changes, and when it does, it often requires other driver
> > changes to properly support the new device revision. So it is
> > preferable to only support the known revisions, and add new revisions
> > as they spotted in the wild or datasheets are updated to mention them.
> 
> Well I can do that.  Either way it is more accurate detection than the
> older style LM75 detection ever had.  Once detected the new one is
> completely compatible with the old one.
> 
> > Please keep in mind that there is no standard ID registers in I2C
> > devices, neither address nor values. So it is perfectly possible for
> > other devices to match your detection routine if you aren't strict
> > enough. It is preferable to miss a detection than to have a false
> > positive and accidentally bind to a totally different device. This is
> > what I want to avoid.
> 
> Of course.  I am amazed how the old detection code has managed to not
> be a problem.
> 
> > If you still disagree, a middle ground would be to reject revision = 0
> > and only accept reasonable revisions (that is revision = 2 may happen
> > in the future, but I don't expect say revision = 10 any time soon.)
> 
> Well I will just match on the current revision for now then.
> 
> > This is certainly annoying, but you can't blame National Semiconductor
> > for this. Instead, blame yourself for still relying on automatic device
> > detection in 2011 when mechanisms to cleanly instantiate I2C devices
> > exist since mid-2008. The original LM75 was never meant to be detected,
> > it doesn't even have an ID register.
> 
> Well at least the LM75A does have an ID register, so supporting detection
> of it seems fair enough.
> 
> > Chip.
> 
> OK, that makes sense.  Easily done.
> 
> > Yes it would.
> 
> I will do that.  I hope to have an updated patch in a couple of hours.
> 
Fwiw, I have a system with TI TMP75AIDGKT (per HW spec). Detection code
doesn't work for it, since it always returns 0xff when reading registers
0x4..0x7. So the lm75 detection code is really of limited value and can
not be expected to work for all chips supported by the driver.

Here is a register dump:

root# i2cdump -y 70 0x48
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
10: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
20: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
30: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
40: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
50: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
60: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
70: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
80: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
90: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
a0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
b0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
c0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
d0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
e0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
f0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
