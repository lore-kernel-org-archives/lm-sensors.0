From: devsku@gmail.com (Sunil Kumar)
Date: Tue, 29 Aug 2006 22:25:15 +0000
Subject: [lm-sensors] Is the Intel i945G supported/planned?
Message-Id: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Following is the lspci o/p:

$ lspci
00:00.0 Host bridge: Intel Corporation 945G/GZ/P/PL Express Memory
Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation 945G/GZ/P/PL Express PCI Express Root
Port (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 945G/GZ Express
Integrated Graphics Controller (rev 02)
00:02.1 Display controller: Intel Corporation 945G/GZ Express Integrated
Graphics Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
1 (rev 01)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
2 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
(rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
(rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
(rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
(rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1e.2 Multimedia audio controller: Intel Corporation 82801G (ICH7 Family)
AC'97 Audio Controller (rev 01)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface
Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller
(rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial
ATA Storage Controller IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev
01)
02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 Gigabit
Ethernet PCI Express (rev 01)

Can I expect to see my sensors sometime soon?

$ lsmod
Module                  Size  Used by
vmnet                  30764  9
vmmon                  99788  0
i915                   18304  2
eeprom                  7568  0
drm                    62740  3 i915
snd_intel8x0           31260  0
snd_ac97_codec         83616  1 snd_intel8x0
snd_ac97_bus            2816  1 snd_ac97_codec
intel_agp              21788  1
intelfb                30628  0
tg3                    96900  0
i2c_i801                7820  0
agpgart                32712  4 drm,intel_agp,intelfb
i2c_core               20352  2 eeprom,i2c_i801

$ sensors
No sensors found!

-Sunil
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060829/0fd35f2a/attachment.html 
