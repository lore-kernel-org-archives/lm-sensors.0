From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:30:47 +0000
Subject: [lm-sensors] [patch 0/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212201.485176000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c_driver and i2c_driver.driver both have "owner" and "name"
field.  One should go - there's no point needlessly duplicating
stuff like this.

The first patch updates the core usage of i2c_driver. Subsequent
updates drivers to explicitly use i2cdriver.driver fields.

(patches 0,1 and 5 copied to video4linux list)
--
laurent
--

