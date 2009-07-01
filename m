From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 01 Jul 2009 01:06:43 +0000
Subject: [lm-sensors] Fwd:  dme1737 sensors force_start
Message-Id: <191fb4ca0906301806v9d8f2afw9689ff5309f99200@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Adding  the list


---------- Forwarded message ----------
From: Juerg Haefliger <juergh@gmail.com>
Date: Tue, Jun 30, 2009 at 6:00 PM
Subject: Re: [lm-sensors] dme1737 sensors force_start
To: Kushal Koolwal <kushalkoolwal@hotmail.com>


Hi Kushal,


>
> Pardon me for my ignore. I am still not clear if this is a definite BIOS issue or a driver issues or partly both. I do have access to our firmware engineer who develops the BIOS. If you think that this is a 100% BIOS issue I can ask BIOS guy to fix this. Also I appreciate if anybody can tell me what needs to be fixed exactly in the BIOS.

It's a BIOS issue. The driver shouldn't have to enable HW monitoring,
the BIOS should. Unless the HW monitoring pieces of the Super-IO chip
in this machine are not used but that doesn't seem to be the case
since you say everything works fine when you use the force_start
parameter. Note that there are machines out there that have Super-IOs
with HW monitoring capabilities which are not connected/unused and
hence not enabled by the BIOS.

Are there any options in the BIOS? Do you see temp/voltage data in the BIOS?

...juerg


> Thanks
>
> Kushal Koolwal
>
> I do blog at http://blogs.koolwal.net/
> _________________________________________________________________
> Windows Live™ SkyDrive™: Get 25 GB of free online storage.
> http://windowslive.com/online/skydrive?ocid=TXT_TAGLM_WL_SD_25GB_062009
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

