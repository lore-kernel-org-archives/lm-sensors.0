From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Python bindings to i2c-dev
Message-Id: <20041229145938.095251f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041229050526.GA5431@jupiter.solarsys.private>
In-Reply-To: <20041229050526.GA5431@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> After a couple false starts and some hair-pulling, here is a Python
> module which allows SMBus access through the I2C /dev interface.  I
> would like to eventually add this to the lm_sensors project.
> 
> 	http://members.dca.net/mhoffman/sensors/python/

Maybe you could start with a link from the lm-sensors' site, either in
the news or on the useful addresses page?

> Which reminds me...  Khali: Is i2c-dev safe (ruin-proof) for people
> with IBM laptops?  Or would that check need to be built in to this?

It isn't safe. Single quick writes to addresses 0x54-0x57 are likely to
kill IBM laptops (it actually depends on what command is ran next). That
said, at the moment i2c-piix4 won't load on supposedly vulnerable
systems, so it shouldn't happen.

I have plans to replace quick writes (for detection) by byte reads for
this address range in Linux 2.6's i2c_detect/i2c_probe, just like I did
in i2cdetect and sensors-detect already, but it doesn't address the
i2c-dev issue. Maybe we can hack i2c-dev to prohibit quick writes to the
eeprom range entirely? That way all user-space tools would automatically
be safe.

-- 
Jean Delvare
http://khali.linux-fr.org/
