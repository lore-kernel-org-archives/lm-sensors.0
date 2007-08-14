From: "Boyd Noorda" <boyd2006@sociamedia.nl>
Date: Tue, 14 Aug 2007 16:55:50 +0000
Subject: Re: [lm-sensors] #2234: Can Lm-sensors calculate power use?
Message-Id: <46C1FAB6.9627.200313@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm quite surprised to find that the tickets are online on the web 
site, including E-mail addresses ...
This always leads to more spam, often within a day.
Could you please refrain from publishing E-mail addresses or construct 
an archive bots can't access?

Thanks,
Boyd Noorda

> #2234: Can Lm-sensors calculate power use?
> -------------------------------------+----------------------------------
> ----
>   Reporter:  boyd2006@sociamedia.nl  |       Owner:  khali             
>       Type:  enhancement             |      Status:  assigned          
>   Priority:  major                   |   Milestone:                    
>  Component:  hardware                |     Version:                   
> Resolution:                          |    Keywords:  CPU/HD power usage
> -------------------------------------+----------------------------------
> ---- Changes (by khali):
> 
>  * cc: boyd2006@sociamedia.nl (removed)
>   * owner:  somebody => khali
>   * status:  new => assigned
>   * reporter:  ticket => boyd2006@sociamedia.nl
> 
> Comment:
> 
>  No, lm_sensors can't be used to compute power consumption. We'd need to
>  know how much current is drawn on every power line, but hardware
>  monitoring chips don't measure this value.
> 
>  I use an external device to measure how much power my systems consume.
>  It's named Voltcraft Energy Check 3000, google for it if interested.
>  You simply plug any device in it and it gives you the power
>  consumption, very handy. That won't necessarily be very practical for
>  production use though, as it is external to the system.
> 
> -- 
> Ticket URL: <http://lm-sensors.org/ticket/2234#comment:1>
> lm-sensors <http://lm-sensors.org/>
> Linux hardware monitoring



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
