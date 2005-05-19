From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: [BUG] i2c-viapro oops on bad SMBus Block Read
Message-Id: <20030806084749.350577f7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805210754.457c1946.vsu@altlinux.ru>
In-Reply-To: <20030805210754.457c1946.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I have found a reproducible bug in i2c-viapro (lm_sensors-2.8.0).
> > When the device replies to SMBus Block Read with an absurdly large
> > length, this driver accepts it without checking and overruns the
> > data buffer. Tried with VT8325 and VT82C686.
> (...)
> I'll commit this patch now.

The fix should use I2C_SMBUS_BLOCK_MAX as defined in linux/i2c.h. Also,
I think I'd prefer to return an error than to truncate silently, but
that may be discussed.

Also (just in case), isn't it possible to fix that at a lower level (in
i2c-core maybe) so that we don't have to check it later in all drivers?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
