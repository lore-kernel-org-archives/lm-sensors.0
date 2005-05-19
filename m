From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: 11-bit temperature problem
Message-Id: <20030814184519.244fdf0b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030812000544.71047b61.khali@linux-fr.org>
In-Reply-To: <20030812000544.71047b61.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Gah!  I'm sorry: (b) + (c) *is* i2c_smbus_read_byte_data() minus a
> stop bit.

Aha, OK, that's it. Didn't know that (there are sooo many things I still
don't know, shame on me).

> SMBus Read Byte Data
> ==========
> 
> This reads a single byte from a device, from a designated register.
> The register is specified through the Comm byte.
> 
> S Addr Wr [A] Comm [A] S Addr Rd [A] [Data] NA P
> 
> So, that makes 39 bits not 29.

You're perfectly right. But that doesn't matter anymore ;)

-- 
Jean "I swear I'll read the I2C specs soon" Delvare
http://www.ensicaen.ismra.fr/~delvare/
