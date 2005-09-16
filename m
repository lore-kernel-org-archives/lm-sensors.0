From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 16 Sep 2005 20:56:05 +0000
Subject: [lm-sensors] read()ing an i2c node results in errno=ENOSYS
Message-Id: <20050916205635.3b704b20.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <b4e191e7050915035768c521ef@mail.gmail.com>
In-Reply-To: <b4e191e7050915035768c521ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> we're working on a robotics project, and are tryng using an i2c bus to
> communicate between our microcontrollers and our mini-itx pc
> (via-embedded Epia ML).
> (...)
> although the dev-interface file seems to be outdated (the i2c_smbus_*
> "macro's" it refers to are no longer in the kernel headers, and are
> now only in the lm_sensors' i2c-dev.h),

Care to send a patch fixing this doc file?

> my amateur reading of the
> kernel source supports that this should work. However, a read call
> results in errno=ENOSYS (Function not implemented), although on one
> run, i actually got EPERM, and another time resulted in SEGV.

ENOSYS is expected. You are trying to do raw I2C transfers while the bus
driver (i2c-viapro) and underlying chip only offer SMBus transfers (that
is, a subset of I2C.) It fails.

I'm more concerned about EPERM and SEGV, which obviously shouldn't
happen. Hard to say why this happens without the actual code though.

-- 
Jean Delvare
