From: n4phth4@yahoo.com (Keith)
Date: Wed, 23 Nov 2005 14:17:18 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051123131607.41552.qmail@web32606.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- Jean Delvare <khali@linux-fr.org> wrote:

> The i2c-i801 did not receive any recent change which
> could explain the
> problem, and the driver is widely used (including by
> me on UP) so it is
> certainly not fundamentally broken. It must have
> been widely tested on
> SMP systems too. You have an ICH7 though, which is
> one of the most
> recent incarnation of the i801, and this one may not
> have received
> extended testing. Keith, is it an ICH7 on your
> system too, or another
> incarnation?


Hiya fellas.  Sorry I'm not on the list either but
will be eventually.  Anyway I haven't done anything
sensor-related lately, but here's what lspci has to
say (sorry if the lines wrap; yahoo mail is
braindead):


00:00.0 Host bridge: Intel Corporation 82875P/E7210
Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation 82875P Processor
to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB UHCI Controller #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge
(rev c2)
00:1f.0 ISA bridge: Intel Corporation 82801EB/ER
(ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801EB/ER
(ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801EB
(ICH5) SATA Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801EB/ER
(ICH5/ICH5R) SMBus Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation
NV43 [GeForce 6600/GeForce 6600 GT] (rev a2)
02:01.0 SCSI storage controller: Adaptec AIC-7892A
U160/m (rev 02)
02:02.0 Multimedia audio controller: Creative Labs SB
Live! EMU10k1 (rev 08)
02:02.1 Input device controller: Creative Labs SB
Live! MIDI/Game Port (rev 08)
02:0c.0 Ethernet controller: Intel Corporation 82540EM
Gigabit Ethernet Controller (rev 02)


> Please also try to reproduce the hang without
> loading the eeprom driver.


Haven't tried this yet but will this weekend.


> I would additionally be interested in the SMBus
> topology (output of
> "i2cdetect 0" to start with, or whatever the bus
> number is for
> i2c-i801). Do you happen to know if the SMBus on
> that board is
> multiplexed or shared with another bus type.?


I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX 
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX 
50: 50 51 52 53 XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX 61 XX XX 64 XX XX XX XX 69 XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX







	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
