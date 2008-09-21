From: "Jyh-Pin Chou" <cinnamonchou@gmail.com>
Date: Sun, 21 Sep 2008 14:10:15 +0000
Subject: [lm-sensors] i2c-i801 (No sensors found)
Message-Id: <af17bc2d0809210710g478e5b98t9ebb56657faed13c@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8093480907433531616=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8093480907433531616==
Content-Type: multipart/alternative; 
	boundary="----=_Part_69055_1214218.1222006216020"

------=_Part_69055_1214218.1222006216020
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I'm trying to get sensors working on a motherboard I have (see details below)
I have run sensors-detect (see output further below) - and it says that
I have a i801 chipset, but when I run sensors I get this output: "No
sensors found!"

My kernel is 2.6.16.46-0.12-smp on a SUSE x86 machine

King Regards

JP

=======================================================
(lspci gives this message)
00:00.0 Host bridge: Intel Corporation 5000P Chipset Memory Controller
Hub (rev b1)
00:02.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x4 Port 2 (rev b1)
00:03.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x4 Port 3 (rev b1)
00:04.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x8 Port 4-5 (rev b1)
00:05.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x4 Port 5 (rev b1)
00:06.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x8 Port 6-7 (rev b1)
00:07.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x4 Port 7 (rev b1)
00:08.0 System peripheral: Intel Corporation 5000 Series Chipset DMA
Engine (rev b1)
00:10.0 Host bridge: Intel Corporation 5000 Series Chipset FSB
Registers (rev b1)
00:10.1 Host bridge: Intel Corporation 5000 Series Chipset FSB
Registers (rev b1)
00:10.2 Host bridge: Intel Corporation 5000 Series Chipset FSB
Registers (rev b1)
00:11.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved
Registers (rev b1)
00:13.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved
Registers (rev b1)
00:15.0 Host bridge: Intel Corporation 5000 Series Chipset FBD
Registers (rev b1)
00:16.0 Host bridge: Intel Corporation 5000 Series Chipset FBD
Registers (rev b1)
00:1c.0 PCI bridge: Intel Corporation 631xESB/632xESB/3100 Chipset PCI
Express Root Port 1 (rev 09)
00:1c.1 PCI bridge: Intel Corporation 631xESB/632xESB/3100 Chipset PCI
Express Root Port 2 (rev 09)
00:1d.0 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
UHCI USB Controller #1 (rev 09)
00:1d.1 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
UHCI USB Controller #2 (rev 09)
00:1d.2 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
UHCI USB Controller #3 (rev 09)
00:1d.3 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
UHCI USB Controller #4 (rev 09)
00:1d.7 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
EHCI USB2 Controller (rev 09)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d9)
00:1f.0 ISA bridge: Intel Corporation 631xESB/632xESB/3100 Chipset LPC
Interface Controller (rev 09)
00:1f.2 IDE interface: Intel Corporation 631xESB/632xESB/3100 Chipset
SATA Storage Controller IDE (rev 09)
00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus
Controller (rev 09)
01:06.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
02:00.0 PCI bridge: Broadcom EPB PCI-Express to PCI-X Bridge (rev c3)
03:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708
Gigabit Ethernet (rev 12)
04:00.0 RAID bus controller: Adaptec AAC-RAID (Rocket) (rev 02)
05:00.0 PCI bridge: Broadcom EPB PCI-Express to PCI-X Bridge (rev c3)
06:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708
Gigabit Ethernet (rev 12)
07:00.0 InfiniBand: Mellanox Technologies MT25208 InfiniHost III Ex
(Tavor compatibility mode) (rev a0)
1a:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express
Upstream Port (rev 01)
1a:00.3 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express to
PCI-X Bridge (rev 01)
1b:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express
Downstream Port E1 (rev 01)
1b:01.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express
Downstream Port E2 (rev 01)
=======================================================
(the result by sensors-detect)
# sensors-detect revision $Revision$

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel Enterprise
Southbridge - ESB2

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 0440 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National
Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): Probing for
Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC87427 Super IO Fan Sensors'
    (but not activated)
