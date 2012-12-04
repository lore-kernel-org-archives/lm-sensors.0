From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 04 Dec 2012 17:26:16 +0000
Subject: Re: [lm-sensors] [PATCH] x86, AMD: Power driver support for AMD's family 16h processors
Message-Id: <CAErSpo4p1-=71SXN3eg0KVu_S0mwjVjYUBfXSBMypJAatvnAiA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1354623004-8169-1-git-send-email-boris.ostrovsky@amd.com>
In-Reply-To: <1354623004-8169-1-git-send-email-boris.ostrovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boris Ostrovsky <boris.ostrovsky@amd.com>
Cc: herrmann.der.user@googlemail.com, khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, Dec 4, 2012 at 5:10 AM, Boris Ostrovsky <boris.ostrovsky@amd.com> wrote:
> Add family 16h PCI ID to AMD's power driver to allow it report
> power consumption on these processors.
>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@amd.com>
> ---
>  drivers/hwmon/fam15h_power.c |    1 +
>  include/linux/pci_ids.h      |    1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> index 4f41104..dda1113 100644
> --- a/drivers/hwmon/fam15h_power.c
> +++ b/drivers/hwmon/fam15h_power.c
> @@ -248,6 +248,7 @@ static void __devexit fam15h_power_remove(struct pci_dev *pdev)
>
>  static DEFINE_PCI_DEVICE_TABLE(fam15h_power_id_table) = {
>         { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
> +       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
>         {}
>  };
>  MODULE_DEVICE_TABLE(pci, fam15h_power_id_table);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 9d36b82..9c9a464 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -524,6 +524,7 @@
>  #define PCI_DEVICE_ID_AMD_15H_NB_F3    0x1603
>  #define PCI_DEVICE_ID_AMD_15H_NB_F4    0x1604
>  #define PCI_DEVICE_ID_AMD_15H_NB_F5    0x1605
> +#define PCI_DEVICE_ID_AMD_16H_NB_F4    0x1534
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3    0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE                0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME   0x2001

Read the comment at the top of pci_ids.h.  Based on just this patch,
it doesn't seem like the pci_ids.h change is warranted.

Bjorn

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
