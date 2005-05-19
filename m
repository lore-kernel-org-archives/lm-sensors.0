From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Winbond chips - design questions
Message-Id: <3F973584.D0FA0335@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031022022051.GB8764@earth.solarsys.private>
In-Reply-To: <20031022022051.GB8764@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



"Mark M. Hoffman" wrote:
> 
> * Mark D. Studebaker <mds@paradyne.com> [2003-10-22 20:32:55 -0400]:
> <snip>
> >
> > The new driver is isa-only and includes super i/o
> > detection, so that the isa address is always discovered.
> > This makes the new driver much better at finding a chip.
> 
> Is this just ISA PnP?  I have no experience with that.
> 

I don't know PnP so I don't know.
You can look in the driver or in sensors-detect to see
what super i/o looks like. If there's a real name
for it I don't know what it is. I just followed the
super i/o datasheets then realized all the chips were similar.

> <snip>
> 
> 
> Why are those enormous tables present in libsensors at all?
> And then again what is the point of libsensors if the
> sensors program needs special code for each driver?  Yuck.
> I guess I should go read the source of gkrellm and see what
> they're doing.
> 
>

Agreed that libsensors is problematic.
One reason why I've pushed for and documented firm /proc standards
as an alternative.
