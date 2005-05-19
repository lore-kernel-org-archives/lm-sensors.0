From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Ticket #1376
Message-Id: <20030823212303.09d5f7b1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030817003245.GA12961@hurg.org>
In-Reply-To: <20030817003245.GA12961@hurg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I don't have applied the GRSEC patch to my kernel (I've downloaded
> the kernel source from kernel.org).
> 
> I upgraded to 2.8.0 (after removing ALL 2.7.0 remains), but the error
> is still there.

OK, so the problem is still there :( I thought it was fixed.

Why do you have the adm1021 module loaded? Doesn't seem to be used. Has
sensors-detect been suggesting you should load it? Likewise, I don't
think i2c-viapro is used (unless you partly hid the output of sensors).
Does unloading all (i2c-related) modules and reload only the ones you
need solve your problem? (unlikely)

Could you try writing to the files by yourself? For example, move to
/proc/sys/dev/sensors/w83697hf-isa-0290 and do:
echo "50 60" > temp1
Then read back the values from temp1. Does it work?

In your original ticket, you wrote:
> cd /proc/sys/dev/sensors
> cat chips
256     w83697hf-isa-029

Is it really "w83697hf-isa-029" or is the trailing "0" missing in your
copy only?

I hope we'll find a solution.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
