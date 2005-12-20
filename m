From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Dec 2005 21:10:30 +0000
Subject: [lm-sensors] [PATCH 5/7] i2c: scx200_acb - add cs5535 support
Message-Id: <20051220221030.73cb3d00.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191055i1419fc08ra8f2b27cb9642c6f@mail.gmail.com>
In-Reply-To: <808c8e9d0512191055i1419fc08ra8f2b27cb9642c6f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> Those macros are defined in 2.6.15-rc5-mm3 as:
> #define PCI_DEVICE_ID_NS_CS5535_ISA 0x002b
> #define PCI_DEVICE_ID_AMD_CS5536_ISA 0x2090
> 
> The -mm patch that defines the NS macro is:
> i386-gpio-driver-for-amd-cs5535-cs5536.patch
> 
> I'm not sure which patch defines the AMD macro.

git-libata-all.patch

Anyway, patch looks OK, and so do patches 4, 6 and 7. Just one question:

> +static struct pci_device_id divil_pci[] = {

Why "divil"?

As the respin of patch 1 prevents most of the next patches to apply,
you'll have to provide a new set of patches. Patch 2 seems to need
significant rework too anyway.

Thanks,
-- 
Jean Delvare

