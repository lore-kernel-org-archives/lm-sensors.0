From: Owl <owl@umail.ru>
Date: Thu, 14 Oct 2010 14:04:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Remove many EXPERIMENTAL flags
Message-Id: <4CB70DD1.9080009@umail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014103239.1096f962@endymion.delvare>
In-Reply-To: <20101014103239.1096f962@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

F71882FG still does not work properly.

f71882fg: Found f71862fg chip at 0x290, revision 18
ACPI: resource f71882fg [io  0x0290-0x0297] conflicts with ACPI region 
IP__ [??? 0x00000295-0x00000296 flags 0x5f]
ACPI: If an ACPI driver is available for this device, you should use it 
instead of the native driver

Guenter Roeck wrote:
> >  config SENSORS_F71882FG
> >  	tristate "Fintek F71858FG, F71862FG, F71882FG, F71889FG and F8000"
> > -	depends on EXPERIMENTAL
> > +	depends
>
> Empty depends line can be removed.
>
> Otherwise 
>
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
>
> Guenter
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensor

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
