From: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <20040416144524.GA13001@bytesex.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

  Hi,

> For this reason, I can hardly understand how it was decided that this
> command would be used for address probing purposes.

Didn't noticed that this happens, never digged that deep in the smbus
code ...

> I agree that the SMBus spec has no provision for address probing, so
> we have to use another command to achieve this purpose, still I would
> expect a "receive byte" (I2C_FUNC_SMBUS_READ_BYTE) to be way safer
> than a "quick command".

At least for the i2c-based video4linux stuff that should work without
problems.  bttv actually uses reads for address probing.

> The only side effect I can think off is that it would increase the
> address pointer for chips in autoincrement mode, but that's about all
> and it doesn't seem to hurt, really.

At least with i2c you can even do zero-length reads, i.e. just send the
read address and watch whenever someone acks it or not, without actually
reading data.  Not sure whenever that is true for smbus as well.

> I am seriously planning to change this in all three places (i2c-core,
> sensors-detect and i2cdetect) and would like to hear objections if they
> exist.

/me votes for doing that.

  Gerd

-- 
http://bigendian.bytesex.org
