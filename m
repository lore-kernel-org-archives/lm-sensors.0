From: tebbens@yahoo.com (Mathew Tebbens)
Date: Sun, 09 Apr 2006 00:23:29 +0000
Subject: [lm-sensors] Intel Corporation 82801G (ICH7 Family)
Message-Id: <20060409002329.46268.qmail@web36810.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi !
   
  I would like to install lm_sensors on a system with the 82801G chipset.
  I read everything on the home page and other support pages but found that
  the 82801G is not supported. Is there anything I can do to help provide support
  for this chipset.
   
  Thanks !
  Matthew
   
   
  To begin, here is the output of lspci:
   
  [tebbens at localhost ~]$ /sbin/lspci 
00:00.0 Host bridge: Intel Corporation 955X Memory Controller Hub
00:01.0 PCI bridge: Intel Corporation 955X PCI Express Graphics Port
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 5 (rev 01)
00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 6 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=AHCI (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc R480 [Radeon X850XT Platinum (PCIE)]
01:00.1 Display controller: ATI Technologies Inc R480 [Radeon X850XT Platinum (PCIE)] (Secondary)
04:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 Gigabit Ethernet PCI Express (rev 01)
05:03.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
05:03.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
05:03.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
05:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
[tebbens at localhost ~]$
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060409/cc800b48/attachment.html
