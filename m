From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 21 Oct 2005 13:11:33 +0000
Subject: [lm-sensors] Support for SMSC 47M15x/192
Message-Id: <K5teArDV.1129892324.1254350.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510162303.21468.pavouk@pavouk.org>
In-Reply-To: <200510162303.21468.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Pavel,

On 2005-10-20, Pavel Ruzicka wrote:

> Thanks for help. Fan measuring works now with lm_sensors 2.9.2.
>
> sensors output:
> --------------
> smsc47m1-isa-0800
> Adapter: ISA adapter
> fan1:        0 RPM  (min =  640 RPM, div = 8)          ALARM
> fan2:     1059 RPM  (min =  640 RPM, div = 8)
> --------------
>
> I look at motherboard, and there is exactly LPC47M997-NR SMSC I/O chip.

OK, so this suggests that this chip is compatible with the LPC47M15x and
LPC47M192 chips as far as fan monitoring is concerned. You can set
fan1_min to 0 to get rid of the alarm. That's a slow fan you have here,
BTW.

Could you please try changing limits, clock dividers, and playing with
PWM outputs? This would confirm that this chip is fully compatible. If
it is, we will need to update our documentation (and sensors-detect) to
reflect the fact that our smsc47m1 driver supports that chip.

> There are probably hardware monitoring block, which is not supported by
> this driver. I look at bios and Winblows program PC Alert, and there are
> available System and CPU Temperature. Voltages are not supported.
> I searched with Google, but datasheet for this chip is not available.
> What can I do next for temperature reporting?

The LPC47M15x and LPC47M192 do have a hardware monitoring block, so maybe
your chip does too. However, we can't be certain without a datasheet,
and the SMSC web site still doesn't even mention this chip.

The problem is that your system SMBus uses an ATI chip which we have no
driver for, and I don't even think a datasheet is available. Since the
hardware monitoring block is accessed through the SMBus, you won't be
able to even access it without an ATI SMBus driver. Sorry.

You may try the ACPI "thermal" driver and look in
/proc/acpi/thermal_zone. Maybe it'll at least let you know the CPU
temperature.

> There was some discussion about this chip:
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket76

We'll update this ticket to mention the supposed compatibility with the
other chips, once you have reported your test results.

Thanks,
--
Jean Delvare
