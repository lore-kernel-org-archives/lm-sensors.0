From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Jan 2013 22:28:45 +0000
Subject: Re: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <20130129222845.GA23971@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net>
In-Reply-To: <20121124052707.GA17392@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 29, 2013 at 01:46:52PM -0800, Doug Anderson wrote:
> Lars / Guenter,
> 
> On Tue, Jan 29, 2013 at 1:21 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> > On 01/29/2013 10:05 PM, Guenter Roeck wrote:
> >> On Tue, Jan 29, 2013 at 09:10:25PM +0100, Lars-Peter Clausen wrote:
> >>> I wrote in another mail a few days ago, how I think dt bindings for IIO could
> >>> be implemented. The basic idea was to simply use bindings very similar to what
> >>> the clk API uses, since its provider/consumer structure actually matches what
> >>> we do in IIO pretty good.
> >>>
> >>> The full mail can be found here:
> >>> http://marc.info/?l=linux-iio&m5902119507483&w=2
> >>>
> >> Hi Lars,
> >>
> >> looks like a good idea.
> >>
> >> Do you know if anyone is working on an implementation ?
> >> Otherwise I'll give it a shot.
> >
> > I unfortunately dont have time for this atm, but maybe Naveen or Dou is working
> > on it. Added them to Cc.
> 
> I believe Naveen was going to work on this but I found out this
> morning that he had to go on leave for some days so I'm not sure when
> he might respond.  If you want to take a whack at implementing the
> bindings I don't think he would mind, though.  ...then he'd be able to
> build on the same bindings to get the Samsung ADC working.  :)
> 
Ok, I'll see what I can come up with.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
