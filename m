From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 06 Jul 2006 14:34:17 +0000
Subject: [lm-sensors] it87 driver supports ITE8716 chip on new AM2 boards
Message-Id: <44AD1F69.2080402@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060705202045.GA15892@debamd64>
In-Reply-To: <20060705202045.GA15892@debamd64>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mike,

> I just got a new AM2 motherboard (Gigabyte GA-M55plus-S3g) that has a
> ITE8716 sensors chip. I am using kernel 2.6.16 and modified the source
> it87.c by replacing all instances of 8712 with 8716. Then recompiled the
> driver and ran modprobe it87. Surprise it works !! Apparently its a clone
> of the ITE8712 because i get all the fan, temp and voltage readings. This
> ITE8716 is also in the top end ASUS M2N32-SLI DELUXE motherboard and
> probably more. So many will be looking for it.

Heh thanks for the info. I think it would work without your change too. Please
can you tell me if the driver is using the i2c access or isa access?

(just copy to the email output of "sensors" command)
and also output of sensors-detect

I suspect that it works because
1) the hw monitoring block has same ID as it8712
2) superio detection failed, but I2C fallback worked

I will fix the sensors detect and the driver so it will work for ASUS people for
sure ;) I hope you will help me with testing.

Please post the output of the requested commands and in meanwhile I will fix the
sensors-detect and it87.c

Regards
Rudolf


