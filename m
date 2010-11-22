From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Nov 2010 09:41:49 +0000
Subject: Re: [lm-sensors] Need help to fix some issues with the linux driver
Message-Id: <20101122104149.0dc67e43@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CEA44D2020000AA00007F74@center.bmk-electronics.de>
In-Reply-To: <4CEA44D2020000AA00007F74@center.bmk-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthias,

On Mon, 22 Nov 2010 10:24:18 +0100, Matthias Zacharias wrote:
> Hello mailing list,
>  
> we have to use the linux driver "i2c-gpio" because the "i2c-at91" is
> marked as "BROKEN" and for our application it can as well not be used.

You are writing to the wrong mailing list. I2C issues are discussed on
the linux-i2c (@vger.kernel.org) list.

> (...)
> Note: The LM84 sensors are not yet operated by the linux kernel.

The LM84 is supported by the adm1021 driver for years.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