Found `Nat. Semi. PC87427 Super IO Health Sensors'
    (but not activated)
Found `Nat. Semi. PC87427 Super IO Health Sensors'
    (but not activated)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): Silicon
Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         Success!
    (driver `to-be-written')
VIA C7 thermal and voltage sensors...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:
Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
=======================================================
(lsmod | grep i2c)
i2c_dev                27400  0
i2c_i801               26004  0
i2c_core               39936  2 i2c_dev,i2c_i801
=======================================================
(lspci -n)
00:00.0 Class 0600: 8086:25d8 (rev b1)
00:02.0 Class 0604: 8086:25e2 (rev b1)
00:03.0 Class 0604: 8086:25e3 (rev b1)
00:04.0 Class 0604: 8086:25f8 (rev b1)
00:05.0 Class 0604: 8086:25e5 (rev b1)
00:06.0 Class 0604: 8086:25f9 (rev b1)
00:07.0 Class 0604: 8086:25e7 (rev b1)
00:08.0 Class 0880: 8086:1a38 (rev b1)
00:10.0 Class 0600: 8086:25f0 (rev b1)
00:10.1 Class 0600: 8086:25f0 (rev b1)
00:10.2 Class 0600: 8086:25f0 (rev b1)
00:11.0 Class 0600: 8086:25f1 (rev b1)
00:13.0 Class 0600: 8086:25f3 (rev b1)
00:15.0 Class 0600: 8086:25f5 (rev b1)
00:16.0 Class 0600: 8086:25f6 (rev b1)
00:1c.0 Class 0604: 8086:2690 (rev 09)
00:1c.1 Class 0604: 8086:2692 (rev 09)
00:1d.0 Class 0c03: 8086:2688 (rev 09)
00:1d.1 Class 0c03: 8086:2689 (rev 09)
00:1d.2 Class 0c03: 8086:268a (rev 09)
00:1d.3 Class 0c03: 8086:268b (rev 09)
00:1d.7 Class 0c03: 8086:268c (rev 09)
00:1e.0 Class 0604: 8086:244e (rev d9)
00:1f.0 Class 0601: 8086:2670 (rev 09)
00:1f.2 Class 0101: 8086:2680 (rev 09)
00:1f.3 Class 0c05: 8086:269b (rev 09)
01:06.0 Class 0300: 1002:515e (rev 02)
02:00.0 Class 0604: 1166:0103 (rev c3)
03:00.0 Class 0200: 14e4:164c (rev 12)
04:00.0 Class 0104: 9005:0286 (rev 02)
05:00.0 Class 0604: 1166:0103 (rev c3)
06:00.0 Class 0200: 14e4:164c (rev 12)
07:00.0 Class 0c06: 15b3:6278 (rev a0)
1a:00.0 Class 0604: 8086:3500 (rev 01)
1a:00.3 Class 0604: 8086:350c (rev 01)
1b:00.0 Class 0604: 8086:3510 (rev 01)
1b:01.0 Class 0604: 8086:3514 (rev 01)

------=_Part_69055_1214218.1222006216020
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><pre>Hi All,<br><br>I&#39;m trying to get sensors working on a motherboard I have (see details below)<br>I have run sensors-detect (see output further below) - and it says that <br>I have a i801 chipset, but when I run sensors I get this output: &quot;No sensors found!&quot;<br>
<br>My kernel is 2.6.16.46-0.12-smp on a SUSE x86 machine<br><br>King Regards<br><br>JP<br><br>=======================================================<br>(lspci gives this message)<br>00:00.0 Host bridge: Intel Corporation 5000P Chipset Memory Controller Hub (rev b1)<br>
00:02.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Port 2 (rev b1)<br>00:03.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Port 3 (rev b1)<br>00:04.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x8 Port 4-5 (rev b1)<br>
00:05.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Port 5 (rev b1)<br>00:06.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x8 Port 6-7 (rev b1)<br>00:07.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Port 7 (rev b1)<br>
00:08.0 System peripheral: Intel Corporation 5000 Series Chipset DMA Engine (rev b1)<br>00:10.0 Host bridge: Intel Corporation 5000 Series Chipset FSB Registers (rev b1)<br>00:10.1 Host bridge: Intel Corporation 5000 Series Chipset FSB Registers (rev b1)<br>
00:10.2 Host bridge: Intel Corporation 5000 Series Chipset FSB Registers (rev b1)<br>00:11.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved Registers (rev b1)<br>00:13.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved Registers (rev b1)<br>
00:15.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Registers (rev b1)<br>00:16.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Registers (rev b1)<br>00:1c.0 PCI bridge: Intel Corporation 631xESB/632xESB/3100 Chipset PCI Express Root Port 1 (rev 09)<br>
00:1c.1 PCI bridge: Intel Corporation 631xESB/632xESB/3100 Chipset PCI Express Root Port 2 (rev 09)<br>00:1d.0 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controller #1 (rev 09)<br>00:1d.1 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controller #2 (rev 09)<br>
00:1d.2 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controller #3 (rev 09)<br>00:1d.3 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controller #4 (rev 09)<br>00:1d.7 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset EHCI USB2 Controller (rev 09)<br>
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d9)<br>00:1f.0 ISA bridge: Intel Corporation 631xESB/632xESB/3100 Chipset LPC Interface Controller (rev 09)<br>00:1f.2 IDE interface: Intel Corporation 631xESB/632xESB/3100 Chipset SATA Storage Controller IDE (rev 09)<br>
00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus Controller (rev 09)<br>01:06.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)<br>02:00.0 PCI bridge: Broadcom EPB PCI-Express to PCI-X Bridge (rev c3)<br>
03:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708 Gigabit Ethernet (rev 12)<br>04:00.0 RAID bus controller: Adaptec AAC-RAID (Rocket) (rev 02)<br>05:00.0 PCI bridge: Broadcom EPB PCI-Express to PCI-X Bridge (rev c3)<br>
06:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708 Gigabit Ethernet (rev 12)<br>07:00.0 InfiniBand: Mellanox Technologies MT25208 InfiniHost III Ex (Tavor compatibility mode) (rev a0)<br>1a:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Upstream Port (rev 01)<br>
1a:00.3 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express to PCI-X Bridge (rev 01)<br>1b:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Downstream Port E1 (rev 01)<br>1b:01.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Downstream Port E2 (rev 01)<br>
=======================================================<br>(the result by sensors-detect)<br># sensors-detect revision $Revision$<br><br>This program will help you determine which kernel modules you need<br>to load to use lm_sensors most effectively. It is generally safe<br>
and recommended to accept the default answers to all questions,<br>unless you know what you&#39;re doing.<br><br>We can start with probing for (PCI) I2C or SMBus adapters.<br>Do you want to probe now? (YES/no): Probing for PCI bus adapters...<br>
Use driver `i2c-i801&#39; for device 0000:00:1f.3: Intel Enterprise Southbridge - ESB2<br><br>We will now try to load each adapter module in turn.<br>Module `i2c-i801&#39; already loaded.<br>If you have undetectable or unsupported I2C/SMBus adapters, you can have<br>
them scanned by manually loading the modules before running this script.<br><br>We are now going to do the I2C/SMBus adapter probings. Some chips may<br>be double detected; we choose the one with the highest confidence<br>
value in that case.<br>If you found that the adapter hung after probing a certain address,<br>you can specify that address to remain unprobed.<br><br>Next adapter: SMBus I801 adapter at 0440 (i2c-0)<br>Do you want to scan it? (YES/no/selectively):<br>
Some chips are also accessible through the ISA I/O ports. We have to<br>write to arbitrary I/O ports to probe them. This is usually safe though.<br>Yes, you do have ISA I/O ports even if you do not have any ISA slots!<br>
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Semiconductor LM78&#39; at 0x290...       No<br>Probing for `National Semiconductor LM78-J&#39; at 0x290...     No<br>Probing for `National Semiconductor LM79&#39; at 0x290...       No<br>
Probing for `Winbond W83781D&#39; at 0x290...                   No<br>Probing for `Winbond W83782D&#39; at 0x290...                   No<br>Probing for `IPMI BMC KCS&#39; at 0xca0...                      No<br>Probing for `IPMI BMC SMIC&#39; at 0xca8...                     No<br>
<br>Some Super I/O chips may also contain sensors. We have to write to<br>standard I/O ports to probe them. This is usually safe.<br>Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O at 0x2e/0x2f<br>
Trying family `National Semiconductor&#39;...                   Yes<br>Found `Nat. Semi. PC87427 Super IO Fan Sensors&#39;<br>    (but not activated)<br>Found `Nat. Semi. PC87427 Super IO Health Sensors&#39;<br>    (but not activated)<br>
Found `Nat. Semi. PC87427 Super IO Health Sensors&#39;<br>    (but not activated)<br>Probing for Super-I/O at 0x4e/0x4f<br>Trying family `National Semiconductor&#39;...                   No<br>Trying family `SMSC&#39;...                                     No<br>
Trying family `VIA/Winbond/Fintek&#39;...                       No<br>Trying family `ITE&#39;...                                      No<br><br>Some south bridges, CPUs or memory controllers may also contain<br>embedded sensors. Do you want to scan for them? (YES/no): Silicon Integrated Systems SIS5595...                       No<br>
VIA VT82C686 Integrated Sensors...                          No<br>VIA VT8231 Integrated Sensors...                            No<br>AMD K8 thermal sensors...                                   No<br>AMD K10 thermal sensors...                                  No<br>
Intel Core family thermal sensor...                         Success!<br>    (driver `coretemp&#39;)<br>Intel AMB FB-DIMM thermal sensor...                         Success!<br>    (driver `to-be-written&#39;)<br>VIA C7 thermal and voltage sensors...                       No<br>
<br>Now follows a summary of the probes I have just done.<br>Just press ENTER to continue:<br>Driver `coretemp&#39; (should be inserted):<br>  Detects correctly:<br>  * Chip `Intel Core family thermal sensor&#39; (confidence: 9)<br>
<br>Driver `to-be-written&#39; (should be inserted):<br>  Detects correctly:<br>  * Chip `Intel AMB FB-DIMM thermal sensor&#39; (confidence: 9)<br><br>Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):<br>=======================================================<br>
(lsmod | grep i2c)<br>i2c_dev                27400  0<br>i2c_i801               26004  0<br>i2c_core               39936  2 i2c_dev,i2c_i801<br>=======================================================<br>(lspci -n)<br>00:00.0 Class 0600: 8086:25d8 (rev b1)<br>
00:02.0 Class 0604: 8086:25e2 (rev b1)<br>00:03.0 Class 0604: 8086:25e3 (rev b1)<br>00:04.0 Class 0604: 8086:25f8 (rev b1)<br>00:05.0 Class 0604: 8086:25e5 (rev b1)<br>00:06.0 Class 0604: 8086:25f9 (rev b1)<br>00:07.0 Class 0604: 8086:25e7 (rev b1)<br>
00:08.0 Class 0880: 8086:1a38 (rev b1)<br>00:10.0 Class 0600: 8086:25f0 (rev b1)<br>00:10.1 Class 0600: 8086:25f0 (rev b1)<br>00:10.2 Class 0600: 8086:25f0 (rev b1)<br>00:11.0 Class 0600: 8086:25f1 (rev b1)<br>00:13.0 Class 0600: 8086:25f3 (rev b1)<br>
00:15.0 Class 0600: 8086:25f5 (rev b1)<br>00:16.0 Class 0600: 8086:25f6 (rev b1)<br>00:1c.0 Class 0604: 8086:2690 (rev 09)<br>00:1c.1 Class 0604: 8086:2692 (rev 09)<br>00:1d.0 Class 0c03: 8086:2688 (rev 09)<br>00:1d.1 Class 0c03: 8086:2689 (rev 09)<br>
00:1d.2 Class 0c03: 8086:268a (rev 09)<br>00:1d.3 Class 0c03: 8086:268b (rev 09)<br>00:1d.7 Class 0c03: 8086:268c (rev 09)<br>00:1e.0 Class 0604: 8086:244e (rev d9)<br>00:1f.0 Class 0601: 8086:2670 (rev 09)<br>00:1f.2 Class 0101: 8086:2680 (rev 09)<br>
00:1f.3 Class 0c05: 8086:269b (rev 09)<br>01:06.0 Class 0300: 1002:515e (rev 02)<br>02:00.0 Class 0604: 1166:0103 (rev c3)<br>03:00.0 Class 0200: 14e4:164c (rev 12)<br>04:00.0 Class 0104: 9005:0286 (rev 02)<br>05:00.0 Class 0604: 1166:0103 (rev c3)<br>
06:00.0 Class 0200: 14e4:164c (rev 12)<br>07:00.0 Class 0c06: 15b3:6278 (rev a0)<br>1a:00.0 Class 0604: 8086:3500 (rev 01)<br>1a:00.3 Class 0604: 8086:350c (rev 01)<br>1b:00.0 Class 0604: 8086:3510 (rev 01)<br>1b:01.0 Class 0604: 8086:3514 (rev 01)<br>
<br><br><br></pre></div>

------=_Part_69055_1214218.1222006216020--


--===============8093480907433531616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8093480907433531616==--
