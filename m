From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH] automatic VRM detection part2
Message-Id: <20040804022927.GA4844@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0407221043150.6769@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0407221043150.6769@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf:

* Rudolf Marek <R.Marek@sh.cvut.cz> [2004-07-22 10:51:24 +0200]:
> 
> Hello,
> 
> This is second part, which just adds the functionality to existing code
> base, also including support of vid inputs for it8712 chip.

<snip>

One small comment:

> @@ -959,7 +956,7 @@
> 
>  	vid = asb100_read_value(client, ASB100_REG_VID_FANDIV) & 0x0f;
>  	vid |= (asb100_read_value(client, ASB100_REG_CHIPID) & 0x01) << 4;
> -	data->vrm = ASB100_DEFAULT_VRM;
> +	data->vrm = i2c_which_vrm();
>  	vid = vid_from_reg(vid, data->vrm);
> 
>  	/* Start monitoring */
> diff -Naur d/drivers/i2c/chips/it87.c c/drivers/i2c/chips/it87.c

Why not this instead?  E.g.

	if (!(data->vrm = i2c_which_vrm()))
		data->vrm = ASB100_DEFAULT_VRM;

That way, non x86 or some x86 that isn't recognized might fall back
and still get it right, or at least work the same as it used to.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
