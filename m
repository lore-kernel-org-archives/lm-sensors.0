From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [PATCH 2.6] I2C: New hardware monitor driver: adm9240 (2nd try)
Message-Id: <c7hXRRDM.1114673394.4175490.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
In-Reply-To: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> +		for (i = 1; i < 6; i++) {
> +			adm9240_write_value(client,
> +					ADM9240_REG_IN_MIN(i), 0);
> +			adm9240_write_value(client,
> +					ADM9240_REG_IN_MAX(i), 255);
> +		}

Shouldn't i start from 0 here?

> +		/* start measurement cycle */
> +		adm9240_write_value(client, ADM9240_REG_CONFIG, 1);

I'm sorry but I'm still not quite happy with this. You want to change
one bit and end up writing 8. What about something along the lines of:

	reg = adm9240_read_value(client, ADM9240_REG_CONFIG);
	adm9240_write_value(client, ADM9240_REG_CONFIG,
		(reg | 0x01) & 0x7f);

That way you really only set the bits which need be.

Thanks,
--
Jean Delvare
