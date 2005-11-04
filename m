From: ericb@aspsys.com (Eric J. Bowersox)
Date: Fri, 04 Nov 2005 17:18:50 +0000
Subject: [lm-sensors] Re: [PATCH] lm93 driver for 2.6
Message-Id: <1131121072.15172.8.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051028182339.23792.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20051028182339.23792.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2005-11-03 at 22:30, Mark M. Hoffman wrote:
> > We also need someone to test this code in deep, on a real LM93 chip,
> > before we can put this in Linux 2.6.
> 
> I imagine Eric did that?  Otherwise why would he port it?  Would it be
> enough if I reviewed it closely?

When we ported the driver, I tested it enough to verify that we were
getting good (i.e. not-nonsensical) voltage, fan speed, and temperature
readings from it on the motherboard in question (Supermicro X6DHP). 
Unfortunately, the machines that I tested that driver on have long since
been shipped to the customer that paid for them, and I don't know if we
have any others in house.  I also haven't been able to pay as much
attention to this driver as I might have wanted to, because, as (now)
the only professional software engineer here, my time gets pulled in all
kinds of directions... 

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>

