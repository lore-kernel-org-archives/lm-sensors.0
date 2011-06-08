From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Jun 2011 14:32:03 +0000
Subject: Re: [lm-sensors] [PATCH] Don't point the user to the ipmisensors
Message-Id: <20110608163203.71e5a1c7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110608151843.357fa29c@endymion.delvare>
In-Reply-To: <20110608151843.357fa29c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes Phil, bmcsensors was the Linux 2.4 driver, impisensors is the same
driver ported to Linux 2.6. Except that the port never got
completed :( And I don't have the hardware so I can't help.

On Wed, 8 Jun 2011 07:27:04 -0700, Phil Pokorny wrote:
> Is that the same driver as bmcsensors?
> 
> --
> Philip Pokorny, RHCE
> Chief Hardware Architect
> PENGUIN COMPUTING, Inc
> www.penguincomputing.com
> 
> On Jun 8, 2011, at 6:59 AM, Guenter Roeck <guenter.roeck@ericsson.com>
> wrote:
> 
> > On Wed, Jun 08, 2011 at 09:18:43AM -0400, Jean Delvare wrote:
> >> The development of the ipmisensors driver stalled 5 years ago, the
> >> driver isn't usable, so stop pointing the users to it, it only
> >> confuses
> >> them. See https://bugzilla.novell.com/show_bug.cgi?idU8756 for
> >> example.
> >>
> >> ---
> >> I have this patch in openSUSE for 1.5 year, any objection to me
> >> getting it upstream for everyone's benefit?
> >>
> > Makes sense to me. Too bad this driver is not supported, though - I
> > would need it ;).
> >
> > Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
