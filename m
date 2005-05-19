From: yeupou@coleumes.org (Mathieu Roy)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: No fan values with W83637HF
Message-Id: <m3ekhyb7b9.fsf@eos.attique.in>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'd like to thank you for the good work being done. But that's not the
main subject of this mail.

The mail subject is the (light) issue I have with W83637HF
sensors. Everything seems to be running fine but I have no value for
the fans. The fans (box and CPU) are correctly identified in the BIOS.

----------------

Here's what I get running the sensors command (everything was
configured by sensors-detect)

w83637hf-isa-0290
Adapter: ISA adapter
VCore:     +1.34 V  (min =  +1.40 V, max =  +1.55 V)             
+12V:      +5.84 V  (min = +10.82 V, max = +13.19 V)   
+3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)              
+5V:       +5.09 V  (min =  +4.75 V, max =  +5.25 V)              
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)              
V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)              
VBat:      +3.41 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:        0 RPM  (min = 3461 RPM, div = 2)                     
CPU Fan:     0 RPM  (min = 168750 RPM, div = 2)                     
fan3:        0 RPM  (min = 6250 RPM, div = 8)                     
M/B Temp:    +42?C  (high =   -31?C, hyst =  -119?C)   sensor = thermistor           
CPU Temp:  +41.0?C  (high =   +70?C, hyst =   +65?C)   sensor = diode           
temp3:     +30.0?C  (high =   +70?C, hyst =   +65?C)   sensor = thermistor           
vid:      +1.475 V  (VRM Version 9.0)
alarms:   
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

-------------------

I run the kernel linux 2.6.8-1-686-smp as shipped by Debian, along
with sensors version 2.8.8 with libsensors version 2.8.8, as shipped
by Debian (sarge) too.

--------------------

Follows the result of lspci, giving you an overview of the
hardware.

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AP [Radeon 9600]
0000:01:00.1 Display controller: ATI Technologies Inc RV350 AP [Radeon 9600] (Secondary)
0000:02:02.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
0000:02:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

-------------
 
Any clues ? On another computer, with different hardware but working
with lm-sensors (it87), I notice that fan speed is shown only when it
reach some value; and I read stuff related to that in the docs. I
tried to do some checks about that running the CPU at 100% for a while
(I guess the box fan speed increased since the box temperature was
going down (5?C decrease) while the CPU temperature was increasing) 
but I'm not sure the test was really conclusive since I was not able
to make the CPU getting hotier than 57?C.
I also search on the web and found mails about the w83637hf support in
lm-sensors, derived from w83627 stuff: in these mails, apparently,
people were getting (more or less) accurate values for their fans
sensors.

Is there any other information I can provide? Is there anything I
should try? Or is it a known problem (I did not found relevant
information in
<http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/w83627hf>
neither in
<http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/w83781d>)


Thanks,
Regards,



-- 
Mathieu Roy

  +---------------------------------------------------------------------+
  | General Homepage:           http://yeupou.coleumes.org/             |
  | Computing Homepage:         http://alberich.coleumes.org/           |
  | Not a native english speaker:                                       |
  |     http://stock.coleumes.org/doc.php?i=/misc-files/flawed-english  |
  +---------------------------------------------------------------------+
