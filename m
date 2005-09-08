From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 08 Sep 2005 19:12:53 +0000
Subject: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision!
Message-Id: <20050908171234.GB21714@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050907213603.GW8392@levanta.com>
In-Reply-To: <20050907213603.GW8392@levanta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani:

* Yani Ioannou <yani.ioannou@gmail.com> [2005-09-08 09:56:29 -0400]:
> The bus collisions are expected - both the IPMI BMC (not bmcsensors
> directly) and the i2c modules you have loaded are competing for the
> smbus. However although I've done this (loaded both bmcsensors and i2c
> modules and got bus collisions) its never resulted in a lockup.

I should also point out: I've been able to get my own ICH5/i801 SMBus 
locked up so hard that it takes a complete power cycle for the machine
to even POST correctly.  Ultimately, that's the fault of an extremely
unforgiving SMBus client chip somewhere (to say the least) - and there's
absolutely nothing the I2C/SMBus driver can do about that.

*However* even when this happens for me, *Linux* still runs fine.  It's
only the SMBus itself that gets locked up.  In my case, I can still 
attempt to read sensors or eeprom or whatever, and of course that fails
with tons of collisions - but it doesn't kill the whole kernel.

Richard's symptoms seem to implicate the i2c-i801 and i2c-core patches.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

