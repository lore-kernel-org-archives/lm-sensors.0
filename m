From: Andre Prendel <andre.prendel@gmx.de>
Date: Thu, 14 May 2009 08:06:53 +0000
Subject: [lm-sensors] [PATCH RFC 0/2] tmp401: Add support for Texas
Message-Id: <20090514080653.GB4486@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean, Hans,

here is my first work at TI's 401/411 temperatur sensor. The patch(es)
aren't intented to be applied. I just want some comments and maybe
real testing by Hans.

The first patch is the original one from Hans sent to me.

The second patch contains some work of Hans' students. I've brought
it in shape. The driver now has multichip support in the usual way.

TODO:
Update Kconfig
Writing documentation

There are a few remaining questions.

1. Hans' students implemented two additional sysfs entries
(tempX_[lowest|highest]).

The TMP411 chip has some additional registers for minimum and maximum
temperatures measured since power-on and chip-reset.

AFAIK there are no standard sysfs entries for these values. I don't
remove the support so far. Should it be removed? Are there other chips
with such features?

2. There is another command to reset the chip. Is this a useful feature?

3. Indentation

What is the right way to indent arguments in function declaration?

a)
static int tmp401_probe(struct i2c_client *client,
                        const struct i2c_device_id *id)

b)
static int tmp401_probe(struct i2c_client *client,
       const struct i2c_device_id *id)

My emacs prefered the first one, but sometimes this doesn't look very
well.

4. May I add a copyright note of me in the header?

Again, thank you very much for your help. It's a pleasure to work with
you.

Thanks,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
