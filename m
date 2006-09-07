From: michael@walle.cc (Michael Walle)
Date: Thu, 07 Sep 2006 21:12:24 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060907211224.GA16920@thanatos.lan.walle.cc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek <r.marek at sh.cvut.cz> schrieb am Thu, Sep 07, 2006 at 09:34:35PM +0200:
> >>-    Chip        #vin    #fan    #pwm    #temp   chip_id    man_id
> >>-    w83627ehf   10      5       4       3       0x88,0xa1  0x5ca3
> >>+    Chip        #vin    #fan    #pwm    #temp  sio_ID & 0xfff0 chip_id 
> >>mfg_id
> >>+    w83627ehf   10      5       4       3      0x8860          0xa1    
> >>0x5ca3
> >>+    w83627dhg    9      5       4       3      0xa020          0xc1    
> >>0x5ca3
> >> */
> >
> >As explained above, chip_id may also be 0x88 for early W83627EHFs.
> >
> >I also note that our sensors-detect script was looking for chip_id =
> >0xa2 for the W83627DHG. Don't know where this value comes from. Rudolf?
> 
> Hi all,
> 
> I'm back to my mail. Bad news is that I dont know where I got 0xa2. I check 
> all docs I had and it is not there. I'm sorry I can't explain where it 
> comes from.
> 
> MIchael, or whoever with the DHG chip please:
> 
> Please unload the driver and do:
> 
> isaset -y 0x295 0x296 0x4e 0
> isadump -y 0x295 0x296

Hi,

here is it:

thanatos mw # isaset -y 0x295 0x296 0x4e 0
thanatos mw # isadump -y 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 9b 04 4b 35 55 42 13 9b 4b 9b 01 3c 3c 0a 05 
10: 04 ff 30 00 00 01 01 3c 43 17 00 00 ff ff ff c7 
20: 96 e3 cc cb b8 c6 c1 27 ff 3b ff da 00 a0 94 78 
30: 90 11 82 c0 ca f0 99 b0 80 09 a6 44 39 48 b4 ff 
40: 03 de 2b de ff ff 00 15 2d 00 20 44 18 95 00 a3 
50: ff ff 00 ff ff ff 00 80 c1 64 ff ff 19 44 04 05 
60: 01 7f 00 00 01 01 3c ff 12 ff 01 ff ff ff ff ff 
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: 04 9b 04 4b 35 55 42 13 9b 4b 9b 01 3c 3c 0a 05 
90: 04 ff 30 00 00 01 01 3c 43 17 00 00 ff ff ff c7 
a0: 96 e3 cc cb b8 c6 c1 27 ff 3b ff da 00 a0 94 78 
b0: 90 11 82 c0 ca f0 99 b0 80 09 a6 44 39 48 b4 ff 
c0: 03 00 00 de ff ff 00 15 2d 00 20 44 18 95 00 a3 
d0: ff ff 00 ff ff ff 00 80 c1 64 ff ff 19 44 04 05 
e0: 01 7f 00 00 01 01 3c ff 12 ff 01 ff ff ff ff ff 
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

-- 
Mit freundlichen Gr??en,
 Michael Walle

In den Rohrwiesen 1a
66440 Blieskastel
michael at walle.cc

---
Don't cry because it is over, smile because it happened.



