From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 01 Nov 2013 21:09:20 +0000
Subject: Re: [lm-sensors] w83795.c no longer compiles
Message-Id: <20131101210920.GA18305@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5273CD89.6030803@gmail.com>
In-Reply-To: <5273CD89.6030803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 01, 2013 at 08:49:29AM -0700, David Anderson wrote:
> Just installed the new Ubuntu 13.10.   Kernel 3.11.0-12 #19.
> I get an error building w83795.c (building a module to read
> my  w83795adg temp sensor) for this kernel.
> 
> The source is from
> http://khali.linux-fr.org/devel/lm-sensors/drivers/w83795/
> and has been working for quite a while ... but not with this new kernel
> series (it was  a 3.8.0 kernel in Ubuntu 13.04 and worked fine there).
> 
> The error:
>       'implicit declaration of function 'SENSORS LIMIT' '
> at, for example,
> 
>      return SENSORS_LIMIT((val + 50) / 100, 0, 0xff);
> 
SENSORS_LIMIT no longer exists; replace it with clamp_val.

Is the driver in the upstream kernel different to the version above ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
