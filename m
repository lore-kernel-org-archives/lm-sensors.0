From: Zbigniew Luszpinski <zbiggy@o2.pl>
Date: Wed, 04 Mar 2009 23:13:36 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0752 - how can I
Message-Id: <200903050013.36349.zbiggy@o2.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903041438.45638.zbiggy@o2.pl>
In-Reply-To: <200903041438.45638.zbiggy@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Wednesday 04 of March 2009 22:58:46 Jean Delvare napisa=B3(a):
> If this gives resonable results I will add the new device ID to the
> sensors-detect script and the i2c-nforce2 driver.

I will probe file /dev/i2c-3.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

I will probe file /dev/i2c-4.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 51 52 53 54 55 56 57 -- -- -- -- -- -- -- --
60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: 70 -- -- -- -- -- -- --

have a nice day,
Zbigniew 'zbiggy' Luszpinski

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
