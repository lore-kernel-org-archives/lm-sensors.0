From: fixacpi@gmail.com (Gordon Stanton)
Date: Thu, 25 Jan 2007 01:15:51 +0000
Subject: [lm-sensors] [PATCH] Add Micro-Star as a PCI VENDOR
Message-Id: <c1cd85210701241715p29fb437dy9400e74afaf8bbf7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, lm-sensors@lm-sensors.org, s270-linux@mail.0pointer.de, linux-pci@atrey.karlin.mff.cuni.cz

Hi,
I noticed that a common motherboard manufacturer Micro-Star was
missing it's PCI_VENDOR_ID and so I have sent this patch in.
Later on I will send a patch to pci/quirks.c to unhide the SMBus on
the M510C laptop once I have investigated it a bit more. It hides the
SMBus the same as ASUS (and a couple of others) laptops.
This is definately the correct ID, see
http://www.pcidatabase.com/vendor_details.php?idp5

I would also be happy with PCI_VENDOR_ID_MICRO_STAR instead, what do you think?

Signed-off-by: Gordon Stanton <fixacpi at gmail.com>

---

--- linux-2.6.20-rc5/include/linux/pci_ids.h	2007-01-13 05:54:26.000000000 +1100
+++ linux/include/linux/pci_ids.h	2007-01-25 11:43:30.478249500 +1100
@@ -1875,6 +1875,8 @@

 #define PCI_VENDOR_ID_SAMSUNG		0x144d

+#define PCI_VENDOR_ID_MICROSTAR		0x1462
+
 #define PCI_VENDOR_ID_MYRICOM		0x14c1

 #define PCI_VENDOR_ID_TITAN		0x14D2

