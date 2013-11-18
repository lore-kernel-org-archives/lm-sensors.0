From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Nov 2013 22:39:51 +0000
Subject: Re: [lm-sensors] Ticket #2382
Message-Id: <20131118223951.GA6264@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <528A62DC.9030107@baymicrosystems.com>
In-Reply-To: <528A62DC.9030107@baymicrosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

What Atom chip ? Can you provide output of /proc/cpuinfo ?

Thanks,
Guenter

On Mon, Nov 18, 2013 at 01:56:28PM -0500, Mike Gilbert wrote:
> 
> Do you have any additional information pertaining to ticket 2382?
> 
> The CPU card we use in our products is going end-of-life. The CPU
> card vendor send us a new card that is supposed to be a drop in
> replacement (it's the same card with a newer Atom chip). The new
> card returns an error when reading the coretemp:
> 
>    # cat /sys/bus/platform/devices/coretemp.0/temp2_input
>    cat: read error: Resource temporarily unavailable
>    #
> 
> Some printk debugging yields:
> 
>    ENTER show_temp
>    status_reg @ 19C
>    eax = 8620000 edx = 0
>    temp = 0 valid = 0
>    EXIT show_temp
> 
> This looks like the same issue described in your ticket 2382.
> 
> Any information you can provide will be appreciated.
> 
> Mike Gilbert
> Principle Engineer
> Bay Microsystems, Inc.
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
