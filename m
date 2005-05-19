From: destri@mib.infn.it (Claudio Destri)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: help?
Message-Id: <Pine.LNX.4.44.0303010052370.24236-100000@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0302252341500.5703-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0302252341500.5703-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 28 Feb 2003, Jean Delvare wrote:

> 
> [PLEASE REPLY TO THE LIST, NOT TO ME ALONE]
> 

Sorry!

> As far as I know, the "BIOS" does just what we do with i2c/lm_sensors
> for Linux. I don't think there's anything like "reading data directly
> from the BIOS". If you don't have the same results between the BIOS and
> lm_sensors, then there's somethinhg wrong and it needs fixin'. There are
> two possibilities. Either the driver is OK but the resistors are
> different on this motherboard, so you have to tweak the formula to get
> the right value. Or the driver isn't working for you. Both cases,
> there's almost nothing we can do until you investigate and give us
> valuable information to start from (either from the motherboard docs or
> experimental). So, if you want us to fix the problem, please gather as
> much information as possible and let us know.
> 

I will try my best (which isn't much, though).

> > > You have to edit /etc/sensors.conf. Look for "w83627hf" and you
> > > should find where to change it a few dozen lines below. However, it
> > > is supposed to work with 782d/783s only. You still can give it a
> > > try, though.
> > 
> > I edited those lines but the readings do not change, including the 
> > statement that sensors are  PII Celeron diodes. 
> 
> Didn't you forget to issue a "sensors -s" (as root) after editing the
> config file?

I did not.

> It probably means that it doesn't recognize the kind of EEPROM it found.
> Usually, EEPROMS are found on memory chips. We've also seen proprietary
> EEPROMs on some laptops (namely Sony Vaio). Is this system a laptop (or
> a desktop of some brand)?

One is an assembled desktop with a Tyan motherboard, Others are
MicroStar motherboards in a custom cluster. I will look up the 
precise specs when I am back at the office.

> 
> You may want to dump the EEPROM's contents to guess what it may be. To
> do this, unload the eeprom module (rmmod eeprom), then run the following
> commands:
> 
> i2cdump 0 0x50
> i2cdump 0 0x51
> i2cdump 0 0x54
> 

It took me some time to do that because in my Red Hat 8.0 installation the
lm_sensors package does not provide the i2c utils. Thus I had to work
with the original most recent distributions i2c-2.7.0.tar.gz and
lm_sensors-2.7.0.tar.gz. But it was not easy either to get the
compilation right with my kernel 2.4.20-openmosix2smp. Most of all,
I could not get modules with the right kernelversion (the smp at the end 
was missing, in spite of all careful reading and tweaking of the 
Makefile). In any case I forced the modules into the kernel, since the 
mismatch is only apparent, and upon running 
  i2cdump 0 0x50
  i2cdump 0 0x51
this is what I got:


     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 75 75 00 82 08 00 01    ??????@.?uu.??.?
10: 0e 04 0c 01 02 20 00 a0 75 00 00 50 3c 50 2d 40    ????? .?u..P<P-@
20: 90 90 50 50 00 00 00 00 00 00 00 00 00 00 00 00    ??PP............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c0    ...............?
40: 7f 7f 7f 0b 00 00 00 00 09 4d 32 55 35 31 32 36    ????....?M2U5126
50: 34 44 53 38 48 41 30 47 2d 37 35 00 00 02 28 00    4DS8HA0G-75..?(.
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

Does it mean something to you?

-- 
			CLAUDIO DESTRI   Claudio.Destri@mib.infn.it
                        DIPARTIMENTO DI FISICA G. OCCHIALINI,
                        UNIVERSITA` MILANO-BICOCCA
                        PIAZZA DELLA SCIENZA 3, 20126 MILANO
                        tel: (39)(2)64482539  fax: (39)(2)64482585

