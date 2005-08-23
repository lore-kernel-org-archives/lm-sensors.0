From: bmeier@infovia.com.ar (Beat Meier)
Date: Tue, 23 Aug 2005 21:44:46 +0000
Subject: [lm-sensors] lm77 driver locks up with kernel-2.6.12
Message-Id: <430B7C64.7060301@infovia.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
References: <43027C3E.6020309@infovia.com.ar>
In-Reply-To: <43027C3E.6020309@infovia.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:

>Hi again,
>
>It seems is a definetly combination of HW and bus driver problems.
>
>Now a little excercise:
>
>1) cold boot the device
>2) modprobe scx200_acb
>3) modprobe i2c-dev
>3) i2cdump -y 0 0x4b b
> Try several times dumping in byte mode. Will the transfer be delayted too? I mean does the driver also produce the messages to syslog while in bytemode?
>
>  
>
BTW: Normaly i2c-dev is not running I've inserted it but there is no 
difference in the output with or without this driver.

After an byte access i.e.

woc4:~# i2cdump -y 0 0x48 b

the temperature is wrong but only the temperature i.e.
  current:4095 low:10 lowHyst:12 high:64 highHist:62 critical:80 
criticalHyst:78
"value 4095 is in fact 4095500 but was divided by 1000"
reading temperature again gives the right value
  current:43 low:10 lowHyst:12 high:64 highHist:62 critical:80 
criticalHyst:78
or if I do a i2cdump -y 0 0x48 w the first read value at 00/0 is XXXX 
which seems
to indicate the same problem (see below output)
After an word access not! (This is always when lm77 is still in good case)

If read in the lm77 manual that the pointer to the register is latched.
Can this be the problem that sometimes the pointer is not explicitly set
(because the drivers knows that it has accessed last time the same
and will not set the pointer?)

This could be the problem because I do not read only temperature but
also limits and hyst. and this are in other registers ...

Ok in fact I do not have any idea whats going on with driver nor
with i2c ...

woc4:~# i2cdump -y 0 0x48 b;i2cdump -y 0 0x48 w;
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 02 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
10: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
20: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
30: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
40: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
50: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
60: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
70: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
80: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
90: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
a0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
b0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
c0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
d0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
e0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
f0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?

     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: XXXX 8000 2000 0005 a000 0004 0004 0004
08: c002 c000 2000 0005 a000 0004 0004 0004
10: c002 c000 2000 0005 a000 0004 0004 0004
18: c002 c000 2000 0005 a000 0004 0004 0004
20: c002 c000 2000 0005 a000 0004 0004 0004
28: c002 c000 2000 0005 a000 0004 0004 0004
30: c002 c000 2000 0005 a000 0004 0004 0004
38: c002 c000 2000 0005 a000 0004 0004 0004
40: c002 c000 2000 0005 a000 0004 0004 0004
48: c002 c000 2000 0005 a000 0004 0004 0004
50: c002 c000 2000 0005 a000 0004 0004 0004
58: c002 c000 2000 0005 a000 0004 0004 0004
60: c002 c000 2000 0005 a000 0004 0004 0004
68: c002 c000 2000 0005 a000 0004 0004 0004
70: c002 c000 2000 0005 a000 0004 0004 0004
78: c002 c000 2000 0005 a000 0004 0004 0004
80: c002 c000 2000 0005 a000 0004 0004 0004
88: c002 c000 2000 0005 a000 0004 0004 0004
90: c002 c000 2000 0005 a000 0004 0004 0004
98: c002 c000 2000 0005 a000 0004 0004 0004
a0: c002 c000 2000 0005 a000 0004 0004 0004
a8: c002 c000 2000 0005 a000 0004 0004 0004
b0: c002 c000 2000 0005 a000 0004 0004 0004
b8: c002 c000 2000 0005 a000 0004 0004 0004
c0: c002 c000 2000 0005 a000 0004 0004 0004
c8: c002 c000 2000 0005 a000 0004 0004 0004
d0: c002 c000 2000 0005 a000 0004 0004 0004
d8: c002 c000 2000 0005 a000 0004 0004 0004
e0: c002 c000 2000 0005 a000 0004 0004 0004
e8: c002 c000 2000 0005 a000 0004 0004 0004
f0: c002 c000 2000 0005 a000 0004 0004 0004
f8: c002 c000 2000 0005 a000 0004 0004 0004

