From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [RFC 2.6] sensor chips sysfs interface change (long)
Message-Id: <20040219225917.53c85ef8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218220845.361341c9.khali@linux-fr.org>
In-Reply-To: <20040218220845.361341c9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have finised the kernel patch for step 1 of my plan (temp_min1 ->
temp1_min). You'll find it here:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.3-i2c-sysfs-names-1.diff

You'll notice that I haven't renamed functions, only sysfs file names.
In some drivers it makes things look a bit strange now, but I really
didn't want the patch to look more complex than it really is. We can
still rename the functions later.

Reviewers and testers wanted. I'll propose a libsensors patch tomorrow
(unless someone is faster than me). In any case, do **NOT** commit any
change to the library before 1* lm_sensors 2.8.5 is released and 2* the
kernel patch is accepted by Greg, if this is to happen.

BTW, what are the "rtN" files in the w83781d sysfs interface? Never seen
these before, and came across them as I converted this driver.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
