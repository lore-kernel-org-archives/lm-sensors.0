From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c multi-master mode
Message-Id: <20040805051241.GA11755@plexity.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407300939.54751.bjanz@mac.com>
In-Reply-To: <200407300939.54751.bjanz@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Aug 05 2004, at 00:51, Mark M. Hoffman was caught saying:
> > I'm not trying to quibble -- I'm just trying to explain my needs as clearly as 
> > I can...
> 
> OK, I think I get your intended distinction now... not just adding slave
> support... but also adding the ability to change the host from a master
> to a slave and back while the driver is loaded, maybe even operating
> as both simultaneously.  Is that it?
> 
> Well that's a feature - let's call it "adapter mode switching" - that
> we obviously don't support.  I'm not sure anyone's ever even considered
> it or asked for it before.  I wonder what kind of system it is that
> this is required?

It wouldn't be that hard to add support for this would it? Basically
when you are not sending a packet, you automatically switch to slave
mode and listen for your address.  The biggest problem is adding hooks
for async callbacks so some upper layer code can go off and do
some other work and be interrupted when an inbound message comes in.
Would only work with intelligent I2C controllers and not bit-bang
adapters as you don't want to actively be polling the lines for 
your address (ick!).

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
