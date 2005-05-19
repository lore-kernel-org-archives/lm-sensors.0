From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: bad vid value
Message-Id: <200405190938.i4J9c8tU065933@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040519065553.GA16559@cereve.enpc.fr>
In-Reply-To: <20040519065553.GA16559@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> Yes, you can. The Winbond W83627HF on the ISA bus is supported by both
>> drivers. Using the w83627hf driver is prefered though.
>
>if I use only w83627hf driver ( which seems to work only through isa bus )
>I think it is no longer needed to load i2c_nforce, i2c_isa should be
>enough ?

Correct. Even with the w83781d driver, it was already the case. You need
the i2c-nforce2 driver if and only if you access the hardware monitoring
chip as an  I2C device. Since it seems that you are accessing it as an
ISA device, i2c-isa alone is enough.

Jean
