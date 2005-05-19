From: knjzek@bones.homeip.net (Ronald Knjzek)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: Problem with A7V333
Message-Id: <1026678117.1078.36.camel@bones>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi!

Having problems with my A7V333.
Looks like no bus and no sensors are dedected.
Chipset should be supported, but lspci shows different
chips as in manual or on the mobo!

-----------------------------------------------------------------

### sensors-detect

[...]
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.
[...]
To continue, we need module `i2c-dev' to be loaded.
If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.
[...]
 this.  Do you want to scan the ISA bus? (YES/no): 
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT 82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
[...]
 listed here to it:

#----cut here----
# I2C adapter drivers
# I2C chip drivers
#----cut here----

Then, run /etc/init.d/modutils


To make the sensors modules behave correctly, add these lines to 
/etc/modutils/local and run update-modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

-----------------------------------------------------------------

### lsmod
Module                  Size  Used by    Not tainted
i2c-philips-par         2088   0  (unused)
i2c-algo-bit            7596   0  [i2c-philips-par]
i2c-proc                6368   0 
i2c-dev                 3840   0 
i2c-isa                 1220   0 
i2c-core               13192   0  [i2c-algo-bit i2c-proc i2c-dev
i2c-isa]
ipt_state                576   2  (autoclean)
iptable_mangle          2144   0  (autoclean) (unused)

---------------------------------------------------------------

### modprobe i2c-viapro
/lib/modules/2.4.18/misc/i2c-viapro.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.18/misc/i2c-viapro.o: insmod
/lib/modules/2.4.18/misc/i2c-viapro.o failed
/lib/modules/2.4.18/misc/i2c-viapro.o: insmod i2c-viapro failed

----------------------------------------------------------------

### lspci -n
00:00.0 Class 0600: 1106:3099
00:01.0 Class 0604: 1106:b099
00:05.0 Class 0401: 13f6:0111 (rev 10)
00:09.0 Class 0c03: 1106:3038 (rev 50)
00:09.1 Class 0c03: 1106:3038 (rev 50)
00:09.2 Class 0c03: 1106:3104 (rev 51)
00:0d.0 Class 0200: 10ec:8029
00:0e.0 Class 0200: 10b7:9004 (rev 04)
00:10.0 Class 0100: 9004:5078 (rev 03)
00:11.0 Class 0601: 1106:3147
00:11.1 Class 0101: 1106:0571 (rev 06)
00:11.2 Class 0c03: 1106:3038 (rev 23)
00:11.3 Class 0c03: 1106:3038 (rev 23)
01:00.0 Class 0300: 10de:0110 (rev b2)

### lspci   
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
00:09.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50)
00:09.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50)
00:09.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev
51)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
00:0e.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL
TPO] (rev 04)
00:10.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
(rev b2)

----------------------------------------------------------------------

### ./i2cdetect  
Error: No i2c-bus specified!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0       dummy           ISA main adapter                       
ISA bus algorithm             

### ./i2cdetect 0
Error: Can't use SMBus Quick Write command on this bus (ISA bus?)

------------------------------------------------------------------------

### isadump 0x295 0x296
  WARNING! Running this program can cause system crashes, data loss and
worse!
  I will probe address register 0x0295 and data register 0x0296.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

-------------------------------------------------------------------

mobo: ASUS A7V333
VIA KT333 North Brige
VIA VT8233A South Brige

kernel 2.4.18

i2c 2.6.3

sensors 2.6.3

--------------------------------------------------------------------

I hope that is all the info you need!
Any help is appreciated.

Ron





