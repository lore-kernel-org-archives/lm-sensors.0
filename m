From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: W83697HF works fine for me with modifications to conf file
Message-Id: <20040204215231.4a807d4d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040204005233.736cd618.e_r_i_c@gmx.net>
In-Reply-To: <20040204005233.736cd618.e_r_i_c@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I got a new AMD tyan board and kernel 2.4.24 custom on debian, it
> reads the same as the bios after modifing the sensors.conf file. I
> hope you find the information usefull, even as I started with an older
> package.

I've added this information as comments in our default config file.
Thanks!

> Oh don't worry about the fans as they turn less than 2000Umin
> and are not reported turning by the bios screen either ;-)

You should try increasing fandivs from 2 to 4 (or more if needed).

For free, a few comments about your sensors.conf file:

>    set in0_min 1.55 * 0.95
>    set in0_max 1.75 * 1.05

Second line should read 1.55, not 1.75.

>    set in7_min 3.0 * 0.95
>    set in7_max 3.0 * 1.10

First line should read * 0.90, not * 0.95.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
