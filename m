From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: pci_module_init problems
Message-Id: <3EEB6B0B.8090402@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c-voodoo3 doesn't load for me on a system with a Banshee.
I triple-checked the pci_device_id table.
voodoo3_probe() is never called and pci_module_init returns -ENODEV.

i2c-viapro works for me on a 8233 system (ID 1106:3074).
But on a 686a system (ID 1106:3057)
it doesn't load. Again I rechecked the ID.



CVS sensors-detect still finds these devices but the
CVS modules won't load.
These both worked in 2.7.0.

What's not right with the pci_device_id table or with
pci_module_init???

modultils version 2.4.22.
