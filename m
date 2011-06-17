From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 17 Jun 2011 21:05:25 +0000
Subject: Re: [lm-sensors] asus_atk0110 and suspend-to-disk
Message-Id: <BANLkTi=8Ai16fK9yesH2OMfYnFLO5dP1wg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110617205743.28aaf44a@endymion.delvare>
In-Reply-To: <20110617205743.28aaf44a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

On Fri, Jun 17, 2011 at 8:57 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Since a few days now, my wife has a new system based on an Asus P5QL Pro
> motherboard, which uses your asus_atk0110 driver. She noticed that,
> with this new board, CPU fan speed bumps to maximum when resuming from
> suspend-to-disk (hibernation.) In the BIOS I have set the CPU fan speed
> control to silent mode, and apparently system-to-disk loses the
> setting, so the fan goes to full speed on resume. Very annoying.
>
> Have you ever heard of this problem?

Nope, I've never received such a report (and it works fine here). Does
silent mode kick back after a reboot?
In that case you can try changing the power down method to shutdown
before suspending:
echo shutdown > /sys/power/disk
uswsusp can do this for you if you put "shutdown method=shutdown" in
its config file.

> I understand that the asus_atk0110 driver only reads from the
> monitoring device and doesn't attempt to configure it, so I very much
> doubt it is related to the problem in any way. But do you think there is any way to
> save and restore the settings at suspend/resume through the ATK0110
> interface so that they aren't lost?

I guess that the setting is not lost (it's written somewhere in NVS),
but maybe the BIOS fails to reprogram the fan controller when coming
out from S4.
You can check the Q-FAN profile of the CPU and the chassis fans with:
# cpu
echo 0x04070010 > /sys/kernel/debug/asus_atk0110/id
cat /sys/kernel/debug/asus_atk0110/gitm
echo 0x04070011 > /sys/kernel/debug/asus_atk0110/id
cat /sys/kernel/debug/asus_atk0110/gitm
# chassis
echo 0x04070070 > /sys/kernel/debug/asus_atk0110/id
cat /sys/kernel/debug/asus_atk0110/gitm
echo 0x04070071 > /sys/kernel/debug/asus_atk0110/id
cat /sys/kernel/debug/asus_atk0110/gitm

IDs are based on the DSDT of a P5Q Pro (no L), in case of errors
please send me the DSDT of the board.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
