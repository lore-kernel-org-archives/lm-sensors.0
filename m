From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 24 Mar 2011 09:52:01 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (f71882fg) Document all
Message-Id: <20110324095201.GB16921@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110323215004.5b9ab7b0@endymion.delvare>
In-Reply-To: <20110323215004.5b9ab7b0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, Mar 24, 2011 at 03:30:36AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
[ ... ]
>  
>  config SENSORS_F71882FG
> -	tristate "Fintek F71858FG, F71862FG, F71882FG, F71889FG and F8000"
> +	tristate "Fintek F71882FG and compatibles"
>  	help
>  	  If you say yes here you get support for hardware monitoring
> -	  features of the Fintek F71858FG, F71862FG/71863FG, F71882FG/F71883FG,
> -	  F71889FG and F8000 Super-I/O chips.
> +	  features of many Fintek Super-I/O (LPC) chips. The currently
> +	  supported chips are:
> +	    F71808E
> +	    F71858FG
> +	    F71862FG
> +	    F71863FG
> +	    F71869F/E
> +	    F71882FG
> +	    F71883FG
> +	    F71889FG/ED
> +	    F8000
> +	    F81801U
>  
I meant something like
	    F71808E, F71858FG, F71862FG, F71863FG, F71869F/E, F71882FG,
	    F71883FG, F71889FG/ED, F8000, F81801U

but yes, the above is ok as well.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
