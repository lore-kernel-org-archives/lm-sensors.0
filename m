From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: National PC87372 chip driver wanted
Message-Id: <20040518020338.GA11012@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A9074A.5060604@acetechgroup.com>
In-Reply-To: <40A9074A.5060604@acetechgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mitchell:

* Mitchell Perilstein <mitch@acetechgroup.com> [2004-05-17 14:41:14 -0400]:
> Hi Sensor Folks,
> 
> The Intel 865 series motherboards has this chip, "Nat. Semi. PC87372 
> Super IO Fan Sensors", listed as "no plan" on the site.  Is anyone 
> working on it?
> 
> We're thinking about encouraging development of the chip driver for it, 
> in the form of either a some funding/donation or maybe the donation or 
> loan of one of these 865 boards.
> 
> Please write if interested.
>
> Thanks!
> -- 
> Mitchell Perilstein
> ACE Technology Group, LLC
> http://www.acetechgroup.com
> (484) 713-0075

I haven't had much time to work on sensors stuff lately, but your
offer is interesting... not least because I recognize your company
from a couple messages to the Philly LUG and because I live relatively
close to Exton myself.

I took a quick look at the PC87372 datasheet - that combined with Jean
Delvare's recent work on similar NatSemi chips should make for a pretty
straightforward driver.

As for donations, the sensors project is not set up to accept money
right now.  Of course it is useful (but not strictly necessary) to
have a hardware sample for writing a driver.  Please contact me off-
list to make arrangements.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
