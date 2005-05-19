From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Dell Poweredge
Message-Id: <20030714091637.39e49c68.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <022d01c348e1$8df68250$3400a8c0@W2RZ8L4S02>
In-Reply-To: <022d01c348e1$8df68250$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I am having no luck in compiling the modules.
> 
> Here is what I have been selecting.
> 
> <M> I2C support
> <M> I2C bit-banging interfaces (NEW)
> <M> I2C PCF 8584 interfaces (NEW)
> [*] I2C mainboard interfaces (NEW)
> <M>   Pseudo ISA adapter (for some hardware sensors) (NEW)
> <M> I2C device interface (NEW)
> <M> I2C /proc interface (required for hardware sensors) (NEW)
> <M>   National Semiconductor LM75 and compatibles (NEW)
> <M>   National Semiconductor LM78 (NEW)
> <M>   National Semiconductor LM80 (NEW)
> <M>   National Semiconductor LM85, Analog Devices ADM1027 (NEW)
> <M>   National Semiconductor LM87 (NEW)
> <M>   National Semiconductor LM92 (NEW)
> [*] Other I2C devices (NEW)
> <M>   EEprom (DIMM) reader  (NEW)
> 
> Here is the last error message.
> i2c-isa.c:46: error: unknown field `owner' specified in initializer
> i2c-isa.c:46: warning: missing braces around initializer
> i2c-isa.c:46: warning: (near initialization for `isa_adapter.name')
> i2c-isa.c:46: warning: initialization makes integer from pointer
> without a cast
> i2c-isa.c:46: error: initializer element is not computable at load
> time i2c-isa.c:46: error: (near initialization for
> `isa_adapter.name[0]') i2c-isa.c:47: error: initializer element is not
> constant i2c-isa.c:47: error: (near initialization for
> `isa_adapter.name')

Hm, I guess you have been using compilation option 3, where you do
generate a patch and apply it to your kernel sources. This method is
known to have problems (this is temporary, we know how to fix it and it
should be done really soon.)

You should use comilation option 1, that is: completely separated from
the kernel tree. This is by far the easier one, as easy as typing "make
&& make install" for i2c and "make && make install && ldconfig" for
lm_sensors2. Then, you just have to run "sensors-detect" and see what
kind of sensors exist on your system.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
