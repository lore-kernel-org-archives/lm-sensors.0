From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: lm_sensors:  PCA9549, MAX6653
Message-Id: <20040316213322.54200796.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079465318.4136.52.camel@pavement.sandburst.com>
In-Reply-To: <1079465318.4136.52.camel@pavement.sandburst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> However, our project includes the use of several PCA9548 (8 port i2c
> mux), and MAX6653 (fan controller & temp sensor)
> 
> I found the patch from Brian Kuschak for subordinate busses and
> patched that in (with some hand patching).  I'm hoping that'll work
> for the pca9548, but I don't have high hopes.

The comments in Brian Kuschak's code suggest that it should work.

> For the 6653 I plan on basing code on the 6650 driver that currently
> exists.

I invite you to compare MAX6650/MAX6651/MAX6653 datasheets, and see
whether it makes sense to add support for the MAX6653 to the existing
driver, or starting a new driver (even based on the old one) is a better
idea.

> Is this a feasible attempt?  Is someone already developing the drivers
> I need?

No driver planed for the MAX6653 at the moment.

> Thanx for the 2 packages, some of the devices we're using are already
> support, makes my life much easier!

You're welcome :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
