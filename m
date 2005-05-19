From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Info on Epox 8RDA+ motherboard sensors
Message-Id: <20030717084025.139fd704.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307162235.12732.ep@plicht.de>
In-Reply-To: <200307162235.12732.ep@plicht.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> sensors-detect reports a Winbond W83627HF chip.
> 
> BIOS has display for
> Vdd (1.6V)
> Vcore (1.66V)
> Vdimm (2.64V)
> and the other usual power supply voltages, except:
> 
> BIOS has NO display for 3.3V. So I don't know if this is really not
> used or what.

Is this voltage correctly shown by sensors? It is supposed to be used by
PCI and AGP cards. Some on these can also work at 5V (or even 12V) but
since not all of them do, I doubt your motherboard don't provide it at
all. Maybe the BIOS doesn't show it because it is unused on your
specific system, but would if you were to add a card that needs it (just
guessing.)

I suppose that sensors doesn't report Vdimm?

> VID was reported as 3.50V, so I changed the in0_min/max and
> in1_min/max calculation from using vid to 1.6V, works fine.

Did you try changing the vrm? It should help.

> Fan divisors needed to be set to 4 instead of default 2, now working
> nicely.

This is probably related to your fans, not the motherboard itself.

> That's all. Again, thanks, let me know if you need any other data on
> this motherboard.

Thanks for the report.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
