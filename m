From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Python bindings to i2c-dev
Message-Id: <20050122230634.GB20351@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041229050526.GA5431@jupiter.solarsys.private>
In-Reply-To: <20041229050526.GA5431@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-12-29 00:05:26 -0500]:
> After a couple false starts and some hair-pulling, here is a Python module
> which allows SMBus access through the I2C /dev interface.  I would like to
> eventually add this to the lm_sensors project.

The next version is here:

	http://members.dca.net/mhoffman/sensors/python/20050122/

It implements all bus xfers.  I've submitted it to python-list@python.org
for comments as well.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
