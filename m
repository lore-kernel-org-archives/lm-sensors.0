From: Mike Looijmans <mike.looijmans@topic.nl>
Date: Wed, 10 Aug 2016 07:06:15 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon/max6650.c: Optionally retrieve voltage and prescaler from device
Message-Id: <57AAD267.2090706@topic.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7240769604668925221=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1470727827-15907-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1470727827-15907-1-git-send-email-mike.looijmans@topic.nl>
To: lm-sensors@vger.kernel.org

--===============7240769604668925221==
Content-Type: multipart/related;
	boundary="_3d36074d-7715-4675-a04b-abf09d64d67f_"

--_3d36074d-7715-4675-a04b-abf09d64d67f_
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"

   Thank you very much for your feedback, much appreciated.
   Comments inline. No comment from my side means I totally agree and will
   integrate it into a v2 patch.
   Once I have the userspace software in place, I'll probably want to add
   some
   extra features like hooking up the alarm to an IRQ. Currently the
   driver
   doesn't use the gpio pins. That'll be a separate patch.
   On 09-08-16 18:37, Guenter Roeck wrote:
   > On Tue, Aug 09, 2016 at 09:30:27AM +0200, Mike Looijmans wrote:
   >> Parse devicetree parameters for voltage and prescaler setting. This
   allows
   >> using multiple max6550 devices with varying settings, and also makes
   it
   >> possible to instantiate and configure the device using devicetree.
   >>
   >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
   >> ---
   >>
   >> This patch just does the minimal to get the device working properly
   with devicetree config.
   >> What is the better path here, move to devicetree completely and
   remove the module parameters,
   >> or do we need to keep backward compatibility with the moduel
   parameter (allowing only one
   >> config for all chips)?
   >
   > I am relatively sure that no one is using the module parameters, but
   we'll have
   > to keep them for compatibility.
   I was afraid so yeah. I'll keep them in.
   > Properties will neeed to be described in
   > Documentation/devicetree/bindings/hwmon/max6650.
   >
   >> (in case of DT-only, the "clock" value could be obtained using the
   clock framework)
   >>
   > Yes, that should be done
   I read the datasheet on that. The clock input/output of the chip is
   intented
   to synchonize multiple controllers together, where one will act as
   clock
   master, so you don't hear the annoying "whir" of fans running just out
   of
   sync. The 254kHz is just fixed in the chip.
   Also this only applies to the max6651 variant which I don't have, so I
   cannot
   test my changes properly.
   I guess for simplicity I'll just keep the current clock constant.
   >
   >>   arch/arm/boot/dts/topic-miamiplus.dtsi |  1 +
   >>   drivers/hwmon/max6650.c                | 18 ++++++++++++++----
   >>   2 files changed, 15 insertions(+), 4 deletions(-)
   >>
   >> diff --git a/arch/arm/boot/dts/topic-miamiplus.dtsi
   b/arch/arm/boot/dts/topic-miamiplus.dtsi
   >> index d433101..e927ff9 100644
   >> --- a/arch/arm/boot/dts/topic-miamiplus.dtsi
   >> +++ b/arch/arm/boot/dts/topic-miamiplus.dtsi
   >
   > This file is neither upstream nor in -next.
   My bad, I hadn't created a proper git branch yet for this patch, and it
   sorta
   sneaked in.
   >
   >> @@ -56,6 +56,7 @@
   >>     reg = <0x1b>; /* ADD pins high-Z, hence address 0011011b */
   >>     compatible = "max6650";
   >>     voltage = <12>;
   >
   > Should probably be something like fan-volts (or fan-volt), though
   that will
   > need to be confirmed by DT maintainers.
   >
   >> +  prescaler = <8>;
   >
   > Probably better something like fan-prescale, unless there is a
   generic
   > clock property that can be used. Needs feedback from DT maintainers.
   Looking at other trees, I'll got with "fan-voltage" and "fan-prescale"
   and
   wait for feedback.
   >>    };
   >>   };
   >>
   >> diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
   >> index 162a520..c190954 100644
   >> --- a/drivers/hwmon/max6650.c
   >> +++ b/drivers/hwmon/max6650.c
   >> @@ -566,6 +566,15 @@ static int max6650_init_client(struct
   max6650_data *data,
   >>    struct device *dev = &client->dev;
   >>    int config;
   >>    int err = -EIO;
   >> + u32 local_fan_voltage = (u32)fan_voltage;
   >> + u32 local_prescaler = (u32)prescaler;
   >
   > Please use shorter variable names. voltage and prescale, maybe.
   >
   >> +
   >> +#ifdef CONFIG_OF
   >
   > ifdef not needed.
   >
   >> + of_property_read_u32(client->dev.of_node,
   >> +        "voltage", &local_fan_voltage);
   >
   > Better something like
   >  if (of_property_read_u32(client->dev.of_node, "fan-volts",
   >      &voltage))
   >   voltage = fan_voltage;
   >
   > (typecast not needed).
   >
   >> + of_property_read_u32(client->dev.of_node,
   >> +        "prescaler", &local_prescaler);
   >> +#endif
   >>
   >>    config = i2c_smbus_read_byte_data(client, MAX6650_REG_CONFIG);
   >>
   >> @@ -574,7 +583,7 @@ static int max6650_init_client(struct
   max6650_data *data,
   >>     return err;
   >>    }
   >>
   >> - switch (fan_voltage) {
   >> + switch (local_fan_voltage) {
   >>    case 0:
   >>     break;
   >>    case 5:
   >> @@ -585,13 +594,13 @@ static int max6650_init_client(struct
   max6650_data *data,
   >>     break;
   >>    default:
   >>     dev_err(dev, "illegal value for fan_voltage (%d)\n",
   >> -   fan_voltage);
   >> +   local_fan_voltage);
   >>    }
   >>
   >>    dev_info(dev, "Fan voltage is set to %dV.\n",
   >>      (config & MAX6650_CFG_V12) ? 12 : 5);
   >>
   >> - switch (prescaler) {
   >> + switch (local_prescaler) {
   >>    case 0:
   >>     break;
   >>    case 1:
   >> @@ -614,7 +623,8 @@ static int max6650_init_client(struct
   max6650_data *data,
   >>       | MAX6650_CFG_PRESCALER_16;
   >>     break;
   >>    default:
   >> -  dev_err(dev, "illegal value for prescaler (%d)\n", prescaler);
   >> +  dev_err(dev, "illegal value for prescaler (%d)\n",
   >> +   local_prescaler);
   >>    }
   >>
   >>    dev_info(dev, "Prescaler is set to %d.\n",
   >> --
   >> 1.9.1
   >>


   Kind regards,


   Mike Looijmans

   System Expert


   [cid:image90c2c8.PNG@63af9f37.46913c4e]

   TOPIC Products



   Materiaalweg 4



   5681 RJ Best

   T:

   +31 (0) 499 33 69 69

   Postbus 440

   E:

   mike.looijmans@topicproducts.com

   5680 AK Best

   W:

   [1]www.topicproducts.com
   The Netherlands

   [2][cid:imagead4153.JPG@422883f5.4eb0ba00]
   [3][cid:image5f2f6c.JPG@fdf16ab0.4aafe70f]
   [4][cid:image4621dd.JPG@dcd06c37.40af81aa]
   Please consider the environment before printing this e-mail
   [5]Topic zoekt gedreven (embedded) software specialisten!

References

   1. http://www.topicproducts.com/
   2. https://www.facebook.com/TopicProducts
   3. https://twitter.com/TopicProducts
   4. https://www.linkedin.com/company/topic-embedded-products
   5. http://topic.nl/vacancy/topic-zoekt-technische-software-engineers/

--_3d36074d-7715-4675-a04b-abf09d64d67f_
Content-Type: image/png
Content-Transfer-Encoding: base64
Content-ID: <image90c2c8.PNG@63af9f37.46913c4e>
Content-Disposition: inline; filename="image90c2c8.PNG"
Content-Location: image90c2c8.PNG
Content-Description: image90c2c8.PNG

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
AAAAAElFTkSuQmCC

--_3d36074d-7715-4675-a04b-abf09d64d67f_
Content-Type: image/jpeg
Content-Transfer-Encoding: base64
Content-ID: <imagead4153.JPG@422883f5.4eb0ba00>
Content-Disposition: inline; filename="imagead4153.JPG"
Content-Location: imagead4153.JPG
Content-Description: imagead4153.JPG

/9j/4AAQSkZJRgABAQEAYABgAAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/
2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwM
BwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM
DAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCAATABQDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEA
AAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJx
FDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNk
ZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJ
ytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQF
BgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMz
UvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3
eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna
4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3/wDaq/bN1S5/aP8AGFj/AMJY8Z0nU57M
Qrd+X5KpIyhdpPAAGMDjv1zXt/gj4T6zov7Jd98RvG2ofE5dTkMxsdK0yAlrWNVYx3FwrKT5J272
fIAQjrmvzj/bY8Ppc/tk/EzzFGJfEN6QGH3lMzj8ehH4V9i/Ez46+No/+CHnhbVf+E014a7qHiaX
Sru8F8ftFxYl7uM27t1MWxVXaeMAV+347K6scFglheWPtJQi3bXWN+z0dnf/AIc+Bw+IpyrVnVbf
Km9/P1+4++f2Bvi7c/GL9k/wn4gur7+1JryGVTdB9/mhJXUfMeWwBjPfHeiuH/4JFaa1j/wT88BQ
7DH5cdyu0jG3FzLxRX5NmtGEMbWhHZSkvxZ9Jh61b2UfRfkjqvjB+wh8JPiN46ute1jwTp13q2pf
vrmcTTRec/QsVRwu44GSBknk5Nc4f+CdXwYnKxt4HtTGrAhft13tBz6ebRRU0c1xsIKEK00ktlJ2
/M7pYWi5XcF9yPofwZ4E0f4eeFbHQ9E0+303SdNiENtbQAqkS9fxJJJJOSSSTkmiiivN5pN3b1Ov
lS0R/9k=

--_3d36074d-7715-4675-a04b-abf09d64d67f_
Content-Type: image/jpeg
Content-Transfer-Encoding: base64
Content-ID: <image5f2f6c.JPG@fdf16ab0.4aafe70f>
Content-Disposition: inline; filename="image5f2f6c.JPG"
Content-Location: image5f2f6c.JPG
Content-Description: image5f2f6c.JPG

/9j/4AAQSkZJRgABAQEAYABgAAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/
2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwM
BwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM
DAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCAATABQDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEA
AAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJx
FDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNk
ZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJ
ytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQF
BgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMz
UvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3
eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna
4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9RPhzfN8bfjF46bVPEmrrZ+H51hW3sbvy
W3O7gZODgKFOAB+lc38Wfh747+Gen6tq8PiJr7QdOcyCdNRBnWDcAskicYxkBsZxWP8ACLWI9B+L
/wAUtNjmhh1TXLyGeyWaVYhdeTLJvjVmwNxD5AJGdpA5ruf2kPEM/iL4EeJLO60mHwer2qlZorqJ
zqbCRf8ARSvLYfknb02c8Zr9U5KtLFwhTtyS5FZpaJqOqV03q3qk/PY/m363TxOXVKlVy9pH2sua
LlrJSnZSdnFKyi7ScdGmt9fb/wBlr4gXPj34HaLqd1cfbJpldTMDneFcqMk/SisH9hzT2tf2ZvDs
e0rsEoIPGP3rUV8BmVKEcZVjHZSl+Z+0ZDisRUyzDVJat04N+riit8TvgL4R1PxlNfTaLC1zep58
zLLIod2Jy20MAM9TgdeetYc3wA8ITwAto6ZUjBFxKMf+PUUVzRzLFxSjGrKy/vP/ADPUqcP5XUk5
1MNTbd224Rbb+4978KeFtP8ACvh200/T7ZLWztYwkUSE4UdT1OSSSSSeSTRRRXJzN6tnqRhGK5Yq
yR//2Q==

--_3d36074d-7715-4675-a04b-abf09d64d67f_
Content-Type: image/jpeg
Content-Transfer-Encoding: base64
Content-ID: <image4621dd.JPG@dcd06c37.40af81aa>
Content-Disposition: inline; filename="image4621dd.JPG"
Content-Location: image4621dd.JPG
Content-Description: image4621dd.JPG

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcG
BwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwM
DAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCAASABQDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD6i+EP
xt0H48fBf4l+L0/4SmfVvDeqxWiTCNVtYbmebaFuC5yxd3AyD/EMZJOdfx18N/ip8MvAOt+J9c8J
ajp2i+HImuNRm82OWSCEAlpRCrF3jA3ZYAj5T1wc/L3wE/ah8N/sy/Aj41/DTxTYa9b+KPFHimxu
lhjgiC2LWN7G80UwkdWST90wA2nnGSOo9H1X/gqB4C1P9r746ePini4+H/ib4HXwvpFo/kmW2uRb
pHvlj8/ZHHuDncpY/MeOTj9brZLio1Z+wp3huut1aG1u95a67bH4jR4lwTowWIqpTtZq9rO9TVpp
3taCtp8R+g//AASd+NVr8eP2RbbWbGW6ms4dXvbOIzoU4SQE7QSTtyxIz60Vwv8AwQP8O3Xh3/gn
do4uLeSCK71i/uLZ2XC3MRkCiRDgZQsrAHviivzjO6UaWYVqcNlJr8T9W4frzr5ZQrVN5Qi/vR9Z
658MPDXifUWvNS8PaHqF2wCtPc2EUshA6Asyk8YH5VTHwP8ABY/5lDwv/wCCqD2/2fYfkKKK68P/
AAYlT+J+rOnhhS3hWONVREAVVUYCgdABRRRXgvc9VbH/2Q==

--_3d36074d-7715-4675-a04b-abf09d64d67f_--


--===============7240769604668925221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7240769604668925221==--
