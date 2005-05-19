From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: bad vid value
Message-Id: <200405241551.i4OFp4Dg053091@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040519065553.GA16559@cereve.enpc.fr>
In-Reply-To: <20040519065553.GA16559@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>the vid value got correct with CVS version

Great :)

>I tried to load w83627hf driver but it failed with  'no such device'
>whereas it works well with i2c_isa and w83781d
>
>this means that the w83627hf driver tries to access devices that
>do not exist on my PC, could someone tell me which device nodes
>have to be created ? or which option the driver need to get the right
>device ?

No, it should work equally well. Causes could be:
1* You forgot to unload w83781d before loading w83627hf.
2* Your chip is actually using i2c-nforce2, not i2c-isa.
3* You chip is not a W83627HF and is not supported by the w83627hf driver.
4* Both drivers use different detection mechanisms. The w83627hf driver
relies on Super-I/O configuration, while the w83781d driver tries an
arbitrary ISA address.

Jean
