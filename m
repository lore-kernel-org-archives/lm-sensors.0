From: lmsensors@eltofts.homelinux.com (Andy Wright)
Date: Fri, 02 Mar 2007 17:22:50 +0000
Subject: [lm-sensors] Asus P4R800-VM with w83627THF sensor
Message-Id: <45E85D6A.6040402@eltofts.homelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45B2BB3B.4000603@eltofts.homelinux.com>
In-Reply-To: <45B2BB3B.4000603@eltofts.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Support for the secondary Super-I/O address was added to the w83627hf
> driver in kernel 2.6.11. This is the reason why it doesn't work with
> your 2.6.9 kernel. You will need to backport the following patch:
>
> --- linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c.orig	2004-12-19 12:14:44.000000000 +0100
> +++ linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c	2004-12-19 12:55:31.000000000 +0100
> @@ -67,9 +67,9 @@
>  MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
>  
>  /* modified from kernel/include/traps.c */
> -#define	REG	0x2e	/* The register to read/write */
> +static int REG;		/* The register to read/write */
>  #define	DEV	0x07	/* Register: Logical device select */
> -#define	VAL	0x2f	/* The value to read/write */
> +static int VAL;		/* The value to read/write */
>  
>  /* logical device numbers for superio_select (below) */
>  #define W83627HF_LD_FDC		0x00
> @@ -938,10 +938,13 @@
>  	return i2c_detect(adapter, &addr_data, w83627hf_detect);
>  }
>  
> -static int w83627hf_find(int *address)
> +static int w83627hf_find(int sioaddr, int *address)
>  {
>  	u16 val;
>  
> +	REG = sioaddr;
> +	VAL = sioaddr + 1;
> +
>  	superio_enter();
>  	val= superio_inb(DEVID);
>  	if(val != W627_DEVID &&
> @@ -1422,7 +1425,8 @@
>  {
>  	int addr;
>  
> -	if (w83627hf_find(&addr)) {
> +	if (w83627hf_find(0x2e, &addr)
> +	 && w83627hf_find(0x4e, &addr)) {
>  		return -ENODEV;
>  	}
>  	normal_isa[0] = addr;
>
>
>   

Thanks for that Jean,

I'm trying a 2.6.20 kernel at the moment.... looking good so far.

Andy.

