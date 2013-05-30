From: SZENTE Balint <balint@szentedwg.ro>
Date: Thu, 30 May 2013 15:26:45 +0000
Subject: Re: [lm-sensors] Configuration file for Intel DN2800MT mini-ITX board
Message-Id: <20130530182645.40d65f51@obraro.integrasoft.ro>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130424092937.3fb1e7a4@obraro.integrasoft.ro>
In-Reply-To: <20130424092937.3fb1e7a4@obraro.integrasoft.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm sorry, I made a mistake in the configuration file:

> set     in1_max        13 * 1.05
                         ^^
    should be 12, obviously.

On Thu, 30 May 2013 16:15:24 +0300
SZENTE Balint <balint@szentedwg.ro> wrote:

> Hello Jean!
> 
> 
> Please find attached the configuration file, that has corrected
> voltage limits. The motherboard has a soldered Intel Atom N2800.
> 
> I checked the followings:
>  1. Intrusion is missing from the motherboard
>  2. Vcore for N2800. It has Speedstep, so the Lowest Frequency Mode
>     voltage is 0.75V (see my previous mail with D2500)
> 
> The motherboard has two Fan connectors: CPU & System. The system that
> I have is completely fanless, so I could not identify the
> corresponding fan inputs, so I let the 5 fan inputs as they are by
> default.
> 
> Please add this motherboard as well to the Wiki. Thank you.
> 
> Regards,
> Balint

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
