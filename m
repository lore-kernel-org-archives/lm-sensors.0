From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Aug 2012 16:34:43 +0000
Subject: Re: [lm-sensors] Output problem with adcxx  on at91
Message-Id: <20120810163443.GB29281@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5019526C.2030802@comconcepts.com>
In-Reply-To: <5019526C.2030802@comconcepts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 10, 2012 at 08:46:20AM +0200, Marc Pignat wrote:
> Hi John,
> 
> (You asked me in private, but I prefer to respond on the mailing list).
> 
> This driver was working, I wrote (and tested it) in 2008 ;)
> The hardware it was running on was a custom at91rm9200 based board with
> a adc084s051.
> The last time a checked it, it was on 2.6.28, and it was still working fine.
> 
> I just had a look to the adc128s052 datasheet, and it looks compatible
> with this driver.
> 
> Guenter, the spi_write_then_read() function is really the good one.
> In brief, the write selects the channel, then the read reads the data.
> 
Yes, I noticed that this must be the idea. I _think_ it assumes that the first
access initiates the conversion, and the second access reads the data (while
providing a dummy ADC index). The data sheet seems to confirm that. In other
words, the read data obtained with the first write is the ADC result from the
_previous_ conversion. The data sheet seems to confirm that: "The first
conversion result after power-up will be that of IN0".

I think I am going to order a couple of those chips and check what is happening
on the bus with a Logic Analyzer.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
