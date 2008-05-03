From: achim <achim@ag-web.biz>
Date: Sat, 03 May 2008 20:30:46 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <1209846646.3291.18.camel@debian-9850.ag-home.muc>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Am Samstag, den 03.05.2008, 21:27 +0200 schrieb Jean Delvare:
> On Sat, 3 May 2008 21:14:48 +0200, Jean Delvare wrote:
> > On Sat, 03 May 2008 20:10:23 +0200, achim wrote:
> > > ---------------------------- Output ---------------------------------
> > > debian-9850:/home/achim# i2cdetect 0
> > > WARNING! This program can confuse your I2C bus, cause data loss and
> > > worse!
> > > I will probe file /dev/i2c-0.
> > > I will probe address range 0x03-0x77.
> > > Continue? [Y/n] 
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > 00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
> > > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> > > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e -- 
> > > 30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- -- 
> > > 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4e -- 
> > > 50: -- -- 52 53 -- -- -- 57 -- -- -- -- -- -- -- -- 
> > > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 6e -- 
> > > 70: 70 -- -- -- -- -- -- --                         
> > > debian-9850:/home/achim# i2cdetect -l
> > > i2c-0	smbus     	SMBus PIIX4 adapter at 0b00     	SMBus adapter
> > > ﻿---------------------------- Output ---------------------------------  
> > 
> > Looks a lot like that older bug report I mentioned where probing
> > address 0x2e rebooted the machine. Probably designed by the same
> > person, using the same or similar chip.
> > 
> > > 
> > > I'll try i2cdump 0 0x2e now and will also try the other adresses to
> > > track down the problem.   
> > 
> > I expect i2cdump 0 0x2e will freeze your system if not worse. Most
> > likely, sensors-detect would complete if you skipped address 0x2e on
> > SMBus probe. At least that was the case for the other bug report.
> 
> In fact I would be more interested in a dump of 0x4e. The other report
> had a chip there too, I wonder if it could be the same chip as the one
> at 0x2e (and maybe 0x6e? The other report didn't have that.) If we
> could identify the device by reading from 0x4e, we could skip the probe
> of 0x2e and that would hopefully solve the problem. But this will be
> very difficult to identify the device as long as we don't know what
> device it is. That's where the help of DFI or Sapphire would be
> valuable.
> 
I tried the dump of 0x2e and the system froze. I'm glad it boot's
without problems with the X2 cpu.
However I could make a dump of 0x4e and 0x6e.
﻿﻿------------------------------------------------------------------------
i2cdump 0 0x4e
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x4e, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 02 00 00 00 3f 00 00 00 00 00 00 00 00 00 00 00    ?...?...........
10: 00 00 ff 0f 00 00 00 00 00 00 00 00 00 00 00 00    ...?............
20: 00 00 00 00 00 00 00 00 83 12 12 28 00 00 00 00    ........???(....
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
﻿------------------------------------------------------------------------
#i2cdump 0 0x6e
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x6e, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
10: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
20: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
30: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
40: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
50: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
60: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
70: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
80: 07 ff 00 40 31 43 07 00 00 00 80 00 00 00 00 dd    ?..@1C?...?....?
90: dd dd dd dd dd dd dd dd dd dd dd dd dd dd XX XX    ??????????????XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
﻿------------------------------------------------------------------------

﻿I spotted one odd thin. As i ran the dump of 0x6e the first time it
stuck for a few seconds at around the line starting with 90.
since then both dumps look like this:

------------------------------------------------------------------------
debian-9850:/home/achim# i2cdump 0 0x4e 
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x4e, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
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
debian-9850:/home/achim# i2cdump 0 0x6e 
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x6e, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
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
﻿------------------------------------------------------------------------

I'll try a different version of the Sapphire bios now and then the DFI
bios.
I like overclocking and a dead cpu is something i estimate every now and
then due to that. Phenoms however tend to stop working more or less out
of the blue, in many cases the systems freeze after starting tools like
everest, speedfan, sandra or even cpu-z. Sometimes a bios reflash helps
sometimes the cpu is non functional afterwards. Having that io access
problem tracked down is really exciting and I appreciate your support.

achim~


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
