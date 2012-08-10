From: Marc Pignat <marc.pignat@hevs.ch>
Date: Fri, 10 Aug 2012 06:46:20 +0000
Subject: Re: [lm-sensors] Output problem with adcxx  on at91
Message-Id: <5024AE3C.5050903@hevs.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <5019526C.2030802@comconcepts.com>
In-Reply-To: <5019526C.2030802@comconcepts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi John,

(You asked me in private, but I prefer to respond on the mailing list).

This driver was working, I wrote (and tested it) in 2008 ;)
The hardware it was running on was a custom at91rm9200 based board with
a adc084s051.
The last time a checked it, it was on 2.6.28, and it was still working fine.

I just had a look to the adc128s052 datasheet, and it looks compatible
with this driver.

Guenter, the spi_write_then_read() function is really the good one.
In brief, the write selects the channel, then the read reads the data.

I think the problem you're facing is either in the spi driver or in the
hardware.


Best regards


Marc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
