From: fhj-52@sbcglobal.net (Ric Johnson)
Date: Wed, 14 Jun 2006 17:45:57 +0000
Subject: [lm-sensors] Using lm_sensors for accessing SMSC EMC6W201
Message-Id: <20060614174557.84916.qmail@web81608.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613191611.80065.qmail@web81614.mail.mud.yahoo.com>
In-Reply-To: <20060613191611.80065.qmail@web81614.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

I'm still working towards getting sensor information provided correctly for
this GBT 2CEWH mobo.  I found an ap, named moodss, that can record values and
chart them once lm_sensors can be used.  It runs so I have hopes it will work
& I do not have to code something here from scratch.

Yesterday '' i2cdetect -l '' would not work. Today, currently, it does. So
here is the output that was requested :
#> i2cdetect -l
i2c-4   i2c   NVIDIA I2C Device                      Algorithm unavailable
i2c-3   i2c   NVIDIA I2C Device                      Algorithm unavailable
i2c-2   i2c   NVIDIA I2C Device                      Algorithm unavailable
i2c-1   smbus  SMBus nForce2 adapter at 5040         Non-I2C SMBus adapter
i2c-0   smbus  SMBus nForce2 adapter at 5000         Non-I2C SMBus adapter
It's 11:26:02 CDT (UTC-0500) on Wed Jun 14, week 24 in 2006.

That IS the result that has been previously listed when using i2cdetect -l.
Any ideas as to why it works sometimes but not others? 
(I suspect openSUSE config but do not know the smart place to start looking to
confirm/fix that. ...)

Also, oddly, I was  unable  to use i2cdump after first boot this AM.  After a
few minutes it started working just as it did earlier this AM before shutdown.


A brief look at logs only provides a clue as to why.
During boot, before login:
...
Jun 14 10:45:10 name kernel: i2c_adapter i2c-2: SMBus Quick command not
supported, can't probe for chips
Jun 14 10:45:10 name kernel: i2c_adapter i2c-3: SMBus Quick command not
supported, can't probe for chips
Jun 14 10:45:10 name kernel: i2c_adapter i2c-4: SMBus Quick command not
supported, can't probe for chips
...
_BUT later, after login was done @ ~10:46AM, an additional entry:
...
Jun 14 10:51:30 name kernel: i2c /dev entries driver
...
I was able to get the i2cdump at 10:53 so suspect that the above entry is
significant as to why I could not before.
Is that a "SUSE bug/freature" or something to do with the way the devices are
setup by the kernel?  
IOW, I want monitoring to begin ASAP so I can record & chart it, even w/o
login if that is possible/sensible, so do I need some mod to SUSE, kernel or
sensors?(or all of the above?)

On the subject of temperatures:
I ran a lot of dumps this AM(my yesterday) and have determined that on this
mobo, for i2c-1, 2E:
Register 26, CPU0 temperature!
Register 27, ??  - this is always the 2nd coolest temp; ~23*c to 29*c.
Register 28, CPU1 temperature!
Register 29, ??  ~27*c to 32*c all the time
Register 2a, Front temperature!( always the lowest temp )
Register 2b, Rear temperature! ( the BIOS & GBT have named it "Rear" temp )

I don't think I am going to be able to pin-down what registers 27 and 29
monitor until we can get lm_sensors working correctly so values can be
recorded & charted.  Both fluctuate, a little, as the CPUs temps go up and
down but I cannot see any correlation, if there is any, with the small dataset
that I have. ( I have hopes that those two are, respectively, the NV 2050 and
NV 2200 chipsets ... )


Thanks for listening as well as any assistance/hints that can be provided.
Philip's tip to run a dump using the suspected chip device address really
helped nail where things are located!  
[I don't why I had not done that specific command before ... suppose my
''sensors'' knowledge base was just too low. (still is..., :) ]

I have written a sensors.conf section for this device which has everything
needed except some of PWM control parameters(and of course usability with
lm_sensors...). 
I also have part of a chip doc similar to what one finds in the
/usr/share/doc/packages/sensors/chips/ for a description to be added after
compatibility is established. I am adding to it as I gather more *correct*
info.

I am investigating other ways/chips to get compatibility but have found none
so far.  If there is something specifically to look at, please inform me.


Regards,

Ric Johnson


=========
--- Philip Pokorny <ppokorny at penguincomputing.com> wrote:

