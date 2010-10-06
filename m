From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Oct 2010 20:47:59 +0000
Subject: Re: [lm-sensors] local macro
Message-Id: <1286398079.9690.85.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
In-Reply-To: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2010-10-06 at 15:54 -0400, Paul Thomas wrote:
> > No, both of those are runtime options internal to the ads7871, and
> > because we initiate a read by setting that register anyway there isn't
> > any additional setup cost (at least there isn't any spi cost, there is
> > a little additional code in show_voltage).
> >
> > Additionally gain & diff are initialized to a gain of 1 and single
> > ended reads which will match how the driver works now.
> >
> > I'm open to other suggestions also.
> >
> > thanks,
> > Paul
> >
> 
> I had one other question. The chip gives you a valid conversion result
> bit. Currently we're not checking it, if It's not a valid conversion,
> then what should be returned?

Possibly EIO ?

Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
