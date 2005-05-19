From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: 2.7.0 testings
Message-Id: <3DED5B9B.5528E7D8@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021127213903.5b84866d.khali@linux-fr.org>
In-Reply-To: <20021127213903.5b84866d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I fixed (hopefully) dmi_scan; I asked Vojtech if he can fix amd8111
quickly;
if not I can put back the 2.4-only fix for it into the makefile. Will
let you know.

Jean Delvare wrote:
> 
> > Khali, awaiting your OK...
> 
> Well, we still have problems with 2.2 kernels:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.2.22/misc/i2c-amd8111.o
> depmod:         pci_resource_start
> depmod:         pci_get_drvdata
> depmod:         pci_set_drvdata
> depmod:         pci_resource_flags
> depmod:         i2c_amd8111_init
> depmod: *** Unresolved symbols in /lib/modules/2.2.22/misc/dmi_scan.o
> depmod:         isa_memcpy_fromio
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
