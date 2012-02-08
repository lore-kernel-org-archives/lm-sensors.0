From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 23:04:28 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <1328742268.2261.373.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-08 at 17:31 -0500, Guenter Roeck wrote:
> On Wed, 2012-02-08 at 16:17 -0500, Patrick Marty wrote:
> > > Patrick, where do you get the 4.4.6 compiler from ? Is it from debian or
> > > from a different distribution ?
> > 
> > The compiler comes from ubuntu 11.10 ( with default packages repositories ).
> > 
> > 
> > > Do you know the exact package version
> > > (the latest debian version is 4.4.6-14, for example) ?
> > 
> > The package version is 4.4.6-11ubuntu2
> > 
> > 
> > As suggested by Jean, I will report the problem to the maintainer of the gcc Ubuntu package.
> >  
> My system came back up. Unfortunately, the failing code turns out to be
> where I had thought it was from my original assembler decode ... in an
> aera which should not be executed in the first place for NCT6776F.
> 
> (gdb) l *(w83627ehf_probe+0x59e)
> 0x39ef is in w83627ehf_probe
> (/home/groeck/src/w83627ehf/w83627ehf.c:2303).
> 2298			/*
> 2299			 * Temperature sources for temp1 and temp2 are selected with
> 2300			 * bank 0, registers 0x49 and 0x4a.
> 2301			 */
> 2302			data->temp_src[0] = 0;	/* SYSTIN */
> 2303			reg = w83627ehf_read_value(data, 0x49) & 0x07;
> 2304			/* Adjust to have the same mapping as other source registers */
> 2305			if (reg = 0)
> 2306				data->temp_src[1]++;
> 2307			else if (reg >= 2 && reg <= 5)
> 
> Really odd. And the reported address (0x39ef) isn't even valid code.
> Brr.

Ok, I did some more debuging. 

You should actually see another message just before the oops, along the
line of 

	w83627ehf: unsupported chip ID: 0x469c

With some mode debug messages added, turns out the driver believes that
the "force" parameter is set to 0x469c. That parameter is not
initialized, because it should be set to 0, but even if I set it to 0
explicitly it still claims to be set to 0x469c.

If I change the force_id variable type to int, it claims to be set to
0xc1a04694. Not much better.

That still does not explain the oops .. the driver should simply bail
out in this case. It does return from sensors_w83627ehf_init() with
-ENODEV, but still seems to call _probe ... or, rather, it seems to jump
directly into the bad code, since I don't see any output from a debug
message placed at the beginning of the _probe function.

No idea what is going on. This is really odd. I may try to do some
research on the web tonight to see if anyone else has seen a similar
problem.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