> Ric Johnson wrote:
> 
> >There is no URL as GBT sent the Datasheet to me. It is PDF. I can send it
> but
> >do not have a web server at this time so cannot post it.
> >  
> >
> It would *really* help if we could see the datasheet.  How big is it?
> 
> >The DS says the "default slave adddress is 0101110b" and GBT told me they
> >"followed SMSC recommendations" ... 
> >There is a table showing 
> > "SMBUS Address[7:1] " as 0101 110b which is suppose is the same as 101110
> >binary or 2E hex.  
> >  
> >
> Yes, that's the default address.
> 
> >i2cdetect -l  returns nothing.  I am not sure why since lsmod has quite a
> few
> >"i2c*" items in it while sensors is running.
> >  
> >
> Perhaps that's a bug with i2cdetect...  We can follow up on that problem 
> later.
> 
> >#> i2cdetect 0
> >WARNING! This program can confuse your I2C bus, cause data loss and worse!
> >I will probe file /dev/i2c-0.
> >I will probe address range 0x03-0x77.
> >Continue? [Y/n]
> >     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> >00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> >10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> >20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> >30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> >40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> >50: XX XX UU UU XX XX UU UU XX XX XX XX XX XX XX XX
> >60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> >70: XX XX XX XX XX XX XX XX
> >
> >  
> >
> No, that's probably just your memory DIMM's (at 52, 53, 56, 67) (do you 
> have 4 DIMM's installed?)  Not sure what might be at address 0x08...
> 
> >I have run i2cdump 0 0x2e but the results are only "XX". Perhaps that is
> that
> >wrong command parameter/address ...
> >  
> >
> That's because there is no device at address 0x2e on bus 0.  Note the XX 
> in square 20 x e in the output above.
> 
> >Since it *looks* like i2c-1 is where all the easter eggs are hidden, I did
> a
> >dump and got all kinds of stuff:
> >  
> >
> Perfect, the output from 'i2cdetect -l' would have listed what busses 
> you have and we would have gotten around to asking you to 'i2cdetect 1' 
> and so on, but you've figured that out for yourself.  Excellent...
> 
> >#> i2cdump 1 0x2e
> >No size specified (using byte-data access)
> >WARNING! This program can confuse your I2C bus, cause data loss and worse!
> >I will probe file /dev/i2c-1, address 0x2e, mode byte
> >Continue? [Y/n]
> >     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> >00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> >10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> >20: c8 b0 bb 64 c0 b3 2d 17 31 1b 16 22 c4 0c 37 0e    ???d??-?1??"??7?
> >30: 52 0e 40 0d 1a 07 80 80 80 00 00 00 00 00 5c b1    R?@??????.....\?
> >40: 05 00 00 00 00 00 00 00 3e 00 00 ff 00 ff 00 ff    ?.......>.......
> >50: 00 ff 00 ff 00 ff 81 7f 81 7f 81 7f 81 7f 81 7f    ......??????????
> >60: 81 7f ff ff ff ff ff ff ff ff ff ff 00 00 00 ff    ??..............
> >70: 00 ff 00 ff 00 ff 00 ff 00 ff fc 3e 7e 00 00 00    ..........?>~...
> >80: e2 e2 e2 99 90 cc cc cc 00 00 80 80 80 00 00 00    ????????..???...
> >90: 23 23 23 23 23 23 64 64 64 64 64 64 44 44 44 94    ######ddddddDDD?
> >a0: 00 40 80 00 04 04 04 04 2c 2c 2c 00 0a 00 2d 2d    .@?.????,,,.?.--
> >b0: 2d 2d 2d 2d 00 00 00 00 a0 00 05 25 12 ff ff 00    ----....?.?%?...
> >c0: 00 00 00 00 7f 7f 7f 7f 7f 7f c0 00 00 00 00 00    ....???????.....
> >d0: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >e0: 00 00 c0 8a 68 00 20 00 1c 00 00 00 00 00 00 00    ..??h. .?.......
> >f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> >It's 22:24:24 CDT (UTC-0500) on Tue Jun 13, week 24 in 2006.
> >
> >OF course, that might be an eeprom or something.
> >
> No, that's probably your chip.  Go ahead and try i2cdump on one of your 
> eeproms 'i2cdump 0 0x52' and you'll see that the output is very different.
> 
> >Any ideas?
> >
> >  
> >
> Yes, but without the data sheet it's just speculation...
> 
> I would say that you appear to have 6 voltage sensors (0x20-25), and 6 
> temperature sensors (as you said previously, 0x26-2b).  I'm going to 
> guess that you have five (5) 16-bit fan speed sensors (0x2c-35).
> 
> The device ID signature registers are probably 0x3e (value 0x5c) and 
> 0x3f (value 0xb1)
> 
> The min/max limits for the voltages probably start at 0x4a through 
> 0x55.  Then the limits for the temperatures (0x56-0x61) and fan speeds 
> (0x62-0x6b).
> 
> I would guess that the rest of the registers are perhaps fan speed 
> control or some other features on the chip.  Hopefully they are 
> described in the datasheet.
> 
> If that's correct, then we just need to know what the scaling values are 
> for the voltages and the fan speed equation.  And your temperatures are:
> 
> 2d  =  45 degC
> 17  =  23 degC
> 31  =  49 degC
> 1b  =  27 degC
> 16  =  22 degC
> 22  =  34 degC
> 
> If that's right, the temperatures appear to be rather low.  Do you have this
> machine in a cooled computer room?
> 
> 
> Thanks,
> :v)
> 


