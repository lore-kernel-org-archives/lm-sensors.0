From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: i2c-sis645.c patch (Experimental SiS 655 support)
Message-Id: <40720F69.2000200@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4063CA9F@webmail.ucc.ie>
In-Reply-To: <4063CA9F@webmail.ucc.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

applied
thanks

Kenneth Bernard Healy wrote:
> This patch experimentally enables SiS 655 support by the i2c-sis645 driver.
> 
> It simply modifies the driver to also accept the SiS 655 as a valid host 
> bridge.
> 
> Partially tested on a Gigabyte GA-SINXP1394 (SiS655/963), no problems so far. 
> Driver successfully enables the SMBus controller, i2cdetect finds the usual 
> devices, and i2cdump successfully reads the DIMM SPD eeprom's.
> 
> The patch is against the lm_sensors-2.8.5 release.
> 
> --
> Ken Healy
> --
> 
> 
> 
> ------------------------------------------------------------------------
> 
> diff -urN i2c-sis645.c.orig i2c-sis645.c > i2c-sis645.patch
> --- i2c-sis645.c.orig	2003-08-03 06:11:58.000000000 +0100
> +++ i2c-sis645.c	2004-03-29 00:36:30.000000000 +0100
> @@ -30,6 +30,14 @@
>      http://www2.lm-sensors.nu/~lm78/download.html
>  */
>  
> +/* 25th March 2004
> +     Experimental support for Sis655 chipsets added by Ken Healy
> +     <km.healy@rstudent.mu.ccm.ie> | tr -d .@ | tr r @ | tr m .
> +
> +     Works on Gigabyte GA-SINXP1394 motherboard. Not fully tested, but
> +     no problems so far.
> +*/
> +
>  /*
>      Note: we assume there can only be one SiS645 with one SMBus interface
>  */
> @@ -71,6 +79,11 @@
>  #define PCI_DEVICE_ID_SI_651 0x0651
>  #endif
>  
> +/* SiS655 north bridge (defined in 2.4.22)*/
> +#ifndef PCI_DEVICE_ID_SI_655
> +#define PCI_DEVICE_ID_SI_655 0x0655
> +#endif
> +
>  /* SiS746 north bridge (defined in 2.4.21) */
>  #ifndef PCI_DEVICE_ID_SI_746
>  #define PCI_DEVICE_ID_SI_746 0x0746
> @@ -261,6 +274,8 @@
>  			&& (NULL = pci_find_device(PCI_VENDOR_ID_SI,
>  				PCI_DEVICE_ID_SI_651, NULL))
>  			&& (NULL = pci_find_device(PCI_VENDOR_ID_SI,
> +				PCI_DEVICE_ID_SI_655, NULL))
> +			&& (NULL = pci_find_device(PCI_VENDOR_ID_SI,
>  				PCI_DEVICE_ID_SI_735, NULL))
>  			&& (NULL = pci_find_device(PCI_VENDOR_ID_SI,
>  				PCI_DEVICE_ID_SI_745, NULL))
