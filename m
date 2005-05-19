From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: xeontemp
Message-Id: <20031203073531.527f8390.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202074706.7aded81e.khali@linux-fr.org>
In-Reply-To: <20031202074706.7aded81e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I disagree (about the "bad" part - it was a cut and paste for sure).
> adm1021 was at the limit for number of chips in SENSORS_INSMOD_x.

True.

> Making a new driver is a prerequisite for having better detection
> in sensors-detect and recommending the correct driver,
> without the user having to edit sensors.conf.
> The new driver matches the xeon datasheet - exactly one sensor. Not
> two.

But we still need to add support to sensors-detect. Since I had been
adding extra checks to the MAX1617 (and LM84) detection, I'd expect Xeon
sensors not to be misdetected as these, so adding a basic check for
xeontemp (without the extra knowledge of the value stored in the "unused
regs") with confidence 2 should be sufficent for now.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
