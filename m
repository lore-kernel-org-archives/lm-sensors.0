From: Agile Aspect <agile.aspect@gmail.com>
Date: Tue, 15 Jul 2008 16:16:49 +0000
Subject: [lm-sensors] temperature monitor
Message-Id: <487CCD71.8000909@GMail.COM>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi - I'm new to lm_sensors and I'm trying to monitor the temperature on
a 8 CPU (Intel Xeon CPU X5460  @ 3.16GHz) running CentOS 4.4
(2.6.9-42.ELsmp.)

The command

   i2cdetect -l

returns

   i2c-0   dummy           ISA main adapter                        ISA 
bus algorithm

and the command

   sensor

returns

   No sensors found!

Enclosed is the output of lspci.

Any ideas on how I get a temperature monitor working?

Any help would be greatly appreciated!

;------------------------------------
00:00.0 Host bridge: Intel Corporation 5000X Chipset Memory Controller 
Hub (rev 12)
00:02.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 
Port 2 (rev 12)
00:03.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 
Port 3 (rev 12)
00:04.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 
Port 4 (rev 12)
00:05.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 
Port 5 (rev 12)
00:06.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x8 
Port 6-7 (rev 12)
00:07.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 
Port 7 (rev 12)
00:10.0 Host bridge: Intel Corporation 5000 Series Chipset Error 
Reporting Registers (rev 12)
00:10.1 Host bridge: Intel Corporation 5000 Series Chipset Error 
Reporting Registers (rev 12)
00:10.2 Host bridge: Intel Corporation 5000 Series Chipset Error 
Reporting Registers (rev 12)
00:11.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved 
Registers (rev 12)
00:13.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved 
Registers (rev 12)
00:15.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Registers 
(rev 12)
00:16.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Registers 
(rev 12)
00:1c.0 PCI bridge: Intel Corporation 631xESB/632xESB/3100 Chipset PCI 
Express Root Port 1 (rev 09)
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
01:00.0 SCSI storage controller: LSI Logic / Symbios Logic SAS1068E 
PCI-Express Fusion-MPT SAS (rev 08)
02:00.0 PCI bridge: Broadcom: Unknown device 0103 (rev c3)
03:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708 
Gigabit Ethernet (rev 12)
04:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express 
Upstream Port (rev 01)
04:00.3 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express to 
PCI-X Bridge (rev 01)
05:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express 
Downstream Port E1 (rev 01)
05:01.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express 
Downstream Port E2 (rev 01)
06:00.0 PCI bridge: Broadcom: Unknown device 0103 (rev c3)
07:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708 
Gigabit Ethernet (rev 12)
0e:0d.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
;------------------------------------

-- 
Article. VI. Clause 3 of the constitution of the United States states: 

"The Senators and Representatives before mentioned, and the Members of 
the several State Legislatures, and all executive and judicial Officers, 
both of the United States and of the several States, shall be bound by 
Oath or Affirmation, to support this Constitution; but no religious Test 
shall ever be required as a Qualification to any Office or public Trust 
under the United States." 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
