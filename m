From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: #1353 still error!!
Message-Id: <20030731135706.25c078fd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F28DE38.70801@chello.hu>
In-Reply-To: <3F28DE38.70801@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> This machine is Intel Pentium Celeron II 700 MHz, 384 SDRAM,
> mainboard: Asus TUSL2-C System: SuSE 8.0 , kernel: 2.4.18-4GB
> GCC-3.3  (this is the newest stable version)

OK. Isn't it strange to use an old distribution, an old kernel, and a
bleeding-edge compiler?

> Now I'm going to compile lm_sensors-2.8.0 again from the beginning,
> I'll swap those 2 lines then I'll attach the whole compilation
> procedure here... I hope we can figure out what the problem is.

My analysis is that your build environment is unsafe. The fisrt warning
(dereferencing type-punned pointer will break strict-aliasing rules) is
not lm_sensors fault IMHO. I believe you had the same with i2c. It's
probably harmless anyway.

I'm puzzled. Many other modules are very similar (include-wise) to
dmi_scan, and seem to compile OK.

Next think I'd like you to try is removing the "#include
<linux/config.h>" line from dmi_scan.c completely, and see if it changes
anything.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
