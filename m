From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Mar 2007 11:32:23 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070302123223.457681ef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 01 Mar 2007 18:34:54 +0100, corentin.labbe wrote:
> Instead of declaring four static DEVICE_ATTR(fan1, S_IRUGO, get_fan1, NULL);
> I'm suggest you to use
> static SENSOR_DEVICE_ATTR(fan1, S_IRUGO, get_fan, NULL,1);
> static SENSOR_DEVICE_ATTR(fan2, S_IRUGO, get_fan, NULL,2);
> etc....
> 
> secondly in /Documentation/hwmon/max6650 you have a wrong prefix
> +Supported chips:
>  > +  * Maxim 6650 / 6651
>  > +    Prefix: 'w83792d'
> 
> and 2 typos errors
> (but and not bit)
> -> bit the Maxim 6550 has a reduced feature
> 
> 6550 not 6650
>  > +  * Maxim 6650 / 6651
>  > +    Prefix: 'w83792d'

Actually, the other way around: 6650 is correct and 6550 is the typo.

Thanks for this second review Corentin.

Hans-J?rgen, care to post an updated version of your driver? Hopefully
we're not too far from a final version now.

-- 
Jean Delvare

