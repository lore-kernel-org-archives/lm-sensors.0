From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 12 Dec 2005 18:03:57 +0000
Subject: [lm-sensors] lm_sensors and nvidia
Message-Id: <439DBB8D.50707@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Volker Kuhlmann wrote:
> [nvidia graphics card temp monitoring]
> 
> 
>>You can try:
>>1) load i2c-rivatv (or whatever driver for the i2c nvidia bus)



> 
> i2c-nvidia2 is loaded automatically, but sensors-detect only finds 2
> dimm eeproms and the mobo's it8712. However, it finds two adapters, but
> no success on the first: 

Perhaps this driver misses a class of HWMON.

       .owner          = THIS_MODULE,
        .class          = I2C_CLASS_HWMON,

Add last one to the static struct i2c_adapter ...
> 
> What kernel module should I load exactly? Google doesn't know anything
> about i2c-rivatv.
> 

Yes I cant recall correct name... I guess that one you tried is OK


>>Run sensors detect it  should find he w83785

Please try this

> 
> Being able to get the temp of the geforce 6600 chip would be cool, as I
> have a temp problem with it. What else could I try?

Well try what I suggest above.

My driver was for 2.6 and for 2.4 too. I cant dig with it right now, I'm writing my master thesis and
I have nearly no free time. So I can help only a bit.

regards
Rudolf

