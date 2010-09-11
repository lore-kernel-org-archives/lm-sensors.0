From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 11 Sep 2010 14:11:34 +0000
Subject: Re: [lm-sensors] Lack of fan sensor output after Ubuntu upgrade
Message-Id: <20100911141134.GA26210@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201009101529.26294.larsivar@igesund.net>
In-Reply-To: <201009101529.26294.larsivar@igesund.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 11, 2010 at 04:53:39AM -0400, Jean Delvare wrote:
> On Fri, 10 Sep 2010 09:15:27 -0700, Guenter Roeck wrote:
> > On Fri, Sep 10, 2010 at 09:29:25AM -0400, Lars Ivar Igesund wrote:
> > > Probing for Super-I/O at 0x4e/0x4f
> > > 
> > > Trying family `National Semiconductor'... Yes
> > > 
> > > Found unknown chip with ID 0x8512
> > > 
> > > Is this something of interest?
> >
> > Most likely this is a Nuvoton chip; they use chip id 0x85 for another chip.
> 
> This doesn't strike me as a particularly relevant data point.
> 
I figured it may come handy when searching for the chip datasheet.

Guenter

> > Don't recall seeing this specific ID, though, or why it is identified
> > as National Semiconductor.
> 
> Different vendors use different "access keys" to the LPC configuration
> space. These are sequences of bytes to be written to the register port.
> National Semiconductor is (was) the only vendor without an access key,
> that is, you can access the configuration space at any time. For this
> reason, we try to detect National Semiconductor devices first.
> 
> Nuvoton indeed has one chip in this family (WPCD377I) because this
> device is an older National Semiconductor device they inherited when
> buying part of National Semiconductor's business a few years ago. So
> the mysterious chip could indeed be a Nuvoton-labelled chip, but be a
> National Semiconductor design.
> 
> Either way, most LPC chips on laptops are minimalist and don't include
> hardware monitoring features, so there's probably little interest in
> investigating this. The only way to move forward would be to find a
> detailed listing of this laptop's parts (very hard to get usually) or
> to open the laptop's case and have a visual look (usually not easy
> either.)
> 
> As in most laptop cases, the problem and solution are more likely
> related to laptop-specific code or ACPI.
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
