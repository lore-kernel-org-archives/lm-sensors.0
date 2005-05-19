From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: lm_sensors2/kernel/chips w83781d.c
Message-Id: <20031027220554.3e5ceef9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031025204143.0af8b200.khali@linux-fr.org>
In-Reply-To: <20031025204143.0af8b200.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have 4 versions of the datasheet but only one with the registers
> documented
> (it's 89 pages vs. ~45 for the others - let me know if you want it)
> It shows a value of 71 at address 0x58.

Mine has 43 pages :( Yes, I'd be interested in your version. Unless it's
more than 1MB large, please e-mail it to me. Or maybe you could upload
it to our pdf files repository?

Whatever, I now have to fix the driver (and sensors-detect) for this
chip too - we look for 0x70, not 0x71.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
