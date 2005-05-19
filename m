From: william.mcclintock@schriever.af.mil (McClintock William J Contr MCOM)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Ticket 1447 Update...Success...
Message-Id: <B8BD20F161298A42A3B513D23A28556701101F33@fsglenex3.schriever.af.mil>
List-Id: <lm-sensors.vger.kernel.org>
References: <B8BD20F161298A42A3B513D23A28556701101F2E@fsglenex3.schriever.af.mil>
In-Reply-To: <B8BD20F161298A42A3B513D23A28556701101F2E@fsglenex3.schriever.af.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This what you are looking for?

Memory in system...
Corsair DDR SDRAM 256MB P/N CMX256A-3200LL PC3200 400MHz CL2

http://www.corsairmicro.com/xms/xms_modules.html

[root@workstation1 root]# i2cdump 0 0x50
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x50, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 01 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
10: 0e 04 04 01 02 20 00 00 00 00 00 28 28 28 1e 40    ????? .....(((?@
20: 60 60 40 40 00 00 00 00 00 37 41 28 23 50 00 00    ``@@.....7A(#P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88    ...............?
40: 7f 7f 9e 00 00 00 00 00 01 43 4d 58 32 35 36 41    ???.....?CMX256A
50: 2d 33 32 30 30 4c 4c 00 00 00 00 00 00 00 00 00    -3200LL.........
60: 00 00 00 00 00 00 00 00 00 00 00 1f ff ff ff ff    ...........?....
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@workstation1 root]# i2cdump 0 0x51
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x51, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 01 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
10: 0e 04 04 01 02 20 00 00 00 00 00 28 28 28 1e 40    ????? .....(((?@
20: 60 60 40 40 00 00 00 00 00 37 41 28 23 50 00 00    ``@@.....7A(#P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88    ...............?
40: 7f 7f 9e 00 00 00 00 00 01 43 4d 58 32 35 36 41    ???.....?CMX256A
50: 2d 33 32 30 30 4c 4c 00 00 00 00 00 00 00 00 00    -3200LL.........
60: 00 00 00 00 00 00 00 00 00 00 00 1f ff ff ff ff    ...........?....
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@workstation1 root]#

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Monday, November 24, 2003 12:33 PM
To: McClintock William J Contr MCOM
Cc: sensors@stimpy.netroedge.com
Subject: Re: Ticket 1447 Update...Success...


> Just wanted to drop a note...I had an issue documented on ticket 1447.
> The CVS build v2.8.2 has resolved the issue.  I just wanted to let you
> al know of my success on getting this built with this hardware...

Great :)

On the ticket, I could see that the eeprom module reports an unknown
type. What kind of memory do you have? Could you please provide a dump?
Which capacity?
("i2cdump 0 0x50" and "i2cdump 0 0x51").

> Thanks again...

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
