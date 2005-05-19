From: liste@jordet.nu (Stian Jordet)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: i2c_adapter i2c-0: Bus collision!
Message-Id: <1105562511.4811.0.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073527236.624.7.camel@buick> <1073707567.621.5.camel@buick>
	 <1074304828.780.2.camel@chevrolet.hybel>
	 <20040117094856.2f8b44c8.khali@linux-fr.org>
	 <1105461895.8299.2.camel@localhost.localdomain>
	 <20050112212316.44efcedb.khali@linux-fr.org>
In-Reply-To: <20050112212316.44efcedb.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

ons, 12,.01.2005 kl. 21.23 +0100, skrev Jean Delvare:
> Hi Stian,
> 
> > about a year ago I asked for help with my motherboard, claiming i2c
> > bus collisions all the time. Now I found the solution, the sensor uses
> > the isa bus, not the i2c. Funny it sometimes worked with i2c-viapro,
> > but with i2c-isa it works all the time :)
> 
> Thanks a lot for keeping us informed.
> 
> Too bad you did not tell us you had the possibility to use the ISA
> access in the first place. It is well known that ISA access is more
> reliable than SMBus or I2C.
> 
> It also might explain why MBM was working without a problem. I suppose
> it was also using the ISA interface, same as you do now.

Believe me, had I known it, I would have told you :) Anyway, a happy
ending :) Thanks for your support.

Best regards,
Stian
