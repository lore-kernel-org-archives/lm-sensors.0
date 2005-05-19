From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <402EF025.2000501@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:

> 
> The procfs files were not meant to be chip-independant at all. There
> were simple rules about file names and items orders within the files,
> but that was only meant as a help for developers. So there were no
> benefit to split alarms over correctly named files. Now this is
> completely different.
> 

For what it's worth, I think the /proc interface strived to
be chip-independent. The new sysfs interface is certainly more chip-independent,
but it's an evolution. We defined standards for /proc.
We improved  them for sysfs. 


> 
> 1* Change the base scheme (temp_min1 -> temp1_min). This is the more
> important change.
> 

If you have the energy to do this, fine, but at this point it doesn't seem
worth the effort. I don't see how having them grouped alphabetically, for example,
is much of a benefit to anybody.

> 2* Change the hysteresis names (temp1_hyst -> temp1_max_hyst). Only some
> drivers are impacted. Changes required to the library as well.
> 

Any drivers besides lm83 have more than one hyst per sensor?
This is needed for the general case but in practice the usefulness is limited.
A good idea but low priority.

> 3* Add the splitted alarm files. This doesn't break the interface, but
> on the other hand needs that we think about it a bit more so that out
> choices are extendable and correct for all known drivers.

An excellent idea that really expands the information available in a chip-independent manner.


