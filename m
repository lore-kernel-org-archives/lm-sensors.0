From: herb.cavalier@gmail.com (herb)
Date: Sat, 24 Dec 2005 09:16:09 +0000
Subject: [lm-sensors] how to use the struct : i2c_client_address_data
Message-Id: <dfc7f2810512240116g7bb24a1cvf39d38a6e18b0317@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everyone:

      I'm writing a driver for a chip named tvp5150a on at51rm9200 platform.

      I tried to understand the architecture of i2c driver for linux,
but there're some points that I couldnt understand.

      I think the struct   i2c_client_address_data   is used to probe
a chip attached to the i2c bus,  but I can't see  how to set it
properly.    I've  checked others drivers such as msp3400.c, 
ds1307.c, saa5249.c, i2c.h, i2c-dev.h, i2c-core.c,   and the documents
for i2c in src/Documentation/i2c,  but I didnt find any information
useful.

     I guess it may work by simply setting the fields of
i2c_client_address_data with "I2C_CLIENT_END",  but I dont kno why it
works!

    Can somebody tell me the exact meanning of the fields in
i2c_client_address_data?  And how should I set them?

    Any reply will be appreciate. Thanks.


regards.

herb
