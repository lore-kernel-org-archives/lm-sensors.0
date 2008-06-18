From: "Tales Toledo" <toledo.tales@gmail.com>
Date: Wed, 18 Jun 2008 14:16:06 +0000
Subject: [lm-sensors] NXP LM75A conf register unused bits failure
Message-Id: <2308fb0f0806180716v5f551b65re685332318cd566e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I have a problem with lm75a (nxp) detection code.
After applied the patch to support 0xffff I can pass the unused
address detection test but I always fail at unused bits.
My problem is that I always read 0xbf from conf register. Masking with
0xe0 will always be true and bypass the address.
Hyst register seems to be right since I read 0x4b (default value from
nxp datasheet).
I am using u-boot and already disable any i2c support to avoid any
write to the bus.
Did anybody have a similar problem?

Thanks,
TT.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
