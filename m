From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 19 Dec 2005 22:33:40 +0000
Subject: [lm-sensors] [PATCH 5/7] i2c: scx200_acb - add cs5535 support
Message-Id: <808c8e9d0512191433h73635a78w91ea02c3fa39ebca@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191055i1419fc08ra8f2b27cb9642c6f@mail.gmail.com>
In-Reply-To: <808c8e9d0512191055i1419fc08ra8f2b27cb9642c6f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Those macros are defined in 2.6.15-rc5-mm3 as:
#define PCI_DEVICE_ID_NS_CS5535_ISA 0x002b
#define PCI_DEVICE_ID_AMD_CS5536_ISA 0x2090

The -mm patch that defines the NS macro is:
i386-gpio-driver-for-amd-cs5535-cs5536.patch

I'm not sure which patch defines the AMD macro.

Ben

On 12/19/05, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Ben,
>
> > Add support for the CS5535 and CS5536 Geode companion devices.
>
> Breaks compilation:
>
>   CC [M]  drivers/i2c/busses/scx200_acb.o
> drivers/i2c/busses/scx200_acb.c:497: error: `PCI_DEVICE_ID_NS_CS5535_ISA' undeclared here (not in a function)
> drivers/i2c/busses/scx200_acb.c:497: error: initializer element is not constant
> drivers/i2c/busses/scx200_acb.c:497: error: (near initialization for `divil_pci[0].device')
> drivers/i2c/busses/scx200_acb.c:497: error: initializer element is not constant
> drivers/i2c/busses/scx200_acb.c:497: error: (near initialization for `divil_pci[0]')
> drivers/i2c/busses/scx200_acb.c:498: error: `PCI_DEVICE_ID_AMD_CS5536_ISA' undeclared here (not in a function)
> drivers/i2c/busses/scx200_acb.c:498: error: initializer element is not constant
> drivers/i2c/busses/scx200_acb.c:498: error: (near initialization for `divil_pci[1].device')
> drivers/i2c/busses/scx200_acb.c:498: error: initializer element is not constant
> drivers/i2c/busses/scx200_acb.c:498: error: (near initialization for `divil_pci[1]')
> drivers/i2c/busses/scx200_acb.c:499: error: initializer element is not constant
> drivers/i2c/busses/scx200_acb.c:499: error: (near initialization for `divil_pci[2]')
> distcc[10014] ERROR: compile drivers/i2c/busses/scx200_acb.c on localhost failed
> make[3]: *** [drivers/i2c/busses/scx200_acb.o] Error 1
> make[2]: *** [drivers/i2c/busses] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
>
> Please provide an updated patch.
>
> --
> Jean Delvare
>

