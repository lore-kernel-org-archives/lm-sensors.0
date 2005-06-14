From: sukhdeep@gmail.com (Sukhdeep Johar)
Date: Tue, 14 Jun 2005 08:09:47 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <2ef564dc05061323084131d795@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks Jean ! 

Our motherboard is a custom one (used for our(Symbol) wireless switches )
They are similar to the kt400 is what i know. 

Here is the i2cdump :
WS5K #i2cdump -y 0 0x29
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: 71 5e ca bc c5 9d ca 1b ff 4c 2d 72 68 72 68 d8    q^??????.L-rhrh?
30: c4 c3 b0 d9 b2 31 15 3b 31 58 02 00 24 02 00 00    ?????1?;1X?.$?..
40: 01 00 10 00 00 00 00 56 29 02 32 44 41 95 00 a3    ?.?....V)?2DA?.?
50: ff ff 80 ff ff ff 00 00 30 70 ff ff 11 00 ff ff    ..?.....0p..?...
60: 71 5e cb bc c4 9c ca 1b ff 4b 2e 72 68 72 68 d8    q^??????.K.rhrh?
70: c4 c3 b0 d9 b2 31 15 3b 31 58 02 00 24 02 00 00    ?????1?;1X?.$?..
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 71 5e cb bb c4 9c ca 1b ff 4c 2d 72 68 72 68 d8    q^??????.L-rhrh?
b0: c4 c3 b0 d9 b2 31 15 3b 31 58 02 00 24 02 00 00    ?????1?;1X?.$?..
c0: 01 00 10 00 00 00 00 56 29 02 32 44 41 95 00 a3    ?.?....V)?2DA?.?
d0: ff ff 80 ff ff ff 00 00 30 70 ff ff 11 00 ff ff    ..?.....0p..?...
e0: 71 5e ca bc c4 9d ca 1b ff 4c 2d 72 68 72 68 d8    q^??????.L-rhrh?
f0: c4 c3 b0 d9 b2 31 15 3b 31 58 02 00 24 02 00 00    ?????1?;1X?.$?..

WS5K #i2cdump -y 0 0x2d
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: 53 00 00 bb 00 00 00 7f 2e 2d 2f 00 00 00 00 d8    S..?...?.-/....?
30: c4 c3 b0 d9 b2 31 15 3b 31 08 40 40 00 00 00 00    ?????1?;1?@@....
40: 01 20 00 00 00 00 00 5f 2d 03 01 44 41 95 00 a3    ? ....._-??DA?.?
50: ff ff 00 ff ff ff 00 00 30 70 ff ff 11 00 ff ff    ........0p..?...
60: 53 00 00 bc 00 00 00 7f 2e 2d 2e 00 00 00 00 d8    S..?...?.-.....?
70: c4 c3 b0 d9 b2 31 15 3b 31 08 40 40 00 00 00 00    ?????1?;1?@@....
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 53 00 00 bb 00 00 00 7f 2e 2e 2e 00 00 00 00 d8    S..?...?.......?
b0: c4 c3 b0 d9 b2 31 15 3b 31 08 40 40 00 00 00 00    ?????1?;1?@@....
c0: 01 20 00 00 00 00 00 5f 2d 03 01 44 41 95 00 a3    ? ....._-??DA?.?
d0: ff ff 00 ff ff ff 00 00 30 70 ff ff 11 00 ff ff    ........0p..?...
e0: 53 00 00 bb 00 00 00 7f 2f 2d 2e 00 00 00 00 d8    S..?...?/-.....?
f0: c4 c3 b0 d9 b2 31 15 3b 31 08 40 40 00 00 00 00    ?????1?;1?@@....

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

The warning went after loading with :
        #modprobe w83781d init=0 force_subclients=0,0x29,0x4a,0x4b 

