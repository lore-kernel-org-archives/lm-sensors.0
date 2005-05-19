From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: SMbus problem ?
Message-Id: <20030604082958.2d0efb2f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030602222815.14c7b37f.sesshoumaru@altern.org>
In-Reply-To: <20030602222815.14c7b37f.sesshoumaru@altern.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> All the modules failed to load with sensors-detect same the PCI bus
> adapters.
> However my motherboard is recognized :
>  BIOS vendor (ACPI): Nvidia
>  System vendor (DMI): ASUSTeK Computer INC.
>  BIOS version (DMI): ASUS A7N8X-X ACPI BIOS Rev 1004
> 
> (chipset: nvidi nforce2).

nVidia's nForce2 isn't supported in 2.7.0. It is supported in CVS only.
This means that you have to checkout i2c (lk2-4 branch) and lm_sensors2
from CVS if you want to have a chance to have something working.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
