From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 24 Oct 2012 03:45:09 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <20121024034509.GA322@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
To: lm-sensors@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 23, 2012 at 06:32:51PM +0200, Jean Delvare wrote:
> Hi Harald,
> 
> On Tue, 23 Oct 2012 11:57:41 +0200, Harald Judt wrote:
> > All values except the ones mentioned are being reported correctly after 
> > resuming.
> 
> I have attached a shell script which will dump all registers from the
> chip. I would like you to run it before and after suspend, and send me
> the results. That way I can ensure that I save and restore all relevant
> registers.
> 
> # rmmod w83627ehf
> # ./isadump_all_banks.sh 0x295 0x296 before-suspend
> (suspend, resume)
> # ./isadump_all_banks.sh 0x295 0x296 after-resume
> 
> This will generate 8 dump files, please send them back to me.
> 
Hi Jean,

In case it helps, I attached register dump files for NCT6775F, created with a
recent version of superiotool.

Guenter

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=before-suspend

superiotool r4.0-2775-gb3a18ac
Found Nuvoton NCT6775F (B) (id=0xb473) at 0x2e
Register dump:
idx 20 21 22 23 24 25 26 27  28 29 2a 2b 2c 2d 2e 2f
val b4 73 ff 60 40 00 00 01  10 00 38 77 fc 04 00 08
def b4 73 ff 78 40 00 00 7d  00 00 58 77 fc 04 00 MM
LDN 0x00 (FDC)
idx 30 60 61 70 74 f0 f1 f2  f4 f5
val 00 03 f0 06 02 8e 00 ff  00 00
def 03 03 f0 06 02 8e 00 ff  00 00
LDN 0x01 (Parallel Port)
idx 30 60 61 70 74 f0
val 00 03 78 07 04 3f
def 01 03 78 07 04 3f
LDN 0x02 (UART A)
idx 30 60 61 70 f0
val 01 03 f8 04 00
def 01 03 f8 04 00
LDN 0x03 (UART B, IR)
idx 30 60 61 70 f0 f1
val 00 02 f8 03 00 00
def 01 02 f8 03 00 00
LDN 0x05 (Keyboard Controller)
idx 30 60 61 62 63 70 72 f0
val 01 00 60 00 64 01 0c 81
def 00 00 00 00 00 00 00 83
LDN 0x06 (CIR)
idx 30 60 61 70
val 00 00 00 00
def 00 00 00 00
LDN 0x07 (GPIO6, GPIO7, GPIO8, GPIO9)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ec ed ee  f4 f5 f6 f7 f8
val 1c 00 00 00 00 00 00 00  00 7b 00 00 00 00 00 00  ff ff ff ff ff
def 18 ff 00 00 00 ef 00 00  00 ff 00 00 00 00 00 00  ff 00 00 00 00
LDN 0x08 (WDT1, GPIO0, GPIO1)
idx 30 e0 e1 e2 e3 e4 f0 f1  f2 f3 f4 f5 f6 f7
val 06 ff 37 00 00 00 ff 00  00 00 00 ff 00 ff
def 00 ff 00 00 00 00 ff 00  00 00 00 00 00 00
LDN 0x09 (GPIO2, GPIO3, GPIO4, GPIO5)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ee f0 f1  f2 f4 f5 f6 f7 fe
val 0f cf 00 00 00 ff 80 00  00 00 00 00 00 00 00 00  00 ff e0 00 00 00
def 05 ff 00 00 00 ff 00 00  00 00 00 00 00 00 ff 00  00 ff 00 00 00 00
LDN 0x0a (ACPI)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ed f2 f3  f4 f6 f7 fe
val 01 01 00 00 00 00 02 5c  00 01 00 00 16 20 7c 00  00 00 20 00
def 00 01 00 00 00 00 02 1c  00 00 00 00 00 00 7c 00  00 00 20 00
LDN 0x0b (Hardware Monitor, Front Panel LED)
idx 30 60 61 62 63 70 f0 f1  f2 f3 f4 f5 f6 f7 f8 f9  fa fb fc fd fe
val 01 02 90 02 a0 00 1e 00  00 00 04 10 00 87 47 00  00 00 00 00 00
def 00 00 00 00 00 00 c1 00  00 00 00 10 00 87 47 00  00 00 00 00 00
LDN 0x0c (PECI, SST)
idx e0 e1 e2 e3 e4 e5 e6 e7  e9 ee ef f1 f2 f3 fa
val ff 00 00 00 00 60 00 01  2f 47 5b 48 50 10 00
def 00 00 00 00 00 00 00 01  0f 47 5b 40 50 10 00
LDN 0x0d (VID, VIDDAC, BUSSEL)
idx e0 e1 e2 e3 e4 e5 e6 e7  eb ec ed ee ef f3 f4 f5  f6 f7 f8 f9
val 00 00 ff ff 07 00 00 00  14 00 00 88 00 00 00 00  07 ff 00 7b
def 00 00 00 00 07 00 00 00  14 01 00 88 00 00 00 00  07 00 00 00
LDN 0x0e (CIR WAKE-UP)
idx 30 60 61 70
val 00 00 00 00
def 00 00 00 00
LDN 0x0f (GPIO Push-Pull or Open-drain)
idx e0 e1 e2 e3 e4 e5 e6 e7  e8 e9 f0 f2 f3 f4 f8 fe
val ff ff f7 ff fb cb ff ff  ff ff 00 00 00 00 70 ff
def ff ff f7 ff fb cb ff ff  ff ff 00 00 00 00 70 ff
Bank 0:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 04 4d 04 33 00 ff ff ff ff ff ff ff ff ff ff ff 
01: 04 4d 00 ff 00 ff ff ff 43 3f 00 00 26 ff 04 c5 
02: 5f 60 d9 d9 a2 b8 84 1a 40 29 00 da 00 00 00 00 
03: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
04: 01 00 00 ff ff 00 3a 05 2d ff 00 00 18 95 00 a3 
05: ff ff 00 ff ff ff 00 80 c1 70 ff ff 01 0f 0e 05 
06: 00 ff 40 01 01 01 00 ff ff ff ff ff 00 ed 1a ff 
07: 00 0a 00 2f 00 16 00 2f 00 ff 00 1f ff 01 1a 00 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 1:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0e 01 42 0a 0a 01 01 3c 00 4d ff 01 ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 02 01 59 59 62 65 68 4d 4d 4d 7b a6 ff ff ff ff 
03: ff 00 ff 4d 02 72 00 ff 00 c1 02 01 24 46 ff 00 
04: 4d ff 4d 4d 31 00 00 00 01 ff ff ff ff ff 01 ff 
05: 1a 00 00 4b 00 50 05 fe ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 2:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 05 01 42 0a 0a 80 01 3c 01 33 ff 01 ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 02 01 46 46 4f 52 55 33 33 33 66 9a ff ff ff ff 
03: ff 00 ff 33 02 5d 00 ff 00 c2 02 01 29 46 ff 00 
04: 33 ff 33 33 17 00 00 00 01 ff ff ff ff ff 02 ff 
05: 16 00 00 4b 00 50 18 00 ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 3:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0e 01 42 0a 0a 01 01 3c 02 4d ff 01 ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 02 01 59 59 62 65 68 4d 4d 4d 7b a6 ff ff ff ff 
03: ff 00 ff 4d 02 72 00 ff 00 c1 02 01 24 46 ff 00 
04: 4d ff 4d 4d 31 00 00 00 01 ff ff ff ff ff 03 ff 
05: 00 03 03 05 00 03 03 03 04 01 24 d8 24 05 00 00 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 4:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff 
01: 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff 
02: ff 00 00 96 64 96 64 e1 96 01 ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: 3f 00 03 ff ff ff ff ff ff ff ff ff ff ff 04 ff 
05: 00 13 ff 00 00 00 00 2b 6c de 11 33 09 5f 20 ff 
06: ff 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 5:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 55 77 00 00 00 00 00 00 00 ff 
01: 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff 
02: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 05 ff 
05: cf c8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 6:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff 
01: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ec ff 
02: ff 01 02 05 0e 06 01 ff 00 00 00 2f 00 1a 04 00 
03: 00 40 00 29 00 00 00 00 00 00 ff ff ff ff ff ff 
04: ff 02 02 02 02 02 00 00 00 ff ff ff ff ff 06 ff 
05: 7f 7f 7f 7f 7f 7f 02 93 04 04 00 00 00 00 00 00 
06: 2f 2f 00 00 00 00 00 00 00 00 00 ff ff ff ff ff 
07: 7f 7f 50 4b 04 7f 7f 50 4b 04 7f 7f 50 4b 04 00 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 10:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 62 48 48 48 48 48 48 48 00 00 00 00 00 01 01 00 
01: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
02: 2f ed 00 00 80 f8 80 f8 80 f8 80 f8 80 f8 80 f8 
03: 80 f8 80 f8 80 f8 80 f8 80 f8 80 f8 80 f8 80 f8 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 0a ff 
05: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
06: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
07: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 12:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
02: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
03: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 0c ff 
05: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
06: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
07: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 13:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
02: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
03: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 0d ff 
05: 02 16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
06: 00 32 00 00 00 00 00 00 00 01 00 01 00 42 22 00 
07: 00 3c 41 be e0 ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=after-suspend

