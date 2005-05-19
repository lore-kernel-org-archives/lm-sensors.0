From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Upcoming rpms: i2c headers under /usr/include/i2c
Message-Id: <20050103134007.40395a37.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041230173527.GF10397@neu.nirvana>
In-Reply-To: <20041230173527.GF10397@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I have no idea where the correct location would be, so anything you
> > come with is fine with me.
> 
> Perhaps indeed /usr/include/i2c/linux/i2c?
> 
> And I2C_HEADERS need to point (and default) to /usr/include/i2c, while
> 
> #include <linux/i2c/....>
> 
> picks the header either from a proper Linux kernel tree or from
> I2C_HEADERS.

Since the includes actually are <linux/...>, not <linux/i2c/...>, that
would be /use/include/i2c/linux. It is obviously important to have the
same include "tree" (even if it has just a depth of 1) in /usr/include
(or wherever it'll end) than we have in the Linux kernel source tree.

> If not /usr/include/i2c then perhaps /usr/local/include/i2c to be in
> sync with the other /usr/local defaults.

i2c and lm_sensors default to /usr/local for everything they install
(except for the libsensors configuration file) and I don't think we will
change this now. Thus I would go for /usr/local/include/i2c, but of
course you could do /usr/include/i2c on your RPM packages if it fits the
Red Hat/Fedora policy better.

Anyway, before going there, we'd better fix i2c 2.9.0 so that if does
install the header files at the old location again, so that people can
compile lm_sensors.

-- 
Jean Delvare
http://khali.linux-fr.org/