But, I now see that the sensors command gives _TWO_ results : 
WS5K #sensors
w83782d-i2c-0-29
Adapter: SMBus Via Pro adapter at 0400
VCore 1:   +1.81 V  (min =  +1.66 V, max =  +1.82 V)
VCore 2:   +1.50 V  (min =  +1.66 V, max =  +1.82 V)
+3.3V:     +3.23 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.06 V  (min =  +4.74 V, max =  +5.24 V)
+12V:     +11.97 V  (min = +10.83 V, max = +13.19 V)
-12V:      -2.01 V  (min = -13.16 V, max = -10.90 V)
-5V:       +2.43 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.02 V  (min =  +4.74 V, max =  +5.24 V)
VBaT:      +2.13 V  (min =  +2.40 V, max =  +3.60 V)
My fan:      0 RPM  (min =   -1 RPM, div = 2)
fan2:     9000 RPM  (min = 18750 RPM, div = 2)
fan3:     14673 RPM  (min = 337500 RPM, div = 2)
temp1:       +28 C  (high =   +88 C, hyst =    +2 C)   sensor = thermistor      

temp2:     +70.5 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor      
temp3:     -48.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor      
vid:      +1.750 V  (VRM Version 8.2)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled


w83782d-i2c-0-2d
Adapter: SMBus Via Pro adapter at 0400
VCore 1:   +1.33 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:   +0.00 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +0.00 V  (min =  +2.82 V, max =  +3.79 V)
+5V:       +5.02 V  (min =  +3.49 V, max =  +0.00 V)
+12V:      +0.00 V  (min =  +4.14 V, max =  +0.00 V)
-12V:     -14.91 V  (min =  -4.37 V, max = -14.91 V)
-5V:       -7.71 V  (min =  -7.71 V, max =  +2.24 V)
V5SB:      +0.00 V  (min =  +0.22 V, max =  +0.50 V)
VBaT:      +0.00 V  (min =  +0.13 V, max =  +0.00 V)
My fan:   14361 RPM  (min = 10546 RPM, div = 2)
fan2:     14673 RPM  (min =   -1 RPM, div = 2)
fan3:     14673 RPM  (min =   -1 RPM, div = 2)
temp1:      +127 C  (high =    +8 C, hyst =   +64 C)   sensor = thermistor      
temp2:     +79.5 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor      
temp3:     +63.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor      
vid:      +0.000 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm disabled
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
The first one is what I was seeing earlier. Only temp3 is now -49C
in place of 16C.
And if you see the first line of output - w83782d-i2c-0-29 
I guess, it was actually being loaded at 0x29 only.

The second output seems quite vague.

I also see two directories created in the /proc - 

WS5K #cat /proc/sys/dev/sensors/
chips             w83782d-i2c-0-29  w83782d-i2c-0-2d

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Can you make out what's going wrong ?

regards,
Sukhdeep

On 6/13/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Sukhdeep,
> 
> > The Motherbowrd is from VIAPRO, it's similar to kt400.
> 
> VIA Pro / KT400 is the name of the South Bridge. This doesn't tell me
> the motherboard itself is. Have you no idea? dmidecode [1] may help.
> 
> [1] http://www.nongnu.org/dmidecode/
> 
> > Client found at address 0x29
> > (...)
> > Probing for `Winbond W83782D'... Success!
> >     (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
> > (...)
> > Client found at address 0x2d
> > (...)
> > Probing for `Winbond W83782D'... Success!
> >     (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
> 
> Wow. So it does actually find *two* W83782D chips, which share the same
> subclient addresses. This is no good.
> 
> Can you please provide the output of the following commands:
> i2cdump -y 0 0x29
> i2cdump -y 0 0x2d
> 
> (I assume this is on i2c bus 0; if not, put the correct ID.)
> 
> > Probing for `Winbond W83697HF Super IO Sensors'
> >   Success... but not activated
> 
> And the Super-I/O is there. I suspect that the W83697F has the same ID,
> so we cannot differenciate, but the W83697F has no hardware monitoring
> logical device - which would explain why it is listed as 'not activated"
> here.
> 
> So... the correct modprobe line for you would be:
> 
> modprobe w83781d force_subclient=0,0x29,0x4a,0x4b
> 
> Try it :)
> 
> --
> Jean Delvare
> 


-- 
Everybody has the right to be stupid..... But some abuse the privilege
