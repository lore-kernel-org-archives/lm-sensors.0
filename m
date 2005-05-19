From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <20040703090153.77086891.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It's still confidence 3 there, you forgot this:
> 
> --- sensors-detect.old  2004-07-03 00:40:51.000000000 +0200
> +++ sensors-detect      2004-07-03 00:42:32.000000000 +0200
> @@ -2922,10 +2922,15 @@
>      or (($low >> 12) != 0 && ($low >> 12) != 0xf)
>      or (($high >> 12) != 0 && ($high >> 12) != 0xf);
> 
> +  $cur /= 16;
> +  $hyst /= 16;
> +  $os /= 16;
> +  $high /= 16;
> +  $low /= 16;
> 
>    # Most probable value ranges
>    return 6 if $cur <= 100 and $hyst <= 40
> -    and ($os >= 20 && $os <= 127) and ($high >= 20 && $os <= 127);
> +    and ($os >= 20 && $os <= 127) and ($high >= 20 && $high <= 127);
>    return 3;
>  }

Ahhh correct, I missed these. Thanks for the fix, I applied it. If you
get confidence 6 with this changes, it's all OK.

Next steps:
1* Update detection in lm75 driver and docs (CVS/2.4).
2* Update detection in lm75 driver and docs (2.6).
3* Complete your lm77 driver and submit it for integration into Linux 2.6.

Thanks :) (and have a good week-end!)

-- 
Jean Delvare
http://khali.linux-fr.org/
