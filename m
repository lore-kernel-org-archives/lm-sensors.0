From: quintela@mandrakesoft.com (Juan Quintela)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: [PATCH] 2/4 WIP I2C kernel patches-core
Message-Id: <m2k7q5bxe4.fsf@demo.mitica>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CE20AF5.5F55E3D4@bellsouth.net>
In-Reply-To: <3CE20AF5.5F55E3D4@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "albert" = Albert Cranford <ac9410@bellsouth.net> writes:

Hi

Some commets.


albert> memset(adapters,0,sizeof(adapters));
albert> memset(drivers,0,sizeof(drivers));
albert> adap_count=0;
albert> @@ -1284,13 +1319,13 @@
albert> #ifdef CONFIG_I2C_ALGOBIT
albert> extern int i2c_algo_bit_init(void);
albert> #endif
albert> -#ifdef CONFIG_I2C_PHILIPSPAR
albert> +#ifdef CONFIG_I2C_BITLP
albert> extern int i2c_bitlp_init(void);
albert> #endif
albert> -#ifdef CONFIG_I2C_ELV
albert> +#ifdef CONFIG_I2C_BITELV
albert> extern int i2c_bitelv_init(void);
albert> #endif
albert> -#ifdef CONFIG_I2C_VELLEMAN
albert> +#ifdef CONFIG_I2C_BITVELLE
albert> extern int i2c_bitvelle_init(void);
albert> #endif
albert> #ifdef CONFIG_I2C_BITVIA
albert> @@ -1300,7 +1335,7 @@
albert> #ifdef CONFIG_I2C_ALGOPCF
albert> extern int i2c_algo_pcf_init(void);     
albert> #endif
albert> -#ifdef CONFIG_I2C_ELEKTOR
albert> +#ifdef CONFIG_I2C_PCFISA
albert> extern int i2c_pcfisa_init(void);
albert> #endif
 
albert> @@ -1329,13 +1364,13 @@
albert> #ifdef CONFIG_I2C_ALGOBIT
albert> i2c_algo_bit_init();
albert> #endif
albert> -#ifdef CONFIG_I2C_PHILIPSPAR
albert> +#ifdef CONFIG_I2C_BITLP
albert> i2c_bitlp_init();
albert> #endif
albert> -#ifdef CONFIG_I2C_ELV
albert> +#ifdef CONFIG_I2C_BITELV
albert> i2c_bitelv_init();
albert> #endif
albert> -#ifdef CONFIG_I2C_VELLEMAN
albert> +#ifdef CONFIG_I2C_BITVELLE
albert> i2c_bitvelle_init();
albert> #endif
 
albert> @@ -1343,7 +1378,7 @@
albert> #ifdef CONFIG_I2C_ALGOPCF
albert> i2c_algo_pcf_init();    
albert> #endif
albert> -#ifdef CONFIG_I2C_ELEKTOR
albert> +#ifdef CONFIG_I2C_PCFISA
albert> i2c_pcfisa_init();
albert> #endif

Put that changes with the Config.in changes

albert> @@ -1410,7 +1447,9 @@
albert> MODULE_DESCRIPTION("I2C-Bus main module");
albert> MODULE_PARM(i2c_debug, "i");
albert> MODULE_PARM_DESC(i2c_debug,"debug level");
albert> +#ifdef MODULE_LICENSE
albert> MODULE_LICENSE("GPL");
albert> +#endif
 
That is a nono in the kernel, in 2.4 & 2.5 MODULE_LICENSE() is
guaranteed to exit.

 
albert> #ifdef DEBUG
albert> -       printk("i2c-dev.o: Closed: i2c-%d\n", minor);
albert> +       printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
albert> #endif
albert> #if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
albert> MOD_DEC_USE_COUNT;
albert> +#else /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
albert> +       lock_kernel();
albert> #endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
albert> if (i2cdev_adaps[minor]->dec_use)
albert> i2cdev_adaps[minor]->dec_use(i2cdev_adaps[minor]);
albert> +#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
albert> +       unlock_kernel();
albert> +#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
albert> return 0;
albert> }

That can be rewrite to 

        kfree(file->private_data);
        file->private_data=NULL;
 #ifdef DEBUG
-       printk("i2c-dev.o: Closed: i2c-%d\n", minor);
+       printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
 #endif
        lock_kernel();
        if (i2cdev_adaps[minor]->dec_use)
                i2cdev_adaps[minor]->dec_use(i2cdev_adaps[minor]);
        unlock_kernel();
        return 0;
 }


