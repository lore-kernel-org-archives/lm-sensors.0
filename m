From: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
Message-Id: <1081163597.607.15.camel@newt>
List-Id: <lm-sensors.vger.kernel.org>
References: <40686476.7020603@convergence.de>
	 <20040330213418.195dc972.khali@linux-fr.org> <406EBA38.1030203@gmx.de>
	 <20040403163031.122b5df8.khali@linux-fr.org>
In-Reply-To: <20040403163031.122b5df8.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: Michael Hunold <m.hunold@gmx.de>, Greg KH <greg@kroah.com>

On Sat, 2004-04-03 at 15:30, Jean Delvare wrote:

> I'm not sure that the function you propose would be really useful. I
> guess that most people don't load i2c chip drivers they don't need. The
> class filter you propose, added to the different I2C addresses, should
> do the rest.

What about using two DVB cards of different models to record off one
multiplex while watching another?

Only an explicit list of which chips should be probed on each I2C bus is
safe for this sort of system.

- Adrian Cox

