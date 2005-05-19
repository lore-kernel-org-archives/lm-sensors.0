From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [PATCH 2.6] add alternate VCORE calculations for w83627thf and
Message-Id: <20040606114834.2ec94571.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040606025430.GC10118@jupiter.solarsys.private>
In-Reply-To: <20040606025430.GC10118@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> +	/* Read VRM & OVT Config only once */
> +	if (w83627thf = data->type || w83637hf = data->type)
> +		data->vrm_ovt = 
> +			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
> +
>  	/* Convert VID to voltage based on default VRM */
>  	data->vrm = DEFAULT_VRM;

What about also using the VRM configuration bit to select the correct
data->vrm upon load for 627thf and 637hf (instead of default)? The code
could look like:

	/* Read VRM & OVT Config only once */
	if (w83627thf = data->type || w83637hf = data->type) {
		data->vrm_ovt = 
			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
		data->vrm = (data->vrm_ovt & 0x01) ? 90 : 82;
	} else {
		/* Convert VID to voltage based on default VRM */
		data->vrm = DEFAULT_VRM;
	}

(As a side note, I don't much see the interest of DEFAULT_VRM. Having
the same default for all chips doesn't make much sense since older chips
will most likely need VRM8 and newer chips will most likely need VRM9.
So I'd propose to get rid of that define and let every driver pick
whatever is relevant.)

Maybe it would also make sense to (physically) change this configuration
bit whenever the user changes VRM versions? We certainly want VID pins
and in0 reading to refer to the same VRM version.

Nice patch BTW, thanks :)

-- 
Jean Delvare
http://khali.linux-fr.org/
