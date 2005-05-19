From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: as99127f pwm register
Message-Id: <20030725120602.102f4b36.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030724225359.2546fa71.khali@linux-fr.org>
In-Reply-To: <20030724225359.2546fa71.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Oh sorry, I forgot to mention one thing. In our detection script, we
> ignore the LSB of register $58. Thus the AS99127F rev2 ID ($31) and
> the W83782D ($30) look the same, that's why I got confused. I don't
> know why we ignore this bit, I couldn't read anything about that in
> the datasheets. I will take a look at our CVS logs tommorow and see
> what made us add this in the past.

I finally found it (after almost one hour of searching through the CVS).
We once saw W83781D's with ID $11 while the datasheet says ID is $10.
This is the reason why we decided to ignore the LSB for all chips.
Actually, for most chips it can't hurt, but for the W83782D vs. AS99127F
rev.2 detection, it matters (and I'll change that).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
