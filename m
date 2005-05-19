From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: linux-2.6.1, ECS K7S5A / SiS735
Message-Id: <20040115181809.23867c8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040113004723.5892cfb2.Dexter.Filmore@gmx.de>
In-Reply-To: <20040113004723.5892cfb2.Dexter.Filmore@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> here seems to be the problem: i2c-core is statically, i2c-dev and
> i2c-sis96x are loaded as modules. after that I did i2cdump.
> it doesn't find any buses. i2cdetect 0 tells me there is no such
> device. strange, i did mkdev.sh and the files are in dev.
> 
> ideas? do have to hack more than i2cdetect to make sis96x work on my
> sis735 board?

I'm rather clueless. I'm not even sure wether this is related to the
sis96x driver or not. Maybe you want to see with Mark, our SiS busses
expert.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
