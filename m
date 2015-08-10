From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 10 Aug 2015 08:24:00 +0000
Subject: Re: [lm-sensors] [PATCH] mention sensors-detect(8) in sensors(1)
Message-Id: <20150810102400.4929b1e7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150809100411.GB8036@aurel32.net>
In-Reply-To: <20150809100411.GB8036@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 9 Aug 2015 12:04:11 +0200, Aurelien Jarno wrote:
> sensors-detect is a useful tool, but some users might be unware of it.
> Mention it in the sensors(1) manpage.
> 
> --- a/prog/sensors/sensors.1
> +++ b/prog/sensors/sensors.1
> @@ -87,7 +87,7 @@ for further details.
>  .RE
>  
>  .SH SEE ALSO
> -sensors.conf(5)
> +sensors.conf(5), sensors-detect(8).
>  
>  .SH AUTHOR
>  Frodo Looijaard and the lm_sensors group

Good idea. Applied, thanks.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
