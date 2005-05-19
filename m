From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: update to ticket 1763
Message-Id: <20040826084952.M98394@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <005601c48a5a$065d6410$6c01a8c0@internal.liaison.com>
In-Reply-To: <005601c48a5a$065d6410$6c01a8c0@internal.liaison.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Khali, thanks.
> 
> Is there an option that will work if my kernel is 2.4.21 ?
> 
> It looks like you're suggesting that I need the i2c-piix4 driver in
> lm_sensors 2.8.2 ... but website indicates lm_sensors 2.7.0 is the last
> release compatible with 2.4 kernels.

That's not quite what it says. It says that 2.7.0 "is the last 2.2/2.3
kernel-compatible release (including 2.4 kernels through 2.4.8)." So 2.4.21 is
fine. Just make sure to install an updated i2c before installing the new
lm_sensors, and it should be OK.

Note that, unless you recompile your kernel yourself with a special patch, the
operation will break non-sensors i2c drivers such as bttv. So don't do this if
you need such a driver.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
