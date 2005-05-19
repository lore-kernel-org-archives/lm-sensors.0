From: adaplas@hotpop.com (Antonino A. Daplas)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <200503180411.04839.adaplas@hotpop.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 18 March 2005 03:10, Jean Delvare wrote:
> Hi Tony, hi all,
> I think I found the problem. If count is less than in_row1, bad things
> will happen with the code above. Shame on me for not noticing when I
> wrote it in the first place.
>
> Suggested fix would be:
>
> --- linux-2.6.11.4/drivers/i2c/chips/eeprom.c.orig	2005-03-13
> 10:00:01.000000000 +0100 +++
> linux-2.6.11.4/drivers/i2c/chips/eeprom.c	2005-03-17 19:54:07.000000000
> +0100 @@ -130,7 +130,8 @@
>
>  	/* Hide Vaio security settings to regular users (16 first bytes) */
>  	if (data->nature = VAIO && off < 16 && !capable(CAP_SYS_ADMIN)) {
> -		int in_row1 = 16 - off;
> +		size_t in_row1 = 16 - off;
> +		in_row1 = min(in_row1, count);
>  		memset(buf, 0, in_row1);
>  		if (count - in_row1 > 0)
>  			memcpy(buf + in_row1, &data->data[16], count - in_row1);
>
>
> Please test and report.
>

Tested on nvidiafb.  No more hang, thanks.

I can test on savagefb too, if you want, but I expect the same result.

Tony


