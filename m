From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Acer Veriton 5500G
Message-Id: <3EF4A892.5040602@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030406164617.10845.qmail@web40612.mail.yahoo.com>
In-Reply-To: <20030406164617.10845.qmail@web40612.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you don't have any sensor chip drivers loaded.
Whatever sensor chip you have we don't support. see FAQ.

Marvin Pascual wrote:
> Hello,
> 
> I installed lm_sensors-2.7.0-2mdk and it's related
> packages on an [1]Acer Veriton 5500G PC running on
> [2]Mandrake Linux 9.1.  I run "sensors-detect" and
> answers the right information on what I believe are
> the right values but I wasn't able to make my
> lm_sensors work right.
> 
> I hope you can help me isolate this problem so that I
> could monitor the temperature of my PC.  I'll be using
> phpSysInfo then.
> 
> Please see below some of the output of the modules
> that are currently installed in my system.
> 
> Thank you very much in advance.
> 
> Marvin
> 
> [1]
> http://www.acer.com.sg/products/veriton5500G/psp_veriton5500G.asp
> 
> [2] http://www.linux-mandrake.com/en/
> 
> - - - < s n i p > - - -
> # lspcidrake
> agpgart         : Intel Corporation|82845 845 Chipset
> Host Bridge (MCH)
> Card:Intel 845  : Intel Corporation|82845 CGC [Chipset
> Graphics Controller]
> usb-uhci        : Intel Corporation|82801DB USB
> Controller
> usb-uhci        : Intel Corporation|82801DB USB
> Controller
> usb-uhci        : Intel Corporation|82801DB USB
> Controller
> ehci-hcd        : Intel Corporation|82801DB USB
> Enhanced Controller
> i810_rng        : Intel Corporation|82820 815e (Camino
> 2) Chipset PCI
> i810-tco        : Intel Corporation|82801DB 845G/GL
> Chipset ISA Bridge (ICH4)
> unknown         : Intel Corporation|82801DB 845G/GL
> Chipset IDE Controller
> unknown         : Intel Corporation|82801DB SMBus
> Controller
> i810_audio      : Intel Corporation|ICH4 845G/GL
> Chipset AC'97 Audio Controller
> 3c59x           : 3Com Corporation|3c905B 100BaseTX
> [Cyclone]
> eepro100        : Intel Corporation|EtherExpress
> PRO/100
> unknown         : Linux 2.4.21-0.13mdk ehci-hcd|Intel
> Corp. 82801DB USB EHCI Controller [Hub|Root Hub]
> unknown         : Unknown|USB UHCI Root Hub [Hub|Root
> Hub]
> unknown         : Unknown|USB UHCI Root Hub [Hub|Root
> Hub]
> Mouse:USB|Wheel : Logitech Inc.|N48 / M-BB48
> [FirstMouse Plus] [Human Interface Devices|Boot
> Interface Subclass|Mouse]
> unknown         : NOVATEK|USB MULTIMEDIA KEYBOARD
> [Human Interface Devices|Boot Interface
> Subclass|Keyboard]
> unknown         : Unknown|USB UHCI Root Hub [Hub|Root
> Hub]
> - - - < s n i p > - - -
> 
> - - - < s n i p > - - -
> # lsmod | grep i2c | lsmod | grep epro
> eeprom          4820   0  (unused)
> i2c-proc        9072   0  [eeprom]
> i2c-i801        5780   0  (unused)
> i2c-core       21192   0  [eeprom i2c-proc i2c-i801]
> eepro100       21844   1  (autoclean)
> mii             3832   0  (autoclean) [eepro100]
> - - - < s n i p > - - -
> 
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Tax Center - File online, calculators, forms, and more
> http://tax.yahoo.com
> 
