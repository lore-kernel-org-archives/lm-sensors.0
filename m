From: gene.heskett@verizon.net (Gene Heskett)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <200308030411.46632.gene.heskett@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday 02 August 2003 23:31, Mark M. Hoffman wrote:
>Hi Gene:
>
>* Gene Heskett <gene.heskett@verizon.net> [2003-08-02 20:42:50 
-0400]:
>> On Saturday 02 August 2003 17:17, Jean Delvare wrote:
>> >I suggest you start from the very beginning with the separate
>> >compilation option. This is the way I personnally use, and the
>> > one I recommend too.
>> >
>> >You need to have a kernel tree matching your running kernel.
>>
>> This has been one of the sore spots with me, this requirement that
>> I make a new kernel, and sensors doesn't work because its
>> referenceing the one that running, not the one thats building
>> courtesy of the use of the uname facility to discover the version
>> numbers.  I'd much rather it reached back into /usr/src/linux to
>> discover this since that link *will* be valid for the kernel under
>> construction.
>
>Having a kernel tree that matches the running kernel is just the
>easiest way for our users to get it right.  However, if you want
>to build against some other kernel just point the "LINUX :=" line
>of the i2c and lm_sensors2 top-level makefiles to whatever kernel
>you want to build against.  Then continue with Jean's instructions.

I see.  I think.  So to build against the kernel being built, I would 
make this line read
LINUX :=/usr/src/linux
since this link will be valid for the kernel being built.

>> > This
>> > kernel must not have any I2C element hard-compiled. If it has
>> > some as modules, it's OK, they'll be overriden.
>> >
>> >Then, install i2c-2.8.0. Don't patch your kernel, just compile
>> >separately. It's as easy as: make, make install.
>> >
>> >Then, install lm_sensors-2.8.0. Same as for i2c, don't patch your
>> >kernel, compile separately. It's as easy as: make, make install,
>> >ldconfig.

I did this with 2.7.0 last night after disabling lm_sensors with 
chkconfig, and commenting out anything related in rc.local.

Then I ran sensors-detect,  Everything worked except it detected an 
lm75 instead of an adm1021 for the temp stuffs.  As I already had an 
old line to bring it in with an option adm1021 line in modules.conf 
so it would ignore one potential address, canceling the lm75 and 
re-enabling the adm1021 modload in rc.local made everything work 
again.

>Also note it's important to follow this order - don't try to cheat
>by building lm_sensors before *installing* i2c.
>
>> ldconfig?  Something tells me I really do need to rtfm better than
>> I have recently...
>
>This just tells your system to update its list of where to find
>shared libraries.  There will be notes about this at the end of
>the second "make install" - read them and you should be all set.

Amanda is doing her nightly thing atm, but I'll try this with the 
2.8.0 versions in the morning.

But, I think I've got some hardware problems, and suspect they are 
only going to be cured by replacing my athlon cpu with a barton cored 
unit, this DX-1600 has been running at 170F or more, .100 volts low 
on its core vcc for going on 3 years now, and several of my reboots 
hung either at the post stage just before the memory scan, and once 
it spontainously rebooted when the viapro module was modprobed.  Gawd 
I hate flaky hardware...  I have a friend with a barton cored athlon 
DX-2400 that rarely exceeds 120F, and then only when doing mpeg2 
smunching.

Not to mention the northbridge fan has only run maybe 10% of the time 
since the mobo was new, what a POS.  I have a much taller heat sink 
for it, fanless, but I'd need to get up close and personal to put it 
on, and the tower is trapped under the desk, its 1/2" taller then the 
steel angle that re-inforces the front edge of that home-made desk.  
I really need to get both of them out from under and take them to an 
air hose, the old 500 towers psu is pretty well plugged with dust 
bunnies.

-- 
Cheers Mark, and thanks for the clue, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
