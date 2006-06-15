From: fhj-52@sbcglobal.net (Ric Johnson)
Date: Thu, 15 Jun 2006 03:33:13 +0000
Subject: [lm-sensors] Using lm_sensors for accessing SMSC EMC6W201
Message-Id: <20060615033313.36517.qmail@web81608.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613191611.80065.qmail@web81614.mail.mud.yahoo.com>
In-Reply-To: <20060613191611.80065.qmail@web81614.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

Voltages

I am pretty sure that the +5VDC as well as the +12VDC lines are not monitored
on this chip and this mobo.  Both of those values, as well as the 5VStby and
Vbat readings, from the output of the 8712F readings look reasonable. The
value for the 5VDC here is way off( but that might be the way I got the value
).

Here goes:

The reading registers(hex), names, nominal values and what each is:

20, 2.5VDC, 	2.5 VDC nominal, for ??? on ...???...
21, V1.5P1,  	1.5 VDC nominal, for CPU0
22, VCC, 	3.3 VDC nominal, for chip, or line or VTR ...?... 
23, +5V, 	5.0 VDC nominal, for ...???...
24, 1.5VDC,  	1.5 VDC nominal, for 1.5V on ...???...
25, V1.5P2,  	1.5 VDC nominal, for CPU1

The DS info on Analog Voltages does not have much that makes a lot of sense(to
me) but ithink I figured out that what they were trying to say is that to get
the Voltage value:
take the read value, convert to decimal, multiply by the factor and add
0.5*factor to the result;  one then has the closest truth to the actual value.

I saw no info about the accuracy/tolerance(yet) but if it is like the
temps(+/- 3*c), the above method will provide as good a result as an end user
should expect.

The "factor" is the scaling factor obtained from a chart.

Each voltage I/O has it's own "3/4" scale/factor:  
5VDC is 0.026
3.3VDC is  0.0172
1.5VDC is  0.008
2.5VDC is  0.013

But there is a range too(see chart) so multiplying by the factor is not going
to give the best value to report. It will be on the low end so adding
1/2*factor to the result of factor*decimal coversion of hex reading will give
a closer to truth value.  There's a mathematical term for that which I am sure
to rem' just _after_ I press the send button. :)

My calcs:
Readings same as from yesterday _and_ just now(no change)
20  21  22  23  24  25  Registers
c8  b0  bb  64  c0  b3  hex values 
200 176 187 100 192 179 decimal equiv's

Register 20 is the 2.5VDC reading output value which has no use unless GBT has
connected it to something that uses 2.5V.  I don't know what that could be.
200*0.013=2.6
...whatever it is, it reads ~ 2.6 + 0.0065 => 2.606VDC

Register 21 is the 1.5VDC P1(CPU0 core volts) reading output value
176*0.008 = 1.408  => 1.412VDC
Register 25 is the 1.5VDC P2(CPU1 core volts) reading output value
179*0.008 = 1.432 => 1.436VDC
Those are very close to what they should be(1.35 - 1.40) _and_
considering that GBT OVERCLOCKS this mobo, those are probably dead-on.  IIRC,
nVidia's nTune showed the voltage as > 1.4VDC as well as DDR at 402, HT @
2010, etc.

Register 22 is the 3.3VDC VCC reading output value
187*0.0172 = 3.2164  => 3.225VDC
That's close ... close enuf to be a real value considering I have a little
problem with the PSU, or so it seems(12VDC runs low too).  That is one of the
reasons we need to get lm_sensors working correctly for this chip.  ...

Register 23 is the 5VDC reading output value
100*0.026 = 2.6  => ridiculous!
... that cannot be correct!!
Perhaps GBT does not use the 6W201 for 5V voltage either ... ???
Interestingly, the 8712F obtained value is 4.97VDC which is prbly correct.

Register 24 is the nominal 1.5V value but, really, we do not know what it is
so don't care.


What they (SMSC) say:
The chip updates the registers at least 4 times per second. 

The device compares the inputs(voltages) against a known (internal) reference
source ... scales the inputs internally " such that the correct value refers
to 3/4 scale or 192 decimal."

" Voltages in the Registers are presented at 3/4 full scale for the nominal
voltage, meaning that at nominal voltage, each register will read c0h. "

...iDontHaveaFrigginClue what that *really* means; am pretty sure the editor
cut the sentences that would have made that make sense to non bit-byters. It
does not mean the value in the register is 75% of the full correct value.

There's a ADC Voltage Conversion chart on PDF page 145 of the DS(p133 of doc).


What I get here by using the method above agrees with what I know to be true
but it could be coincedence.  I do not know of any way to test/verify it.  The
BIOS HW readings do not show the CPU voltages. The 3.3VDC is always a little
bit low. If the method is wrong or there is a better way, I would surely like
to know.

Please do not think that I am going to hunt you down and hurt you for
correcting me.  I would never do that.(
http://regmedia.co.uk/2001/09/12/joke_alert.gif ) :)

...

Ric
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


Ric
...
Success
" He has achieved success who has lived well, laughed often, and loved much; who has enjoyed the trust of pure women, the respect of intelligent men and the love of little children; who has filled his niche and accomplished his task; who has left the world better than he found it whether by an improved poppy, a perfect poem, or a rescued soul; who has never lacked appreciation of Earth's beauty or failed to express it; who has always looked for the best in others and given them the best he had; whose life was an inspiration; whose memory a benediction. "
- Bessie A. Stanley( Published in Lincoln Sentinel, Nov. 30, 1905 )

