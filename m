From: "Phil Endecott" <spam_from_lm_sensors@chezphil.org>
Date: Sat, 02 Jun 2007 21:57:49 +0000
Subject: Re: [lm-sensors] Jetway J7F2 with f71805: PWM not working
Message-Id: <1180821469906@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1180813726137@dmwebmail.belize.chezphil.org>
In-Reply-To: <1180813726137@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the quick reply.

Juerg Haefliger wrote:
> On 6/2/07, Phil Endecott <spam_from_lm_sensors@chezphil.org> wrote:
>> Finally, somewhat O.T., if it seems that I can't control the fan speed
>> on this board, can anyone suggest a "hardware hack"?  In the past I
>> have built fan speed controllers with thermisters and op-amps, but
>> something with software control would be better.
>
> That's fairly simple, typically a transistor between the fan and
> ground, controlled by the PWM controller. The hard part is to get to
> the components, especially on a Mini ITX board. You might have to
> solder wires to pins and lift pins and fun stuff like that.

Well this Fintek chip doesn't look too impossible; 1.27 mm pitch I guess.

The docs say that Fintek provided a datasheet; does someone have a copy 
of it that they could send me?  Or just let me know the pin numbers for 
the PWM outputs, and what sort of outputs they are?

> Alternatively, you could use a i2c PWM controller (that is of course
> supported by lm-sensors) and hook it up to the boards I2C bus, Mini
> ITX typically have it exposed on a header.

Yes, good idea, I'll investigate.  I don't suppose anyone knows of a 
ready-made module or anything like that?


Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
