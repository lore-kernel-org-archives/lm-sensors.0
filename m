From: John Rippetoe <jrippetoe@comconcepts.com>
Date: Fri, 10 Aug 2012 12:31:42 +0000
Subject: Re: [lm-sensors] Output problem with adcxx  on at91
Message-Id: <i3byt348kxfgomxa77qcn6l5.1344601017566@email.android.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5019526C.2030802@comconcepts.com>
In-Reply-To: <5019526C.2030802@comconcepts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marc,

No problem at all, better for it to be accessible to others in case they run across similar issues. 

No kidding? As far as I know the at91rm9200 is essentially the grandfather of the at91sam9g20 I am using now; similar design but two revisions older. 

As of yesterday afternoon I myself have begun to suspect there could be a problem with the spi controller hardware within the mcu. I have also been working with the board manufacturer in solving this problem as well. In an attempt to troubleshoot  your driver I was comparing it with a different kernel driver recommended by my board manufacturer (Micromint) that was written by another customer. This particular driver has apparently been well received, however, I have yet to have any luck getting it to work. Even when a representative from the company sent it to me precompiled and tested, I still had no lluck getting it to work in an identical environment. 

Now I know the ADC works because I have userland code which directly accesses the ADC and I get correct output.  Note that this code completely bypasses the atmel spi controller and operates directly on the ADC128S052s registers. Suspicious right? 

I assume you are using the atmel-spi driver as the master controller driver correct? If so, did you make any modifications to it at all? 

Thanks for your help guys.

John

Marc Pignat <marc.pignat@hevs.ch> wrote:

>Hi John,
>
>(You asked me in private, but I prefer to respond on the mailing list).
>
>This driver was working, I wrote (and tested it) in 2008 ;)
>The hardware it was running on was a custom at91rm9200 based board with
>a adc084s051.
>The last time a checked it, it was on 2.6.28, and it was still working fine.
>
>I just had a look to the adc128s052 datasheet, and it looks compatible
>with this driver.
>
>Guenter, the spi_write_then_read() function is really the good one.
>In brief, the write selects the channel, then the read reads the data.
>
>I think the problem you're facing is either in the spi driver or in the
>hardware.
>
>
>Best regards
>
>
>Marc
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
