From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 07 Jan 2011 01:39:10 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS620
Message-Id: <20110107013910.GA12274@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D0FB795.3010006@antcom.de>
In-Reply-To: <4D0FB795.3010006@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 06, 2011 at 07:05:24PM -0500, Roland Stigge wrote:
> Hi,
> 
> On 06/01/11 19:03, Jean Delvare wrote:
> > On Sun, 26 Dec 2010 00:05:59 +0100, Roland Stigge wrote:
> >> Hi,
> >>
> >> thanks again for your valuable feedback!
> >>
> >> Attaching the updated patch including your proposed changes.
> > 
> > Do you actually need the detection function? It's pretty weak, the DS620
> > has no ID registers, detection can't be reliable, I'd rather not have
> > it at all.
> > 
> > (The DS1621 is detected for historical reasons, but quite frankly, it
> > shouldn't have been either, and we might drop that someday.)
> 
> Thanks for your hint!
> 
> I'm attaching my updated patch. You can also merge from git.antcom.de,
> repo linux-2.6, branch ds620.
> 
> I also added a runtime configuration device attribute for the thermostat
> functionality.
> 
Unfortunately, that adds a non-standard and non-documented ABI attribute, so no one
will be able to use it. Also, from reading the specification, it seems like it would more
appropriate to set this through platform data (if it really has to be configurable).

Btw, can you write Documentation/hwmon/ds620 ? I completely forgot to ask for that.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
