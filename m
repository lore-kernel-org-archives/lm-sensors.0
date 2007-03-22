From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 22 Mar 2007 19:38:13 +0000
Subject: [lm-sensors] Failure to Detect VT1211 chip on Averatec 3150P
Message-Id: <191fb4ca0703221238w62c2208frd04b08fffcf9de27@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1174094059.45fb40eb08206@webmail.mail.gatech.edu>
In-Reply-To: <1174094059.45fb40eb08206@webmail.mail.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brad,

> Mar 22 11:44:27 joshua Device driver i2c-0 lacks bus and class support for being
> resumed.
> Mar 22 11:44:27 joshua [<c02bd44b>] device_add+0x53b/0x560
> Mar 22 11:44:27 joshua [<c0255dab>] kobject_init+0x2b/0x40
> Mar 22 11:44:27 joshua [<e6ada5cb>] i2c_add_adapter+0x12b/0x280 [i2c_core]
> Mar 22 11:44:27 joshua [<e6ad66dc>] vt596_probe+0x1dc/0x3b0 [i2c_viapro]
> Mar 22 11:44:27 joshua [<e6ad6500>] vt596_probe+0x0/0x3b0 [i2c_viapro]
> Mar 22 11:44:27 joshua [<c02633d6>] pci_device_probe+0x56/0x80
> Mar 22 11:44:27 joshua [<c02befe3>] really_probe+0x53/0x140
> Mar 22 11:44:27 joshua [<c02bf119>] driver_probe_device+0x49/0xc0
> Mar 22 11:44:27 joshua [<c02bf2ca>] __driver_attach+0x9a/0xa0
> Mar 22 11:44:27 joshua [<c02be52a>] bus_for_each_dev+0x3a/0x60
> Mar 22 11:44:27 joshua [<c02bee96>] driver_attach+0x16/0x20
> Mar 22 11:44:27 joshua [<c02bf230>] __driver_attach+0x0/0xa0
> Mar 22 11:44:27 joshua [<c02be89b>] bus_add_driver+0x7b/0x190
> Mar 22 11:44:27 joshua [<c026358b>] __pci_register_driver+0x6b/0xd0
> Mar 22 11:44:27 joshua [<c0133415>] sys_init_module+0x155/0x1780
> Mar 22 11:44:27 joshua [<c0102e4a>] sysenter_past_esp+0x5f/0x85
> Mar 22 11:44:27 joshua ===========> Mar 22 11:44:27 joshua PCI driver vt596_smbus lacks driver specific resume
> support.

That's not very helpful. Can you go through the log and look for some
vt1211 error messages?
Also, what actually makes you think that you do have the vt1211 chip
in your laptop?
The page you're referencing is a VIA page and nothing prevents the
laptop manufacturer from using other ICs.

...juerg


>
> Thanks again for your help.
>
> --
> Brad Beglin
>

