From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: as99127f pwm registers
Message-Id: <20030724153236.28f054de.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722093411.25d749c5.khali@linux-fr.org>
In-Reply-To: <20030722093411.25d749c5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Just one more thing:

> AS99127F_1 & AS99127F_2 & ASB100:
> - if (IOByte($4F,$0,IORead)=$12) or (IOByte($4F,$0,IORead)=$C3)
>   then AS99127F_1
> - if (IOByte($4F,$0,IORead)=$5C) or (IOByte($4F,$0,IORead)=$A3)
>   then AS99127F_2

The AS99127F_2 Vendor ID you give here is Winbond's one! Are you sure?


> and finally the voltages, this is where there is a diffrence between
> the 2 AS99127F versions:
> 
> AS99127F_1:
> V0V6=($25*(-0.016))*3.97
> V0V7=($26*(-0.016))*1.503
> 
> AS99127F_2:
> V1V6=(($25*0.016)-3.6)*5.14+3.6
> V1V7=(($26*0.016)-3.6)*3.14+3.6

This is exactly the same difference there is between W83781D and
W83782D!

If what you say is right (and I'm confident in you), the AS99127F_2 has
the same device ID as the W83782D (except maybe the LSB, so $30 and
$31), the same vendor ID and the same V6 and V7 formulae. So, is there
any reason to make any difference between these two chips?

(The only difference I can see is that original winbond chips hold their
I2C address at register $48, and Asus ones don't seem too. However, we
never had a AS99127F_2 in our hands, so maybe Asus made it right for
this one? Any insight welcome.)

Thanks again Alex.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
