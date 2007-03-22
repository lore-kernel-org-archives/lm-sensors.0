From: gtg779q@mail.gatech.edu (gtg779q at mail.gatech.edu)
Date: Thu, 22 Mar 2007 16:02:04 +0000
Subject: [lm-sensors] Failure to Detect VT1211 chip on Averatec 3150P
Message-Id: <1174579324.4602a87c7b025@webmail.mail.gatech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1174094059.45fb40eb08206@webmail.mail.gatech.edu>
In-Reply-To: <1174094059.45fb40eb08206@webmail.mail.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Juerg Haefliger <juergh at gmail.com>:

> Make sure hwmon-vid is loaded before you modprobe the vt1211 driver.
> Also, could you post the output of lspci and the tail of
> /var/log/syslog after modprobing the driver?

I made sure that hwmon-vid was loaded, but I still got the same result.  Here is
the output of lspci:

00:00.0 Host bridge: VIA Technologies, Inc. P/KN266 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ601/6912/711E0 CardBus/SmartCardBus
Controller
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237
AC97 Audio Controller (rev 50)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller
(rev 80)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8 KM266/KL266]

and the output of syslog:

Mar 22 11:44:27 joshua Device driver i2c-0 lacks bus and class support for being
resumed.
Mar 22 11:44:27 joshua [<c02bd44b>] device_add+0x53b/0x560
Mar 22 11:44:27 joshua [<c0255dab>] kobject_init+0x2b/0x40
Mar 22 11:44:27 joshua [<e6ada5cb>] i2c_add_adapter+0x12b/0x280 [i2c_core]
Mar 22 11:44:27 joshua [<e6ad66dc>] vt596_probe+0x1dc/0x3b0 [i2c_viapro]
Mar 22 11:44:27 joshua [<e6ad6500>] vt596_probe+0x0/0x3b0 [i2c_viapro]
Mar 22 11:44:27 joshua [<c02633d6>] pci_device_probe+0x56/0x80
Mar 22 11:44:27 joshua [<c02befe3>] really_probe+0x53/0x140
Mar 22 11:44:27 joshua [<c02bf119>] driver_probe_device+0x49/0xc0
Mar 22 11:44:27 joshua [<c02bf2ca>] __driver_attach+0x9a/0xa0
Mar 22 11:44:27 joshua [<c02be52a>] bus_for_each_dev+0x3a/0x60
Mar 22 11:44:27 joshua [<c02bee96>] driver_attach+0x16/0x20
Mar 22 11:44:27 joshua [<c02bf230>] __driver_attach+0x0/0xa0
Mar 22 11:44:27 joshua [<c02be89b>] bus_add_driver+0x7b/0x190
Mar 22 11:44:27 joshua [<c026358b>] __pci_register_driver+0x6b/0xd0
Mar 22 11:44:27 joshua [<c0133415>] sys_init_module+0x155/0x1780
Mar 22 11:44:27 joshua [<c0102e4a>] sysenter_past_esp+0x5f/0x85
Mar 22 11:44:27 joshua ===========Mar 22 11:44:27 joshua PCI driver vt596_smbus lacks driver specific resume
support.

Thanks again for your help.

--
Brad Beglin

