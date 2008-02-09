From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Sat, 09 Feb 2008 16:57:43 +0000
Subject: Re: [lm-sensors] D201GLY2, Winbond W83627DHG-B No-Output
Message-Id: <4dfa50520802090857w75df1b81g9e13cdeb0155eda3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47ADB7EE.3040403@plzk.de>
In-Reply-To: <47ADB7EE.3040403@plzk.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefan,

> Hi david,
>
> i did not found any debug flags in this module, so here is the output:
>
> w83627ehf: Found W83627DHG chip at 0x290
> i2c /dev entries driver
>
> if you need further informations, please let me know.

I think you will want to modify /etc/sensors.conf (man sensors.conf)
and that will display the information you want when you run sensors.

Since there were no error messages in dmesg, it seems your BIOS has
configued the chip correctly.

Look at the files in /sys/class/hwmon/hwmon0/ -- they are all small,
plain text files. The sysfs files and w83627dhg chip are documented in
/usr/src/linux/Documentation/hwmon. It should provide you with enough
information to interpret what you see in the sysfs files, so you can
edit /etc/sensors.conf.

Also, I'll try to help with any specific questions you might have.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
