From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 02 Mar 2006 04:45:28 +0000
Subject: [lm-sensors] HT1000 support (see lm_sensors ticket 2031,
Message-Id: <20060302044528.GA14528@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin:

* Martin Devera <devik at cdi.cz> [2006-03-01 21:23:54 +0100]:
> > One other possibility is that because I have a BMC card plugged in to 
> > the motherboard (SuperMicro H8SSL-i) the BMC card is not allowing access 
> > to the devices from lm_sensors.
> 
> it works well for me for the same MB, only loaded patched piix4 and then
> adm1026 module. Then even supermicro's superodoctor started to work on 
> the bow :) But I can imagine that it may become unavailable after BMC is 
> plugged in. I havn't bought BMC yet but I want to.
> 
> By the way, Jean, is it possible to have two masters on one i2c bus ? 
> How are priorities handled then ?

The i2c bus is multi-master capable.  There is no defined priority scheme.
However, there is an arbitration protocol that determines the outcome in
case two or more masters begin a transfer at the same time.  In a nutshell:
the transfer that is *not* corrupted wins.  It's simple and (IMHO) elegant.

I refer you to the I2C bus specification for more details, esp section 8.2:

http://www.semiconductors.philips.com/acrobat/literature/9398/39340011.pdf

If a Linux host I2C master loses arbitration, the transfer fails and an
error status is returned to the slave device driver.  Many (but not all)
hwmon drivers will retry the transfer several times before giving up.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


