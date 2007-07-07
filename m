From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2007 18:36:11 +0000
Subject: Re: [lm-sensors] add f71882fg sensors.conf.eg entry
Message-Id: <20070707203611.7fc66d12@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

>       Author: jwrdegoede
>         Date: Sat Jul  7 18:57:07 2007
> New Revision: 4580
>    Changeset: http://lm-sensors.org/changeset/4580
> 
> Modified:
>    lm-sensors/branches/lm-sensors-3.0.0/etc/sensors.conf.eg
> 
> Log:
> add f71882fg sensors.conf.eg entry

> +# Fans
> +    label fan1        "CPU"
> +    ignore fan2
> +    ignore fan3
> +    ignore fan4

I don't think that having ignore statements by default is a very good
idea. I can already hear users asking on the mailing list where are
their missing fan values. The entries in sensors.conf.eg should be
relatively generic. If you have a good configuration file for your
motherboard, better add it to the wiki.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