superiotool r4.0-2775-gb3a18ac
Found Nuvoton NCT6775F (B) (id=0xb473) at 0x2e
Register dump:
idx 20 21 22 23 24 25 26 27  28 29 2a 2b 2c 2d 2e 2f
val b4 73 ff 60 40 00 00 01  10 00 38 77 fc 04 00 08
def b4 73 ff 78 40 00 00 7d  00 00 58 77 fc 04 00 MM
LDN 0x00 (FDC)
idx 30 60 61 70 74 f0 f1 f2  f4 f5
val 00 03 f0 06 02 8e 00 ff  00 00
def 03 03 f0 06 02 8e 00 ff  00 00
LDN 0x01 (Parallel Port)
idx 30 60 61 70 74 f0
val 00 03 78 07 04 3f
def 01 03 78 07 04 3f
LDN 0x02 (UART A)
idx 30 60 61 70 f0
val 01 03 f8 04 00
def 01 03 f8 04 00
LDN 0x03 (UART B, IR)
idx 30 60 61 70 f0 f1
val 00 02 f8 03 00 00
def 01 02 f8 03 00 00
LDN 0x05 (Keyboard Controller)
idx 30 60 61 62 63 70 72 f0
val 01 00 60 00 64 01 0c 81
def 00 00 00 00 00 00 00 83
LDN 0x06 (CIR)
idx 30 60 61 70
val 00 00 00 00
def 00 00 00 00
LDN 0x07 (GPIO6, GPIO7, GPIO8, GPIO9)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ec ed ee  f4 f5 f6 f7 f8
val 1c 00 00 00 00 00 00 00  00 7b 00 00 00 00 00 00  ff ff ff ff ff
def 18 ff 00 00 00 ef 00 00  00 ff 00 00 00 00 00 00  ff 00 00 00 00
LDN 0x08 (WDT1, GPIO0, GPIO1)
idx 30 e0 e1 e2 e3 e4 f0 f1  f2 f3 f4 f5 f6 f7
val 06 ff 37 00 00 00 ff 00  00 00 00 ff 00 ff
def 00 ff 00 00 00 00 ff 00  00 00 00 00 00 00
LDN 0x09 (GPIO2, GPIO3, GPIO4, GPIO5)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ee f0 f1  f2 f4 f5 f6 f7 fe
val 0f cf 00 00 00 ff 80 00  80 00 00 00 00 00 00 00  00 1f 00 00 00 00
def 05 ff 00 00 00 ff 00 00  00 00 00 00 00 00 ff 00  00 ff 00 00 00 00
LDN 0x0a (ACPI)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ed f2 f3  f4 f6 f7 fe
val 01 00 00 00 00 00 02 5c  00 01 00 00 16 20 7c 00  00 00 20 00
def 00 01 00 00 00 00 02 1c  00 00 00 00 00 00 7c 00  00 00 20 00
LDN 0x0b (Hardware Monitor, Front Panel LED)
idx 30 60 61 62 63 70 f0 f1  f2 f3 f4 f5 f6 f7 f8 f9  fa fb fc fd fe
val 01 02 90 02 a0 00 1e 00  00 00 04 10 00 87 47 00  00 00 00 00 00
def 00 00 00 00 00 00 c1 00  00 00 00 10 00 87 47 00  00 00 00 00 00
LDN 0x0c (PECI, SST)
idx e0 e1 e2 e3 e4 e5 e6 e7  e9 ee ef f1 f2 f3 fa
val ff 00 00 00 00 60 00 01  2f 47 5b 48 50 10 00
def 00 00 00 00 00 00 00 01  0f 47 5b 40 50 10 00
LDN 0x0d (VID, VIDDAC, BUSSEL)
idx e0 e1 e2 e3 e4 e5 e6 e7  eb ec ed ee ef f3 f4 f5  f6 f7 f8 f9
val 00 00 ff ff 07 00 00 00  14 00 00 88 00 00 00 00  07 ff 00 e7
def 00 00 00 00 07 00 00 00  14 01 00 88 00 00 00 00  07 00 00 00
LDN 0x0e (CIR WAKE-UP)
idx 30 60 61 70
val 00 00 00 00
def 00 00 00 00
LDN 0x0f (GPIO Push-Pull or Open-drain)
idx e0 e1 e2 e3 e4 e5 e6 e7  e8 e9 f0 f2 f3 f4 f8 fe
val ff ff f7 ff fb cb ff ff  ff ff 00 00 00 00 70 ff
def ff ff f7 ff fb cb ff ff  ff ff 00 00 00 00 70 ff
Bank 0:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 04 4d 04 33 00 ff ff ff ff ff ff ff ff ff ff ff 
01: 04 4d 00 ff 00 ff ff ff 43 3f 00 00 25 ff 03 c5 
02: 5d 60 d9 d9 a2 b8 84 1b 3d 00 00 da 00 00 00 00 
03: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
04: 01 5e 07 ff ff 00 3a 05 2d ff 00 00 18 95 00 a3 
05: ff ff 00 ff ff ff 00 80 c1 70 ff ff 01 0e 0e 05 
06: 00 ff 40 01 01 01 00 ff ff ff ff ff 00 ed 86 ff 
07: 00 0a 00 2c 00 18 00 2c 00 ff 00 1f ff 01 1b 00 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 1:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0e 01 42 0a 0a 01 01 3c 00 4d ff 01 ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 02 01 59 59 62 65 68 4d 4d 4d 7b a6 ff ff ff ff 
03: ff 00 ff 4d 02 72 00 ff 00 c1 02 01 24 46 ff 00 
04: 4d ff 4d 4d 2b 00 00 00 01 ff ff ff ff ff 01 ff 
05: 1a 80 00 4b 00 50 05 fe ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 2:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 05 01 42 0a 0a 80 01 3c 01 33 ff 01 ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 02 01 46 46 4f 52 55 33 33 33 66 9a ff ff ff ff 
03: ff 00 ff 33 02 5d 00 ff 00 c2 02 01 29 46 ff 00 
04: 33 ff 33 33 19 00 00 00 01 ff ff ff ff ff 02 ff 
05: 18 00 00 4b 00 50 18 00 ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 3:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0e 01 42 0a 0a 01 01 3c 02 4d ff 01 ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 02 01 59 59 62 65 68 4d 4d 4d 7b a6 ff ff ff ff 
03: ff 00 ff 4d 02 72 00 ff 00 c1 02 01 24 46 ff 00 
04: 4d ff 4d 4d 2b 00 00 00 01 ff ff ff ff ff 03 ff 
05: 07 03 05 05 00 03 03 03 07 00 24 d7 24 08 00 00 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 4:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff 
01: 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff 
02: ff 00 00 96 64 96 64 e1 96 01 ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: 3f 00 03 ff ff ff ff ff ff ff ff ff ff ff 04 ff 
05: 03 13 ff 00 00 00 00 23 30 5e 11 33 09 5f 20 ff 
06: ff 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 5:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 55 55 00 00 00 00 00 00 00 ff 
01: 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff 
02: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 05 ff 
05: cf 89 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 6:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff 
01: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ec ff 
02: ff 01 02 05 0e 06 01 ff 00 00 00 2c 00 1b 00 00 
03: 00 3d 00 00 00 00 00 00 00 00 ff ff ff ff ff ff 
04: ff 02 02 02 02 02 00 00 00 ff ff ff ff ff 06 ff 
05: 7f 7f 7f 7f 7f 7f 02 b3 00 00 00 00 00 00 00 00 
06: 2c 2c 00 00 00 00 00 00 00 00 00 ff ff ff ff ff 
07: 7f 7f 50 4b 04 7f 7f 50 4b 04 7f 7f 50 4b 04 00 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 10:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 62 48 48 48 48 48 48 48 00 00 00 00 00 01 01 00 
01: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
02: 86 ed 00 00 80 f8 80 f8 80 f8 80 f8 80 f8 80 f8 
03: 80 f8 80 f8 80 f8 80 f8 80 f8 80 f8 80 f8 80 f8 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 0a ff 
05: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
06: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
07: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 12:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
02: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
03: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 0c ff 
05: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
06: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
07: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 13:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
02: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
03: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 0d ff 
05: 00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
06: 00 32 00 00 00 00 00 00 00 01 00 01 00 42 22 00 
07: 00 3c 41 be 45 ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--82I3+IH0IqGh5yIs--
