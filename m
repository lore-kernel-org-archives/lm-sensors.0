From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [PATCH 2.6] more i2c bus drivers (2/2)
Message-Id: <3FD0F8F5.5050904@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031205222400.1b7ff3a6.khali@linux-fr.org>
In-Reply-To: <20031205222400.1b7ff3a6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rather than saying 7xx in the names what about changing:

    SMBus AMD7xx adapter
to
    SMBus AMD756 compatible adapter

and

    .name   = "amd7xx smbus",
to
    .name   = "amd756 smbus",


That would seem to be clearer since the module is still named i2c-amd756...

:v)

Jean Delvare wrote:
> This patch restores support for the AMD8111 in the i2c-amd756 driver.
> 
> Credits go to Philip Pokorny for the original patch. I tweaked it a bit.
> 
> This isn't a bug fix and can be delayed until after 2.6.0 if you want.
> 
> --- linux-2.6.0-test11/drivers/i2c/busses/i2c-amd756.c.orig	Sat Oct 25 20:44:35 2003
> +++ linux-2.6.0-test11/drivers/i2c/busses/i2c-amd756.c	Sun Nov 30 11:30:08 2003
> @@ -28,10 +28,12 @@
>      2002-04-08: Added nForce support. (Csaba Halasz)
>      2002-10-03: Fixed nForce PnP I/O port. (Michael Steil)
>      2002-12-28: Rewritten into something that resembles a Linux driver (hch)
> +    2003-11-29: Added back AMD8111 removed by the previous rewrite.
> +                (Philip Pokorny)
>  */
>  
>  /*
> -   Supports AMD756, AMD766, AMD768 and nVidia nForce
> +   Supports AMD756, AMD766, AMD768, AMD8111 and nVidia nForce
>     Note: we assume there can only be one device, with one SMBus interface.
>  */
>  
> @@ -308,12 +310,13 @@
>  	.name		= "unset",
>  };
>  
> -enum chiptype { AMD756, AMD766, AMD768, NFORCE };
> +enum chiptype { AMD756, AMD766, AMD768, NFORCE, AMD8111 };
>  
>  static struct pci_device_id amd756_ids[] = {
>  	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
>  	{PCI_VENDOR_ID_AMD, 0x7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD766 },
>  	{PCI_VENDOR_ID_AMD, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768 },
> +	{PCI_VENDOR_ID_AMD, 0x746B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD8111 },
>  	{PCI_VENDOR_ID_NVIDIA, 0x01B4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
>  	{ 0, }
>  };
> @@ -321,7 +324,8 @@
>  static int __devinit amd756_probe(struct pci_dev *pdev,
>  				  const struct pci_device_id *id)
>  {
> -	int nforce = (id->driver_data = NFORCE), error;
> +	int nforce = (id->driver_data = NFORCE);
> +	int error;
>  	u8 temp;
>  	
>  	if (amd756_ioport) {
> @@ -368,7 +372,7 @@
>  	amd756_adapter.dev.parent = &pdev->dev;
>  
>  	snprintf(amd756_adapter.name, I2C_NAME_SIZE,
> -		"SMBus AMD75x adapter at %04x", amd756_ioport);
> +		"SMBus AMD7xx adapter at %04x", amd756_ioport);
>  
>  	error = i2c_add_adapter(&amd756_adapter);
>  	if (error) {
> @@ -391,7 +395,7 @@
>  }
>  
>  static struct pci_driver amd756_driver = {
> -	.name		= "amd75x smbus",
> +	.name		= "amd7xx smbus",
>  	.id_table	= amd756_ids,
>  	.probe		= amd756_probe,
>  	.remove		= __devexit_p(amd756_remove),
> @@ -408,7 +412,7 @@
>  }
>  
>  MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
> -MODULE_DESCRIPTION("AMD756/766/768/nVidia nForce SMBus driver");
> +MODULE_DESCRIPTION("AMD756/766/768/8111 and nVidia nForce SMBus driver");
>  MODULE_LICENSE("GPL");
>  
>  module_init(amd756_init)
> 
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
