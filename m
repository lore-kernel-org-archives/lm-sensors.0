From: mporter@kernel.crashing.org (Matt Porter)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Fix for i2c-ibm_iic.c
Message-Id: <20040412121033.D21071@home.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081771172.11592.268.camel@uganda>
In-Reply-To: <1081771172.11592.268.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 12, 2004 at 10:41:43PM +0400, Evgeniy Polyakov wrote:
> On Mon, 12 Apr 2004 10:43:06 -0700
> Eugene Surovegin <ebs@ebshome.net> wrote:
> > There is another patch I made for MV guys a month ago 
> > (http://kernel.ebshome.net/iic_0_len-2.4.diff, 
> > http://kernel.ebshome.net/iic_0_len-2.6.diff). 
> > 
> > It restores _incorrect_ old driver behavior and most probably I'll
> > send that version upstream (I'm still waiting for OK from them).
> 
> Driver with your patch works exactly as driver without it.
> It always returns 0 with or without any ACK read from bus.
> It is wrong.
> I "found" 7 max6634 sensors on the bus.

Sounds like your max6634 driver doesn't have i2c_detect() implemented
properly. The lm75 driver does it "right" and all those false positive
hits are weeded out by additional checks in the lm75 i2c_detect()
implementation.

It would be interesting to see a fully-functional driver using
the bit-banging approach, but that requires somebody that cares
about it.

-Matt
