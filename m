From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: Small fix in the PCF8591 driver
Message-Id: <20040314213052.2923dbc6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040314194215.GA12324@pc.aurel32.private>
In-Reply-To: <20040314194215.GA12324@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please find attached a patch to fix a small bug in pcf8591.c: the
> function i2c_func_smbus_write_byte_data() was used without checking
> for it before.

You check for I2C_FUNC_SMBUS_BYTE_DATA while I believe you really only
need I2C_FUNC_SMBUS_WRITE_BYTE_DATA. Or am I missing something?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
