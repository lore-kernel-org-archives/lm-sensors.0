From: jmunsin@iki.fi (Jonas Munsin)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: drivers/i2c/chips/it87.c cleanup patch
Message-Id: <20040608182240.GA8459@nemo.sby.abo.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040608161000.GA5071@nemo.sby.abo.fi>
In-Reply-To: <20040608161000.GA5071@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 08, 2004 at 07:10:00PM +0300, Jonas Munsin wrote:
> Attached is a cleanup patch for the it87 sensor driver, against
> 2.6.7-rc2. Jean Delvare has reviewed it.

> --- drivers/i2c/chips/it87.c.orig.2.6.7-rc2	2004-06-04 20:35:45.000000000 +0300
> +++ drivers/i2c/chips/it87.c	2004-06-08 18:56:43.000000000 +0300
> @@ -159,9 +159,9 @@
>  
>  #define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
>  
> -#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
> -					((val)+5)/10),0,255))
> -#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)
> +#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-500)/1000):\
> +					((val)+500)/1000),-127,127))

Oops, Jean pointed out that that could probably have been

+					((val)+500)/1000),-128,127))

instead (a slightly less arbitrary value). (Another copy/paste error
from lm85.c).

> +#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*1000)
>  
>  #define VID_FROM_REG(val) ((val)=0x1f?0:(val)>=0x10?510-(val)*10:\
>  				205-(val)*5)
