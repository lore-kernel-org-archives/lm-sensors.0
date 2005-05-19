From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: SiS 648, P4S8X: success (not total, but still good)
Message-Id: <20030227095825.64ab2fac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E5D5A3B.9010701@ens.fr>
In-Reply-To: <3E5D5A3B.9010701@ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> PCI: No IRQ known for interrupt pin B of device 00:02.1. Please try 
> using pci=biosirq.
> (...)
> This is with <PnP OS: No> in the BIOS. If I set this to "Yes", none
> of my peripheral gets IRQs!

Did you try enabling ACPI? You may need this patch to get it work:
http://sourceforge.net/projects/acpi/

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
