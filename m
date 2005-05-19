From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: lm_sensors2/kernel/chips w83781d.c
Message-Id: <3F9C73B8.9E368066@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031025204143.0af8b200.khali@linux-fr.org>
In-Reply-To: <20031025204143.0af8b200.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have 4 versions of the datasheet but only one with the registers
documented
(it's 89 pages vs. ~45 for the others - let me know if you want it)
It shows a value of 71 at address 0x58.


Jean Delvare wrote:
> 
> I couldn't verify the W83791D ID. Strangely it seems to be missing from
> the data sheet. Or am I blind? I'd need to know if it is really 0x70 or
> has to be changed to 0x71 too.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
