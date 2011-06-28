From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jun 2011 16:30:19 +0000
Subject: Re: [lm-sensors] asus_atk0110 and suspend-to-disk
Message-Id: <20110628183019.2182d219@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110617205743.28aaf44a@endymion.delvare>
In-Reply-To: <20110617205743.28aaf44a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

Thanks for all the suggestions and sorry for the late reply. I'm just
looking into this again.

On Fri, 17 Jun 2011 23:05:25 +0200, Luca Tettamanti wrote:
> On Fri, Jun 17, 2011 at 8:57 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > I understand that the asus_atk0110 driver only reads from the
> > monitoring device and doesn't attempt to configure it, so I very much
> > doubt it is related to the problem in any way. But do you think there is any way to
> > save and restore the settings at suspend/resume through the ATK0110
> > interface so that they aren't lost?
> 
> I guess that the setting is not lost (it's written somewhere in NVS),
> but maybe the BIOS fails to reprogram the fan controller when coming
> out from S4.
> You can check the Q-FAN profile of the CPU and the chassis fans with:
> # cpu
> echo 0x04070010 > /sys/kernel/debug/asus_atk0110/id
> cat /sys/kernel/debug/asus_atk0110/gitm

0x00000001

> echo 0x04070011 > /sys/kernel/debug/asus_atk0110/id
> cat /sys/kernel/debug/asus_atk0110/gitm

0x00000001

> # chassis
> echo 0x04070070 > /sys/kernel/debug/asus_atk0110/id
> cat /sys/kernel/debug/asus_atk0110/gitm

cat: /sys/kernel/debug/asus_atk0110/gitm: Input/output error

> echo 0x04070071 > /sys/kernel/debug/asus_atk0110/id
> cat /sys/kernel/debug/asus_atk0110/gitm

cat: /sys/kernel/debug/asus_atk0110/gitm: Input/output error

Results are the same before suspend to disk and after resume.

Do you know if gitm reads from the hardware directly or from a cache in
memory?

> IDs are based on the DSDT of a P5Q Pro (no L), in case of errors
> please send me the DSDT of the board.

Available at:
http://khali.linux-fr.org/devel/misc/Asus-P5QL-Pro.dsdt

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
