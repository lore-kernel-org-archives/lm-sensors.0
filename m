From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 04 May 2006 03:24:23 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <445973E7.7020402@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thomas Andrews wrote:
> Hi Alex,
>
> On Wed, May 03, 2006 at 01:39:45PM +0200, Alexander Krause wrote:
>
>   
>> And I'm open for tests ;-)
>>     
>
> OK, I'm attaching a patch based on:
>
> /usr/src/linux-2.6.15/drivers/i2c/busses/scx200_acb.c
>
> This patch is to set up the base addresses automatically without
> probing (or guessing.)
>
> As I mentioned earlier the patch is untested because I am actually
> making the changes on a 2.4 kernel. Please let me know if *anything*
> goes wrong on 2.6. If it breaks, I will only be able to get a 2.6 dev
> system up next week to debug it :(
>
>   
This is premature, and hugely incomplete - (basically one observation)

Ill try to give it a go RSN   (FLW)

> +
> +	// Select ACB0 (LDN 5)
> +	outb(0x07,sio); // LDN select register
> +	outb(0x05,val); // Choose LDN 5 ie ACCESS.bus 1
> +	outb(0x60,sio); // Select I/O port 0 base addr
> +	h1 = inb(val);
> +	outb(0x61,sio);
> +	l1 = inb(val);
>   


please use these helper functions - lifted verbatim from another patch.
These show up in various superio drivers in lm-sensors, consistency is good,
and will help later if we need to mediate access to the SIO port,
to share it amongst multiple drivers.

+
+static inline void superio_outb(int reg, int val)
+{
+	outb(reg, SIO_REG_CIP);
+	outb(val, SIO_REG_DIP);
+}
+
+static inline int superio_inb(int reg)
+{
+	outb(reg, SIO_REG_CIP);
+	return inb(SIO_REG_DIP);
+}
+
+static inline void superio_select(int ldn)
+{
+	outb(SIO_VT1211_LDN, SIO_REG_CIP);
+	outb(ldn, SIO_REG_DIP);
+}
+
+static inline void superio_enter(void)
+{
+	outb(0x87, SIO_REG_CIP);
+	outb(0x87, SIO_REG_CIP);
+}
+
+static inline void superio_exit(void)
+{
+	outb(0xaa, SIO_REG_CIP);
+}


BTW - can anyone clarify when / why to use the _p variants,
and how they relate to barriers (mem & otherwize)


>  
>  static int  __init scx200_acb_create(int base, int index)
> @@ -508,6 +632,10 @@
>  {
>  	int i;
>   

At 1st, this looked like recursion.
I havent actually checked, but it would be nice if you used the -p option
   -p     Show which C function each change is in.

> +					if (acb1_base)
> +						rc = scx200_acb_create(acb1_base, 0);
> +					if (acb2_base)
> +						rc = scx200_acb_create(acb2_base, 1);
> +					sio = sioaddr[i];
> +					break; // No point looking further if the SIO was found
> +				}
> +			}
>   

and eventually, you'll probly need to do something about the nesting level.
// and the c++ comments. :-(

