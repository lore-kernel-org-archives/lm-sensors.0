From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 14 May 2012 13:40:09 +0000
Subject: Re: [lm-sensors] missing fan RPMS
Message-Id: <20120514134009.GA15978@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAED541.7080201@lockie.ca>
In-Reply-To: <4FAED541.7080201@lockie.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 13, 2012 at 09:58:18PM -0400, James wrote:
[ ... ]
> >>
> >> :-(
> >> Both fans connected but only one shows up.
> >>
> > Yes, I think that is exactly the problem. Looks like the board uses a multiplexer
> > to connect multiple fans to the same fan sensor input. Which makes it all but impossible
> > for third parties (like Linux) to implement working fan control. Really annoying,
> > especially since the NCT6776F has really a lot of fan sensor inputs available.
> > 
> > At least some of the other boards from the same vendor have lots of fan connectors.
> > Did you try all of them ?
> > 
> > Guenter
> > 
> 
> If they are multiplexed, it is weird I didn't at least get 2 numbers when I was moving them around.
> I tried all the plugs on the motherboard.
> If I get the information from ASRock about how to read the fan speeds, could I make a config file specific to this motherboard?
> 
I don't think so. We can not manipulate gpio pins from the driver. Even if you manage to set the gpio pins
from user space, there is no way to synchronize this with the kernel driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