I.e. remove the compat code.  Anyways, I am not sure _at_ all that the
change is right.  without it, they can remove the module while wating
:(


 
albert> MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
albert> MODULE_DESCRIPTION("I2C /dev entries driver");
albert> +#ifdef MODULE_LICENSE
albert> MODULE_LICENSE("GPL");
albert> +#endif
 
You don't need that.

albert> static int i2c_proc_chips(ctl_table * ctl, int write,
albert> struct file *filp, void *buffer,
albert> size_t * lenp);
albert> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,19)) && \
albert> +    (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
albert> +static int i2c_sysctl_chips(ctl_table * table, int *name, unsigned nlen,
albert> +                               void *oldval, size_t * oldlenp,
albert> +                               void *newval, size_t newlen,
albert> +                               void **context);
albert> +#else
albert> static int i2c_sysctl_chips(ctl_table * table, int *name, int nlen,
albert> void *oldval, size_t * oldlenp,
albert> void *newval, size_t newlen,
albert> void **context);
albert> +#endif /* 2.2.19+ */

2.2 code in 2.5 is considered cruft.
 
albert> int __init sensors_init(void);
 
albert> @@ -119,10 +121,6 @@
albert> sprintf(name_buffer, "%s-i2c-%d-%02x", prefix, id, addr);
albert> }
albert> *name = kmalloc(strlen(name_buffer) + 1, GFP_KERNEL);
albert> -       if (!*name) {
albert> -               printk (KERN_WARNING "i2c_create_name: not enough memory\n");
albert> -               return -ENOMEM;
albert> -       }
albert> strcpy(*name, name_buffer);
albert> return 0;
albert> }
albert> @@ -180,9 +178,10 @@

You can't take that out, you need to check kmallocs return.
 
albert> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,19)) && \
albert> +    (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
albert> +int i2c_sysctl_chips(ctl_table * table, int *name, unsigned nlen,
albert> +                        void *oldval, size_t * oldlenp, void *newval,
albert> +                        size_t newlen, void **context)
albert> +#else
albert> int i2c_sysctl_chips(ctl_table * table, int *name, int nlen,
albert> void *oldval, size_t * oldlenp, void *newval,
albert> size_t newlen, void **context)
albert> +#endif /* 2.2.19+ */
albert> {
albert> struct i2c_chips_data data;
albert> int i, oldlen, nrels, maxels,ret=0;
albert> @@ -415,9 +421,16 @@
 
albert> /* This function is equivalent to i2c_proc_real, only it interacts with
albert> the sysctl(2) syscall, and returns no reals, but integers */
albert> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,19)) && \
albert> +    (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
albert> +int i2c_sysctl_real(ctl_table * table, int *name, unsigned nlen,
albert> +                       void *oldval, size_t * oldlenp, void *newval,
albert> +                       size_t newlen, void **context)
albert> +#else
albert> int i2c_sysctl_real(ctl_table * table, int *name, int nlen,
albert> void *oldval, size_t * oldlenp, void *newval,
albert> size_t newlen, void **context)
albert> +#endif /* 2.2.19+ */
albert> {
albert> long results[MAX_RESULTS];
albert> int oldlen, nrels = MAX_RESULTS,ret=0;

Compat code, will not enter there.

 
albert> MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
albert> MODULE_DESCRIPTION("i2c-proc driver");
albert> +#ifdef MODULE_LICENSE
albert> MODULE_LICENSE("GPL");
albert> +#endif
 
Remove that part.

albert> found.
albert> In all cases, client points to the client we wish to interact with,
albert> and ctl_name is the SYSCTL id of the file we are accessing. */
albert> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,19)) && \
albert> +    (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
albert> +extern int i2c_sysctl_real(ctl_table * table, int *name, unsigned nlen,
albert> +                              void *oldval, size_t * oldlenp,
albert> +                              void *newval, size_t newlen,
albert> +                              void **context);
albert> +#else
albert> extern int i2c_sysctl_real(ctl_table * table, int *name, int nlen,
albert> void *oldval, size_t * oldlenp,
albert> void *newval, size_t newlen,
albert> void **context);
albert> +#endif /* 2.2.19+ */

You are not going to get that code in, this is compat code, and it is
not needed for 2.5, for 2.5 the only thing that it is needed is the
one that is there.



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
