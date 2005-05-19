From: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [patch 2/9]Four new i2c drivers and __init/__exit cleanup to
Message-Id: <3D85F3E3.2050208@mandrakesoft.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D85E7E8.5EEC1499@attbi.com>
In-Reply-To: <3D85E7E8.5EEC1499@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Albert Cranford wrote:
> -#ifdef MODULE_LICENSE
>  MODULE_LICENSE("GPL");
> -#endif

This change requires that you define MODULE_LICENSE in a kernel 
compatibility header, for 2.2.

It will work without such assistance in 2.4 and 2.5.


>  #define DEFAULT_BASE 0x378
>  static int base=0;
> @@ -112,9 +110,7 @@
>  
>  static int bit_pport_init(void)
>  {
> -       //release_region( (base+2) ,1);
> -
> -       if (check_region((base+2),1) < 0 ) {
> +       if (request_region((base+2),1, "i2c (PPORT adapter)") < 0 ) {
>                 return -ENODEV; 
>         } else {
>  

request_region returns non-zero on success...


> @@ -148,11 +144,6 @@
>         return 0;
>  }
>  
> -static void __exit bit_pport_exit(void)
> -{
> -       release_region((base+2),1);
> -}
> -
>  static int bit_pport_reg(struct i2c_client *client)
>  {
>         return 0;
> @@ -231,24 +222,16 @@
>  }
>  
>  
> -EXPORT_NO_SYMBOLS;

Why remove export-no-symbols?


> +static void __exit i2c_bitpport_exit(void)
> +{
> +       i2c_bit_del_bus(&bit_pport_ops);
> +       release_region((base+2),1);
> +}
>  
> -#ifdef MODULE
>  MODULE_AUTHOR("Daniel Smolik <marvin@sitour.cz>");
>  MODULE_DESCRIPTION("I2C-Bus adapter routines for Primitive parallel port adapter")
>  ;
> -
>  MODULE_PARM(base, "i");
>  
> -int init_module(void)
> -{
> -       return i2c_bitpport_init();
> -}
> -
> -void cleanup_module(void)
> -{
> -       i2c_bit_del_bus(&bit_pport_ops);
> -       bit_pport_exit();
> -}
> -
> -#endif
> +module_init(i2c_bitpport_init);
> +module_exit(i2c_bitpport_exit);


This looks ok to me.
