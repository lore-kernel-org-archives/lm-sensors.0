From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: as99127f pwm register
Message-Id: <20030724225359.2546fa71.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> check what I wrote carefully, the secondary detection might be like
> the winbond, but the primary ($58) is $31 and that is not winbond but
> Asus in this case, that is why I have the 1st and 2nd detection.  The
> fact the other 2 ID's are like winbond simply shows you that Asus
> bought them from winbond:)

Oh sorry, I forgot to mention one thing. In our detection script, we
ignore the LSB of register $58. Thus the AS99127F rev2 ID ($31) and the
W83782D ($30) look the same, that's why I got confused. I don't know why
we ignore this bit, I couldn't read anything about that in the
datasheets. I will take a look at our CVS logs tommorow and see what
made us add this in the past.

> a diffrence we have -i think- is that MBM does not use the $48
> register, MBM detects a sensor chip.... Asus on $2D.... then the 2
> LM75's.... I just name/label these 2 LM75's Asus 2 and 3 but IF the
> chip on $2D is a Asus, if it's a winbond I name then winbond 2 and
> 3.... internaly they are LM75's so I really don't need the $48 to show
> me where the LM75's are, if there are more then 2 LM75's on a board
> (not found one so far) the extra LM75's are LM75's while those 2 on
> the default adres are Asus 2 and 3

The register $48 is supposed to contain the I2C address of the main chip
itself (that is the address we are "talking" to at the moment). I don't
know what the idea was, but at least this adds some reliability to the
detection. Looks like Winbond only does this, the Asus chipsets seen so
far did not.

The subaddresses are computer using register $4A (but that's a different
thing).

Thanks again for your help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
