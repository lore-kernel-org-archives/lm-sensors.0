From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 14 Sep 2012 13:20:58 +0000
Subject: Re: [lm-sensors] acpitz-virtual-0
Message-Id: <20120914152058.7c018f68@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADsebomK8pjFc6MBZ8_Xdxztj7NmBsQoh9B=8VQ=eMRhNANimA@mail.gmail.com>
In-Reply-To: <CADsebomK8pjFc6MBZ8_Xdxztj7NmBsQoh9B=8VQ=eMRhNANimA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 13 Sep 2012 14:31:02 -0400, Super Groomers wrote:
> I am running lm-sensors version 3.3.2 on kernel version 3.2.0-29
> generic on an Intel DZ77GA-70K motherboard, cpu is Ivy Bridge I7-3770.
> The sensors output is listed below.
> sensors-detect detects coretemp and the Winbond chip, they each seem
> to differ from the "virtual acpitz-virtual-0." How could I find out
> what this interface corresponds to and what thermal zone is being
> reported here?

You can't really. It's all hidden behind ACPI magic. You may have a
hint with:

$ grep . /sys/class/thermal/thermal_zone*/device/path

but in general the name is generic and thus not useful. So the only way
to know where exactly ACPI gets its values is by disassembling the
DSDT, and looking for the code behind the thermal zones. Nothing easy
and pleasant.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
