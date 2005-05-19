From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <1075739614.401e7bde54686@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please CC: the mailing-list on reply.]

Hi Gunn,

> I have attached the latest patch against rc3.  I have fixed up all
> that
> we have discussed on sunday.  In particular:
> * BOOL and RAW macros
> * voltage rounding
> * fan speed calculation
> * beep_mask for fan_min=0
> * driver init code
> 
> Hopefully the code is ready now.  *phew*
> 
> Let me know what you think.

Looks very good overall. A few comments though:

> -#define IN_TO_REG(val)       (SENSORS_LIMIT((((val)+8)/19),0,255))
> +#define IN_TO_REG(val)       (SENSORS_LIMIT((((val)+9)/19),0,255))

Nice catching, I had missed that one ;)

> +#define VDD_FROM_REG(val)        ((val)*95/4)

(((val)*95+2)/4)?

> +        /* Comparator mode (D3=0), standby mode (D6=0) */
> +        gl518_write_value(client, GL518_REG_CONF, 0xb7 & regvalue);

I'd suggest 0x37 as the mask. D7 is something we don't want to set to 1.
I agree it doesn't change anything practically. Just looks safer.

> +        /* Clear status register (D5=1), start (D6=1) */
> +        gl518_write_value(client, GL518_REG_CONF, 0x20 | regvalue);
> +        gl518_write_value(client, GL518_REG_CONF, 0x40 | regvalue);

It works, but isn't correct. At this point, regvalue doesn't hold the
current configuration register. I suggest we use (regvalue &= 0x37) in
the first gl518_write_value() call above, so that it does.

The rest is OK, will apply and send the driver to Greg KH ASAP. No need
for you to resend a patch, I'll do the changes myself, unless you or
anyone have an objection.

Great job you did :) Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
