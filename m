From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Tellerstats, Computer Hardware Statistics
Message-Id: <MDhfONzF.1108641486.9708530.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <pT0OxCEG.1108373919.2908350.khali@localhost>
In-Reply-To: <pT0OxCEG.1108373919.2908350.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Morgan,

> > Setting low temps to 40 degrees doesn't sound like a sane thing to do.
> > This means that temperatures below 40 degrees C will trigger an alarm. I
> > do not personally consider it a problem when my systems run at 25
> > degrees C. In fact, down to 15 degrees C seems to be fairly acceptable
> > for any hardware, so you could just set the low limits to this.
>
> I was intending to use the low temps to trip the fan cut off, when I
> worked out how to control the fan.  May be incorrect strategy?

This depends on how the chip is wired. Hardware alerts may or may not be
generated on low limit acrossing. If they are, this might cause trouble,
and actually your original report suggests that might be the case.

I would definitely start with a reasonable low limit (say 10 degrees).
Then, if everything seems to work OK, you can try a higher value and see
if trouble arise.

For fan regulation, I'd hope that the ACPI thermal zone and fan setup
would provide what you need in a more efficient way. As a side note,
ACPI might be accessing the chip concurently. That might explain the
problems you observed.

> Only as sure as knowing what sensors-detect said:|  (See attached.)  The
> dump for 0x69 (apart from appearing to be nothing) took quite a while to
> output (cf. dump for 0x4e).  It's a clevo 2200t with desktop pIII in,
> thus the heat generation.

OK, dump seems to confirm the MC1066. 0x69 is a write-only clock chip.
Such chips usually don't like being read, this the errors and delay.
Hint: don't try that again.

> lm_sensors-2.8.6-1, as per fc2.  I realise this considered broken, but
> thought I'd stick with what's provided for the distro - would an update
> prove more useful?
> Kernel is 2.6.10-1.9_FC2

Should work just fine in your case, I don't think an update will help.

--
Jean Delvare
