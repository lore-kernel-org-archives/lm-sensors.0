From: gardner.ben@gmail.com (Ben Gardner)
Date: Tue, 20 Dec 2005 22:44:22 +0000
Subject: [lm-sensors] [PATCH 5/7] i2c: scx200_acb - add cs5535 support
Message-Id: <808c8e9d0512201444lb4b1b50mdd27737e991bdd1a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191055i1419fc08ra8f2b27cb9642c6f@mail.gmail.com>
In-Reply-To: <808c8e9d0512191055i1419fc08ra8f2b27cb9642c6f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 12/20/05, Jean Delvare <khali at linux-fr.org> wrote:
> (...)
> Anyway, patch looks OK, and so do patches 4, 6 and 7. Just one question:
>
> > +static struct pci_device_id divil_pci[] = {
>
> Why "divil"?

DIVIL (DIVerse Integrated Logic) is the name of the component/block in
the CS5535 & CS5536 chips that contains the SMBus controller (as well
as the GPIO, ACPI, IRQ controller, etc)

> As the respin of patch 1 prevents most of the next patches to apply,
> you'll have to provide a new set of patches. Patch 2 seems to need
> significant rework too anyway.

Will do.

Thanks,
Ben

