From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Dec 2005 21:35:01 +0000
Subject: [lm-sensors] [PATCH 2/7] i2c: scx200_acb - debug log cleanup
Message-Id: <20051219223501.4a1fb395.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191051u6f7c0b38k2c9843a6baed00bf@mail.gmail.com>
In-Reply-To: <808c8e9d0512191051u6f7c0b38k2c9843a6baed00bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> scx200_acb debug log cleanup.

> @@ -413,7 +408,7 @@ static int scx200_acb_probe(struct scx20
>  	outb(0x70, ACBCTL2);
>  
>  	if (inb(ACBCTL2) != 0x70) {
> -		DBG("ACBCTL2 readback failed\n");
> +		dev_dbg(&iface->adapter.dev, "ACBCTL2 readback failed\n");
>  		return -ENXIO;
>  	}
>  
> @@ -421,7 +416,8 @@ static int scx200_acb_probe(struct scx20
>  
>  	val = inb(ACBCTL1);
>  	if (val) {
> -		DBG("disabled, but ACBCTL1=0x%02x\n", val);
> +		dev_dbg(&iface->adapter.dev, "disabled, but ACBCTL1=0x%02x\n",
> +			val);
>  		return -ENXIO;
>  	}
>  
> @@ -431,7 +427,9 @@ static int scx200_acb_probe(struct scx20
>  
>  	val = inb(ACBCTL1);
>  	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
> -		DBG("enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n", val);
> +		dev_dbg(&iface->adapter.dev,
> +			"enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n",
> +			val);
>  		return -ENXIO;
>  	}

On second thought, these ones are probably not correct:
scx200_acb_probe is called before i2c_add_adapter, so the adapter's
device isn't properly setup at this point. You have to use pr_debug
instead of dev_dbg.

This also means that the uses of dev_err and dev_warn in
scx200_acb_create are not correct either, and should be changed to
boring printk calls.

-- 
Jean Delvare

