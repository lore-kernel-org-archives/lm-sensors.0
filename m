From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 19 Aug 2009 16:52:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for VIA CPU core
Message-Id: <191fb4ca0908190952l773fca65y5b38c88a1bf029d2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090609083406.GE25316@prithivi.gnumonks.org>
	 <20090619231132.22296525@hyperion.delvare>
	 <191fb4ca0906271134r2c9761e3la56bdea3f66b60f4@mail.gmail.com>
	 <191fb4ca0908131142m4f976d98yb434da72257f64ea@mail.gmail.com>
	 <20090819143223.GU5065@prithivi.gnumonks.org>
In-Reply-To: <20090819143223.GU5065@prithivi.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Harald Welte <HaraldWelte@viatech.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Harald,


> On Thu, Aug 13, 2009 at 11:42:17AM -0700, Juerg Haefliger wrote:
>> Jean,
>>
>> Harald seems to be to busy to answer emails. Can we push my driver upstream?
>
> Well, I am not too busy anymore.  A terrible number of weeks just behind me.

Good to hear :-)


> Sorry for the delays.
>
> I personally don't really care which driver is merged, just as long as one of
> them ends up in mainline.


Do you have any answers to my previous questions:

1) My driver uses the CPUID instruction to read the performance
registers that contain the temp and voltage data. Harald's driver
reads MSRs. I don't know if there are any benefits of using one method
over the other.

2) If we pick Harald's, it would be nice if his driver can also read
and export the CPU core voltage.

3) Quite a few testers of my driver reported 0 temp readings for some
C7 CPUs. I was never able to figure out why some CPUs return 0 temp
but I'm guessing it depends on the thermal monitor settings. I'd like
to understand what is going on and hope Harald can shed some light.


...juerg


> - Harald Welte <HaraldWelte@viatech.com>            http://linux.via.com.tw/
> ======================================
> VIA Free and Open Source Software Liaison
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
