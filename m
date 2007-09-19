From: Krzysztof Helt <krzysztof.h1@gmail.com>
Date: Wed, 19 Sep 2007 13:31:40 +0000
Subject: Re: [lm-sensors] Missing thmc50 support in sensors
Message-Id: <20070919153140.048daecc.krzysztof.h1@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070906130600.028cf7f5@hyperion.delvare>
In-Reply-To: <20070906130600.028cf7f5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, 19 Sep 2007 14:01:29 +0200
Philippe Michiels <philippe@michiels.nu> wrote:

> 
> Hey Jean, Krzysztof,
> 
> 
> 
> Isengard:~/lm-sensors-r4800-20070918# sensors
> 
> adm1022-i2c-0-2e
> 
> Adapter: SMBus I801 adapter at fc00
> 
> temp:        +22°C  (low  =  -128°C, high =  +127°C)  
> 
> remote_temp:
> 
>              +32°C  (low  =  -127°C, high =   +59°C)  
> 
> remote_temp2:
> 
>               +0°C  (low  =    +0°C, high =    +0°C)  
> 
> 
> 
[..] 
> Am I using the right version here ?
> 
> 

Yes. The Jean's new patch removes remote_temp2 (from the kernel driver)
as it is probably not connected on you motherboard.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
