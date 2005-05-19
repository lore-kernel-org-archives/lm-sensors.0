From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: more 2.6 mapping issues
Message-Id: <20040125095313.0d69fb82.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4012F311.9040503@verizon.net>
In-Reply-To: <4012F311.9040503@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> lm78, lm75 at least have
> temp_input, temp_max, temp_hyst in sysfs,
> 
> but the mapping in lib/proc.c is
> temp=>temp_input1
> temp_hyst=>temp_hyst1
> temp_over=>temp_max1
> 
> do we want to submit a driver patch to add the '1' suffixes
> or add mappings in lib/chips.c?
> 
> To be in conformance with Documentation/i2c/sysfs-interface we should
> add the '1'.

According to this thread:
http://archives.andrew.net.au/lm-sensors/msg05135.html
we already discussed that point and both of us agreed that adding the
'1' suffixes would be the right choice.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
