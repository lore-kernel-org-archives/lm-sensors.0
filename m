From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 10 Aug 2005 05:03:20 +0000
Subject: [lm-sensors] SMBus not detected on SiS 964 south bridge
Message-Id: <20050810030254.GD32707@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <dctehc$g25$2@sea.gmane.org>
In-Reply-To: <dctehc$g25$2@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Tero:

* Tero Saarni <tero.saarni@gmail.com> [2005-08-04 19:08:16 +0300]:
> I have SiS 964 south bridge on DFI 661FX-MLV (rev. C)
> motherboard [1].
> 
> SMBus does not get detected by default so I tried to add
> PCI_DEVICE_ID_SI_964 to pci_ids.h and drivers/pci/quirks.c.
> 
> I now get "Enabling SiS 96x SMBus." in kernel log i.e. quirks.c
> now seems to try enable SMBus but lspci still doesn't show SMBus.
> See the output below.
> 
> Any ideas what went wrong?
> [...]

> lspci -vvv -xxx
> [...]

I have no idea, sorry.  I traced the IO of an Asus hardware monitoring program
in order to figure out that quirk code.  Yours is the first 96x I've heard of
for which it doesn't work - bummer.  Does DFI provide a hardware monitoring app?
Can you fire it up inside Wine and capture the IO it performs?  

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

