From: phil@mindfart.com (Phil)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Support question:  segault in sensors
Message-Id: <017301c480b5$b7904da0$4400000a@phil>
List-Id: <lm-sensors.vger.kernel.org>
References: <013901c480a8$af2fc120$4400000a@phil>
In-Reply-To: <013901c480a8$af2fc120$4400000a@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

How are you concluding my version mismatch?

Here is my dmesg output:
i2c-core.o: i2c core module version 2.8.7 (20040611)
i2c-i801 version 2.8.7 (20040611)
i2c-isa.o version 2.8.7 (20040611)
i2c-proc.o version 2.8.7 (20040611)
adm1025.o version 2.8.7 (20040611)
eeprom.o version 2.8.7 (20040611)
smsc47m1.o version 2.8.7 (20040611)

I installed i2c v2.8.7 with lm_sensors 2.8.7, could there be a mismatch from
something already present in the Kernel source?  I don't understand where
the mismatch is....

I can't recompile my kernel, as it is patched to run some proprietary
hardware, and the patch is not available for anything newer.  I didn't have
i2c support enabled in the kernel, so I used "method 1" to build i2c &
lm_sensors.  Where did I go wrong?

Thanks for the help.  Sorry about any problems my "non-ascii-art" caused.
It has been disabled.

-Phil

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Phil" <phil@mindfart.com>
Cc: "LM Sensors" <sensors@stimpy.netroedge.com>
Sent: Thursday, August 12, 2004 1:27 PM
Subject: Re: Support question: segault in sensors
>
> I2c modules versions mismatch. Same as tickets 1741 and 1750.
> Check versions with dmesg after you loaded the modules.
>
> Please explain how you installed your kernel, i2c and lm_sensors, and
> I'll tell you were you failed.
>
> At any rate, mixing such an old kernel with such a recent lm_sensors is
> not recommended.
>
> Oh, and would you please avoid ASCII art (or actually non-ASCII art,
> which is even worse) in your "From:" field. This is a mailing-list, not
> #warlordz.
>
> Thanks.
>
> -- 
> Jean "Khali" Delvare
> http://khali.linux-fr.org/
>
