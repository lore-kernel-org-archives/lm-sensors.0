From: Zbigniew Luszpinski <zbiggy@o2.pl>
Date: Thu, 05 Mar 2009 14:28:24 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0752 - how can I
Message-Id: <200903051528.24635.zbiggy@o2.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903041438.45638.zbiggy@o2.pl>
In-Reply-To: <200903041438.45638.zbiggy@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thursday 05 of March 2009 10:09:23 Jean Delvare wrote:

> This looks good. Can you please verify that:
> # i2cdump -y 3 0x50 b
> # i2cdump -y 3 0x50 c
> # i2cdump -y 3 0x50 W
> all return the exact same data?

Yes. All the same.

> You can now run sensors-detect again, but I doubt it will find any
> hardware monitoring chip on the SMBus.

eeprom driver matched. I looked at i2cdump and found names of my RAM modules.

thanks for help,
Zbigniew 'zbiggy' Luszpinski

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
