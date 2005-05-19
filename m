From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <20050214201756.3877e68d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christophe,

> > We'd now need the output of "lspci -s 00:00.0 -vn" to add the quirk
> > your system needs. With that I can write a patch for you to test (if
> > you can do that).
>
> Here you are :
> lspci -s 00:00.0 -vn
> 00:00.0 Class 0600: 8086:3340 (rev 21)
>         Subsystem: 1043:184b
>         Flags: bus master, fast devsel, latency 0
>         Memory at e0000000 (32-bit, prefetchable) [size%6M]
>         Capabilities: [e4] #09 [4104]
>         Capabilities: [a0] AGP version 2.0

OK, attached is a patch for Linux 2.6.10, which should do the trick. It
should apply cleanly to any 2.6.11-rc version as well. (If you need it
against an older kernel, just ask.)

If you confirm that the SMBus is properly un-hidden with that patch and
no trouble arise, I'll push it to the PCI folks.

> Merci beaucoup, many thanks.
> Peut-?tre parlez-vous (parles-tu) fran?ais ? Maybe you speak french ?

He oui :) Mais ce n'est pas le cas de la majorit? des lecteurs de cette
liste.

-- 
Jean Delvare
-------------- next part --------------
--- linux-2.6.10/drivers/pci/quirks.c.orig	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10/drivers/pci/quirks.c	2005-02-14 20:10:24.000000000 +0100
@@ -774,6 +774,7 @@
 			}
 		if (dev->device = PCI_DEVICE_ID_INTEL_82855PM_HB)
 			switch (dev->subsystem_device) {
+			case 0x184b: /* W1N notebook */
 			case 0x186a: /* M6Ne notebook */
 				asus_hides_smbus = 1;
 			}
