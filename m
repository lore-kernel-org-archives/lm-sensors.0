From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: xeontemp
Message-Id: <20031203230440.7b9ceaf8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202074706.7aded81e.khali@linux-fr.org>
In-Reply-To: <20031202074706.7aded81e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> But we still need to add support to sensors-detect. Since I had been
> adding extra checks to the MAX1617 (and LM84) detection, I'd expect
> Xeon sensors not to be misdetected as these, so adding a basic check
> for xeontemp (without the extra knowledge of the value stored in the
> "unused regs") with confidence 2 should be sufficent for now.

Mark,

Any reason why you xeontemp driver excludes addresses 0x19, 0x2a and
0x4d? According to the data sheet they are possible addresses (as for
the ADM1021 and clones). OTOH doc/chips/xeontemp confirms 6 values
instead of 9.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
