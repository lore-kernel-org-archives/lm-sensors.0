From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Mar 2012 16:23:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Add support for AT30TS00, TS3000GB2, TSE2002GB2, and MCP9804
Message-Id: <1331223818.23014.383.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331137039-16108-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331137039-16108-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-03-08 at 10:21 -0500, Jean Delvare wrote:
> On Thu, 8 Mar 2012 06:47:21 -0800, Guenter Roeck wrote:
> > On Thu, Mar 08, 2012 at 03:01:05AM -0500, Jean Delvare wrote:
> > > On Wed, 7 Mar 2012 09:18:13 -0800, Guenter Roeck wrote:
> > > > Thinking about it and looking into NetBSD code - some of the chips have
> > > > fixed sensor resolution, others have configurable resolution. In the
> > > > latter case, the NetBSD driver configures it. Before I drop the
> > > > capability to separate chips based on the prefix, it might make sense to
> > > > first determine if that is something we want or should support.
> > > > 
> > > > Thoughts ?
> > > 
> > > Isn't this all standardized in the capability and resolution registers,
> > > and thus independent of the vendor and device ID?
> > > 
> > The capability register is read-only. The resolution register is non-standard
> > and exists (as far as I can see) only on MCP98242/98243.
> 
> ST Microelectronics STTS2002 and STTS3000 chips to support it as well.
> 
> Anyway, this sole difference doesn't justify having a list of a dozen
> chip names. We could have a single flag HAS_RESOLUTION_REGISTER and set
> it as appropriate.
> 
> > > (...)
> > > introducing a new attribute for resolution, but a number of details
> > > will need discussion first, in particular the attribute name and unit
> > > and whether it is global or per input.
> >
> > Do you know of any other chips where the resolution is configurable ?
> > That should probably be the deciding factor if we introduce such an attribute.
> 
> I seem to recall LM75 compatible chips optionally supporting extra
> resolution bits. Ah, yes, Texas Instruments' TMP75/175/275 chips, for
> example.
> 
> > Not sure if it is worth it, though. The default resolution for the above chips
> > is 0.25 degrees C. That should really be good enough. I never understood why
> > a resolution of 0.0625 degrees C would make sense for a chip with an accuracy
> > of +/- 1 degree C.
> 
> I fully agree.
> 
I'll send a patch shortly, removing all the IDs.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
