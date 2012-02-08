From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 22:31:54 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <1328740314.2261.363.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-08 at 16:17 -0500, Patrick Marty wrote:
> > Patrick, where do you get the 4.4.6 compiler from ? Is it from debian or
> > from a different distribution ?
> 
> The compiler comes from ubuntu 11.10 ( with default packages repositories ).
> 
> 
> > Do you know the exact package version
> > (the latest debian version is 4.4.6-14, for example) ?
> 
> The package version is 4.4.6-11ubuntu2
> 
> 
> As suggested by Jean, I will report the problem to the maintainer of the gcc Ubuntu package.
>  
My system came back up. Unfortunately, the failing code turns out to be
where I had thought it was from my original assembler decode ... in an
aera which should not be executed in the first place for NCT6776F.

(gdb) l *(w83627ehf_probe+0x59e)
0x39ef is in w83627ehf_probe
(/home/groeck/src/w83627ehf/w83627ehf.c:2303).
2298			/*
2299			 * Temperature sources for temp1 and temp2 are selected with
2300			 * bank 0, registers 0x49 and 0x4a.
2301			 */
2302			data->temp_src[0] = 0;	/* SYSTIN */
2303			reg = w83627ehf_read_value(data, 0x49) & 0x07;
2304			/* Adjust to have the same mapping as other source registers */
2305			if (reg = 0)
2306				data->temp_src[1]++;
2307			else if (reg >= 2 && reg <= 5)

Really odd. And the reported address (0x39ef) isn't even valid code.
Brr.

I think I'll add some log messages to show what is actually happening.
Of course that may result in the problem disappearing....

Guenter





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
