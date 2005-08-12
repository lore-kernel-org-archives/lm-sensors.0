From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 12 Aug 2005 19:58:42 +0000
Subject: [lm-sensors] Re: I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050812195844.4f597d19.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<42FA89FE.9050101@cetrtapot.si>
	<20050811185651.0ca4cd96.khali@linux-fr.org>
	<m3fytgnv73.fsf@defiant.localdomain>
	<20050811215929.1df5fab0.khali@linux-fr.org>
	<m3iryctaou.fsf@defiant.localdomain>
	<20050811234946.0106afbe.khali@linux-fr.org>
	<m3br44t9cv.fsf@defiant.localdomain>
	<20050812082653.098a6aa3.khali@linux-fr.org>
	<m3wtmri364.fsf@defiant.localdomain>
In-Reply-To: <m3wtmri364.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Krzysztof,

> > In I2C mode, you can even alternate as many read and write sequences
> > you want in a single transaction. The target chip would of course
> > need to know how to interpret such a transaction though. I've never
> > seen this possibility used so far.
> 
> Is this mode supported by the common (such as VIA south bridge)
> controllers?

No it's not, for the simple reason that south bridges are almost always
SMBus controllers, not I2C controllers.

That being said, I'd be surprised if it ever matters. I never saw such
transactions, and if some chip was to accept them, it would most
probably also accept a sequence of more simple, SMBus-compatible
transactions to achieve the same goal.

If you have further questions, they are welcome but I'd suggest that you
drop LKML from the recipients and follow up on the lm_sensors list only,
as we are getting somewhat off-topic now.

-- 
Jean Delvare
