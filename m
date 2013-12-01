From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Dec 2013 19:05:09 +0000
Subject: Re: [lm-sensors] Acer Aspire 8930G laptop and general approach for reverse engineering sensors
Message-Id: <20131201190509.GA19549@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20131118T042931-981@post.gmane.org>
In-Reply-To: <loom.20131118T042931-981@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 29, 2013 at 06:29:27PM -0500, Tom Metro wrote:
> Guenter Roeck wrote:
> > Tom Metro wrote:
> >> I did see in the FAQ that there is no database of configurations per
> >> motherboard/laptop, but I would expect that with all the temperature
> >> monitoring utilities for Windows, one or more of them likely has bundled
> >> configuration files that can be used as a reference.
> >
> > Would be great. Unfortunately, it appears that the creators of the 
> > various Windows utilities are not very enthusiastic about sharing...
> 
> While voluntary sharing would be preferable, I was thinking more along
> the lines of reverse engineering their configuration files. Then
> creating a script to translate them into a collection of sensors.conf
> files. (You can't copyright a compilation of factual data, like a phone
> book, so there's isn't a legal problem with doing this. Though it might
> inspire them to start encrypting the data. Or downloading settings
> on-demand from an online service.)
> 
> Is anyone aware of a Windows utility that comes with accessible
> configuration files covering a wide range of hardware?
> 
I am not aware of any such packages which would let you do that.
Either configuration files don't exist and everything is hard-coded,
or the configuration is embedded in the code.

One exception is Open Hardware Monitor, for which source is available.
This package is already used for input whereever possible, though.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
