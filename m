From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <20040327141611.190f1faf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> root@pathfinder eric # i2cdump 0 0x4e w
>   WARNING! This program can confuse your I2C bus, cause data loss and
>   worse! I will probe file /dev/i2c-0, address 0x4e, mode word
>   You have five seconds to reconsider and press CTRL-C!
>  
>      0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
> 00: ff6d ff2d ff10 ff72 ff00 ff80 ff0f ff00
> 08: ff00 ff00 ffff ff00 ff00 ff00 ffe0 ffff
> (...)

I.e. no, it doesn't support word mode.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
