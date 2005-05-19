From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <bJwzT1U6.1109665128.9708300.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <422318E5.4000201@katalix.com>
In-Reply-To: <422318E5.4000201@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi James,

> This was what was confusing me too. As I understand it now (Jean please
> correct me if I'm wrong) the core code behind the smbus read/write
> word_data() routines presents the u16 value as a little endian value.
> If the chip driver knows the chip implements 16-bit registers as big
> endian then it must swap the bytes, regardless of cpu endian.

Correct.

> I don't think Jean's statement that "the conversion is done by the
> bus drivers" is true, but maybe I still don't understand... :)

It wasn't true in the case of Mark's driver, you are right. It is in
fact true only for SMBus master drivers. For I2C masters, the i2c-core
emulates the SMBus protocol, so the conversion is done by i2c-core.

What I wanted to focus on was the fact that, in the general case, any CPU
endianness issue would need to be fixed in the bus driver, not the chip
driver.

--
Jean Delvare
