From: Grant Coady <grant_lkml@dodo.com.au>
Date: Sat, 31 May 2008 20:17:47 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <ihc344lotfb30vkoc4r93qkotb7pao2hg7@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 31 May 2008 22:03:39 +0200, Bruno Pr=E9mont <bonbons@linux-vserver.=
org> wrote:

>On a Commell LE-365 I get readings for fan speed that are broken about
>10% of the time.
>The board has a Winbond W83697 chip (I can't check the exact chip name
>on the board as it's hidden by a heatsink, the photo from Commell, as
>as well as the manual indicate a HG, the kenrel reports:
>  [    3.572831] w83627hf: Found W83697HF chip at 0x290
>  [    3.572831] WDT driver for the Winbond(TM) W83627HF/THF/HG Super I/O =
chip initialising.
>  [    3.572831] w83627hf/thf/hg WDT: Watchdog already running. Resetting =
timeout to 60 sec
>  [    3.572831] w83627hf/thf/hg WDT: initialized. timeout` sec (nowayout=
=3D0)
>)
>
>Below a sample (reformatted) output of
>  while sleep 1; do
>    date;
>    cat /sys/class/hwmon/hwmon0/device/fan1_input;
>  done

Try slowing down your polling, change to sleep 5.  See if the problem goes =

away.

Grant.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
