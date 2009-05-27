From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 27 May 2009 09:15:14 +0000
Subject: [lm-sensors] TI TMP421 chip address
Message-Id: <20090527091514.GB4422@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

looking in the datasheet of the TMP421 sensor chip

http://focus.ti.com/docs/prod/folders/print/tmp421.html,

I saw the following addresses.

TMP421  100 11xx
TMP422  100 11xx
TMP423A 100 1100
TMP423B 100 1101

But the preliminary driver of your students uses 0x2a.

 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2a, I2C_CLIENT_END };

0x2a = 010 1010b, right?

Do I misunderstand something?

And what means the xx in the address of TMP421/422?

Thanks in advance,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
