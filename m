From: motupota@yahoo.com (Jack Yindo)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: lm_sensors device request
Message-Id: <20040503182149.47093.qmail@web60801.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040502190113.75974.qmail@web60802.mail.yahoo.com>
In-Reply-To: <20040502190113.75974.qmail@web60802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, I tried what you suggested but sensors returns
error: can't get temperature data!
Below and attached is a full dump, here is what I did
sensors-detect
modprobe lm75 force=0,0x48
I don't have any modules looked up at boot time, did I
do anything wrong, btw I loaded the eeprom driver and
it read my ram chips fine.


trainmaster:~# i2cdump 0 0x48 
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus,
cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x48, mode
byte
  You have five seconds to reconsider and press
CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f   
0123456789abcdef
00: 13 80 4b 50 XX XX XX XX XX XX XX XX XX XX XX XX   
??KPXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX   
XXXXXXXXXXXXXXXX

--- Jean Delvare <khali@linux-fr.org> wrote:
> > I was wondering if you guys could add support for
> the
> > Texas Instruments tmp100, since I have no
> progamming
> > skills in c :)
> > The chip doesn't have an id, here's a dump
> > SMBus Register :$48
> > >   $00: $12   $01: $80   $02: $4B   $03: $50  
> $04:
> > > $00  $05: $00   $06: $00
> > > $07: $00
> > the temp is at the first value 12, in hex, so in
> dec
> > 18 C.  I looked at the code for the lm75 and
> really
> > had no idea what I was looking at, it shouldn't be
> to
> > hard to add though, I think.
> 
> This chip is actually an enhanced LM75 chip, fully
> compatible, according
> to the datasheet. Just force the lm75 to load using
> the force parameter
> (modprobe lm75 force=X,0xYY where X is the bus
> number and 0xYY is the
> chip's address on that bus.
> 
> I'm not sure we'll bother implementing a separate
> driver. Which system
> have found that device in?
> 
> If you want us to add support to sensors-detect for
> this chip, please
> provide the full output of i2cdump for your chip.
> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/



	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
-------------- next part --------------
trainmaster:~# i2cdump 0 0x48
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x48, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 13 80 4b 50 XX XX XX XX XX XX XX XX XX XX XX XX    ??KPXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
