From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Tue, 28 Apr 2009 13:31:40 +0000
Subject: Re: [lm-sensors] Why internal sensor on atom cpu isn't yet
Message-Id: <1240925500.1065.5.camel@maxim-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1240762029.10972.15.camel@maxim-laptop>
In-Reply-To: <1240762029.10972.15.camel@maxim-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2009-04-28 at 06:27 -0700, Philip Pokorny wrote:
> The Intel EPSD systems with IPMI are now reporting 'margins' instead
> of 'temperatres' for many sensors.
> 
> A margin is measured in degrees and is a negative number.  As the CPU
> or other device gets hotter the value increases towards zero.  If it
> goes positive, then you have 'overheated' and exceeded the spec.
> 
> I would agree that you should expose thw value from the sensor but
> would suggest we label these as 'margins' and not 'temperatures'

Actually, I think that there even is no need to know the tjmax.
Why would user care how hot cpu is?

I would just know that it is below its maximum designed temperature, and
how much, thus raw value would work just fine.

Regards,
	Maxim Levitsky




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
