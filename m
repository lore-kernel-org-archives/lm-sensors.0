From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 10 Oct 2010 22:59:42 +0000
Subject: Re: [lm-sensors] [RFC v2] Support of chassis intrusion detection
Message-Id: <20101010225942.GA1719@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310170340.4c63de39@hyperion.delvare>
In-Reply-To: <20090310170340.4c63de39@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 10, 2010 at 06:42:27PM -0400, Fred . wrote:
> On Thu, Oct 7, 2010 at 4:33 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Thu, Oct 07, 2010 at 08:55:46AM -0400, Fred . wrote:
> >> http://www.lm-sensors.org/ticket/2370
> >> Ticket says the interface definition is now upstream.
> >>
> > It is.
> Since it is, then I suppose its a good time to add support for this in
> the user-space tools.
> 
> >> Since the interface definition is upstreams, why have not support been
> >> added to libsensors and sensors?
> >>
> > Browsing through the drivers, it seems that none have been converted
> > to use the new interface. I would guess that until that has been done,
> > it does not make sense to add untestable support for it to libsensors.
> Which came first, the chicken or the egg?
> Time to implement support for this in the user-space tools.
> Hopefully support in drivers will follow.
> 
This is not a matter of chicken and egg. Driver support must come first,
to be able to test the user space tools. Besides, tools support w/o kernel
support doesn't provide any value at all, untested or not.

Since you state yourself that you don't have the technical knowledge to make 
any contribution yourself, it might be a good idea to listen to those who _do_
have the technical knowledge when it comes to deciding what must come first.
You can not both claim technical knowledge good enough to determine what
comes first, but then claim to not have the knowledge to actually do the work.

Frankly, I think you are shooting yourself into the foot here. You keep
making requests without providing anything. If you had asked a bit more
friendly and at the very least offered to help with testing, people might
be more willing to support you. But all we get is your demands and a statement
that you will not (be able to) contribute yourself. Not really a good start.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
