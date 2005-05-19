From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: I2C device driver...
Message-Id: <42776DC9.3010807@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <2b8efadf05050305185328d3df@mail.gmail.com>
In-Reply-To: <2b8efadf05050305185328d3df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

>  Unfortunately, i have an IBM Thinkpad laptop, and as you have
> recommended I will not download and use the software. Bless you for
> the tip!

You can use it but never ever load i2c-piix or i2c-i801 and never ever eeprom module.
So if you delete/do not complile driver for Intel chipset SMBUS host adapater you are safe.

> Can you please direct me to a mailing list where I can post my
> questions on my i2c driver development?

This is correct address. Just write again with subscribe in subject and Phil will add you to a list.

Regards

Rudolf
