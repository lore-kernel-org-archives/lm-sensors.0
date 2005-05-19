From: jlanger@zigweb.de (Julien Langer)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Ticket 1700: lm99 on nvidia board doesn't work
Message-Id: <1087848479.4295.8.camel@moeff>
List-Id: <lm-sensors.vger.kernel.org>
References: <1087846585.2369.85.camel@moeff>
In-Reply-To: <1087846585.2369.85.camel@moeff>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mo, 2004-06-21 at 21:55, Jean Delvare wrote:

> This doesn't mean that this is an LM99. You have a chip at address 0x38
> on bus 2 and two at addresses 0x20 and 0x21 on bus 0. These are not
> typical addresses for hardware monitoring chips (especially not 0x38)
> but who knows?
> 
> You may want to dump the chips contents for us to have a look, using
> i2cdump.

ok here are the dumps
The chips on bus 0 cannot be probed... I get a lot of those bailout
error messages in dmesg

  Installed I2C busses:
    i2c-3       unknown         NVIDIA display adapter bus 0         
Algorithm unavailable
    i2c-2       unknown         NVIDIA display adapter bus 1           
Algorithm unavailable
    i2c-1       unknown         NVIDIA display adapter bus 2           
Algorithm unavailable
    i2c-0       dummy           ISA main adapter                       
ISA bus algorithm

root@pts12[/home/julien]# i2cdump 3 0x20
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-3, address 0x20, mode byte
  You have five seconds to reconsider and press CTRL-C!

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
root@pts12[/home/julien]# i2cdump 3 0x21
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-3, address 0x21, mode byte
  You have five seconds to reconsider and press CTRL-C!

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
root@pts12[/home/julien]# i2cdump 1 0x38
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x38, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
10: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
20: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
30: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
40: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
50: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
60: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
70: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
80: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
90: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
a0: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
b0: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
c0: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
d0: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
e0: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...
f0: 01 00 06 00 00 00 14 c8 34 82 90 00 89 00 00 00    ?.?...??4??.?...


