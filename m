From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Jul 2013 07:49:58 +0000
Subject: Re: [lm-sensors] Few queries about lm-sensors and core temp.c
Message-Id: <20130722094958.5ed154c4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <D137AD88-0DA4-4CF3-889D-862386B3C35A@brown.edu>
In-Reply-To: <D137AD88-0DA4-4CF3-889D-862386B3C35A@brown.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kapil,

On Sun, 21 Jul 2013 23:23:00 -0400, Kapil Dev wrote:
> I am using 2.6.39-020639-generic  kernel and I am running Ubuntu 9.04. I couldn't find /etc/sensors.d/coretemp.config file.

It's OK and expected, just create the file. Every file
under /etc/sensors.d will be taken into account by libsensors.

> I am using 3450S intel i5 processor, which has Tjmax of 103C (sorry for the typo in my original email), based on http://users.sosdg.org/~qiyong/lxr/source/Documentation/hwmon/coretemp?a=um . 

Note that this is our own driver documentation file. We did out best to
make it accurate but it is not an official reference for TjMax values.

> I found that for some processors, IA32_TEMPERATURE_TARGET MSR has the Tjmax value; I assume that the coretemp.c tries to read this register and if it doesn't succeed then, it uses the heuristic value.

Yes, exactly.

> Few other doubts I have are:
> 
> 1) For a multi-core processor, are there separate Tjmax for each core or just 1 Tjmax value per processor?

The Intel datasheet was not very clear on this, so the driver makes no
assumption and reads IA32_TEMPERATURE_TARGET on each core. However in
practice I have never seen a CPU with different TjMax values for the
different cores.

> 2) Inside coretemp.c  file, the temperature is read in milli-degree C, and multiplied by 1000 to get C value.
> Does it mean that DTS value stored in IA32_ThERMAL_STATUS MSR is in milli-degrees? I also notice that there are only  7 bits assigned to DTS value, which would not be sufficient to cover the wide range of temperate values if it is in mill-degree C. Am I missing something here?

It's the other way around actually, the value is in (pseudo) degrees C
in the MSR and milli-degrees C in sysfs.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
