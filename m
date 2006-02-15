From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 15 Feb 2006 15:46:41 +0000
Subject: [lm-sensors] w83781d and empty /sys/class/hwmon
Message-Id: <UC6GyUmu.1140018400.9790510.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
In-Reply-To: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Victor,

Please answer to the list, not to me only.

> > Which motherboard is this?
>
> It says "Version: ASUS P3B-F ACPI BIOS Revision 1006 "

OK, this board actually has an Asus AS99127F chip, so the detection is
correct in sensors-detect.

> > If you compiled your kernel by yourself, you may try to rebuild it with
> > I2C and Hardware Monitoring debugging options enabled, and check again
> > what happens when you load the w83781d module.
>
> there already I2C_DEBUG_CORE=y and HWMON_DEBUG_CHIP=y

That's really odd then, because you should then see many messages in the
logs when loading the w83781d module. Maybe you're not looking at the
right place? Debug messages typically only appear in the output of dmesg
(the command) and in /val/log/debug (the file). Please check again.

The dump you provided looks OK to me, the w83718d driver should work fine
with that chip, so without further debug logs there's not much more I
can do.

--
Jean Delvare

