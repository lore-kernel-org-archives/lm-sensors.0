From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <1088757772.3056.23.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2004-07-02 at 10:09, Jean Delvare wrote:

> Andras, could you please provide a dump of your chip?
> i2cdump 1 0x48 w

# i2cdump 1 0x48 w
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x48, mode word
  You have five seconds to reconsider and press CTRL-C!

     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: 0802 8800 2000 0005 a000 0004 0004 0004
08: 0802 8800 2000 0005 a000 0004 0004 0004
10: 0802 8800 2000 0005 a000 0004 0004 0004
18: 0802 8800 2000 0005 a000 0004 0004 0004
20: 0802 8800 2000 0005 a000 0004 0004 0004
28: 0802 8800 2000 0005 a000 0004 0004 0004
30: 0802 8800 2000 0005 a000 0004 0004 0004
38: 0802 8800 2000 0005 a000 0004 0004 0004
40: 0802 8800 2000 0005 a000 0004 0004 0004
48: 0802 8800 2000 0005 a000 0004 0004 0004
50: 0802 8800 2000 0005 a000 0004 0004 0004
58: 0802 8800 2000 0005 a000 0004 0004 0004
60: 0802 8800 2000 0005 a000 0004 0004 0004
68: 0802 8800 2000 0005 a000 0004 0004 0004
70: 0802 8800 2000 0005 a000 0004 0004 0004
78: 0802 8800 2000 0005 a000 0004 0004 0004
80: 0802 8800 2000 0005 a000 0004 0004 0004
88: 0802 8800 2000 0005 a000 0004 0004 0004
90: 0802 8800 2000 0005 a000 0004 0004 0004
98: 0802 8800 2000 0005 a000 0004 0004 0004
a0: 0802 8800 2000 0005 a000 0004 0004 0004
a8: 0802 8800 2000 0005 a000 0004 0004 0004
b0: 0802 8800 2000 0005 a000 0004 0004 0004
b8: 0802 8800 2000 0005 a000 0004 0004 0004
c0: 0802 8800 2000 0005 a000 0004 0004 0004
c8: 0802 8800 2000 0005 a000 0004 0004 0004
d0: 0802 8800 2000 0005 a000 0004 0004 0004
d8: 0802 8800 2000 0005 a000 0004 0004 0004
e0: 0802 8800 2000 0005 a000 0004 0004 0004
e8: 0802 8800 2000 0005 a000 0004 0004 0004
f0: 0802 8800 2000 0005 a000 0004 0004 0004
f8: 0802 8800 2000 0005 a000 0004 0004 0004

While dumping, I got this in the logs:

i2c_adapter i2c-1: bus error in state address
i2c_adapter i2c-1: not master in state address

> i2cdump 1 0x48

# i2cdump 1 0x48
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x48, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 02 XX 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    ?X.X.?X?X..X.?X?
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

While dumping, I got a lot of these in the logs:

i2c_adapter i2c-1: bus error in state address

> I wonder if unused addresses (0x4-0x7 on LM75, 0x6-0x7 on LM77) will
> always return the value of the last existing register (0x3 and 0x05,
> respectively), or those of the previously read register.

It's the previously read register on the LM77.

# ./i2clm77
reading from LM77 at 0x48 on /dev/i2c-1

T=         32.50
T_hyst=    2.00
T_6=       2.00
T_7=       2.00
T_crit=    80.00
T_low=     10.00
T_6=       10.00
T_7=       10.00
T_high=    64.00
T_6=       64.00
T_7=       64.00

status=    0x0 crit/high/low
config=    0x0

> Ah, you are using a monolithic kernel? This is interesting. We are almost
> never doing, and had several complaints about it not working properly
> (but that was long time ago). How is it going for you?

I'm using a monolithic kernel because I don't want modules on this
embedded system. It's working fine (as you can see), apart from the
minor inconvenience that I have to recompile it hundred times a day :-)

> Yes, you're right, we should keep silent if /proc/modules does not
> exist. Care to provide a patch that does that? We may even remember and
> never propose the user to try and load a module after that.

--- sensors-detect.old  2004-07-01 23:23:09.000000000 +0200
+++ sensors-detect      2004-07-02 10:34:29.000000000 +0200
@@ -1844,7 +1844,7 @@

 sub initialize_modules_list
 {
-  open INPUTFILE, "/proc/modules" or die "Can't access /proc/modules!";
+  open INPUTFILE, "/proc/modules" or return;
   while (<INPUTFILE>) {
     tr/_/-/;
     $modules_list{$1} = 1 if m/^(\S*)/;

The rest is so much based on the modules that I see no point in
rewriting the whole for those few of us who use a monolithic kernel.
And it's working fine, anyway.

Thanks,
Andras

