From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 Dec 2011 16:04:25 +0000
Subject: Re: [lm-sensors] Kernel module asus_atk0110
Message-Id: <20111205170425.3bffac3b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EDA27AA.7030203@catcons.co.uk>
In-Reply-To: <4EDA27AA.7030203@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 5 Dec 2011 16:28:19 +0100, Luca Tettamanti wrote:
> On Mon, Dec 5, 2011 at 3:43 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Mon, 05 Dec 2011 19:44:30 +0530, Charles wrote:
> >> I temporarily commented out w83627ehf and added asus_atk0110 then
> >> removed kernel option acpi_enforce_resources=lax, rebooted and created a
> >> file by catting /sys/firmware/acpi/tables/DSDT which I am sending you
> >> off list.
> >
> > The question is, does "sensors" output anything with only the
> > asus_atk0110 driver loaded? If not, hopefully Luca will be able to
> > figure out why from the DSDT.
> 
> ATK0110 is not present in the DSDT. The IO range is reserved and used
> to check a single temperature against high and hysteresis thresholds
> (see method _L16) and notify WMI (yeah...). The method also reads a
> bit at 0x41 (AUIS) which is not used in the linux driver; the value is
> discarded, it might be a read-to-clear alarm bit; Jean do you know
> what that might be?

Register 0x41 is named Interrupt Status Register 1 in the datasheet,
bit 5 is named SOURCE2_SMI:
	A one indicates the high limit of SMIOVT SOURCE2 temperature has been exceeded.
	(CPUTIN is default temperature)

> Anyway, the board does not expose a monitoring framework :-(

But it exposes a register map (HWRE)... Might this be used to access
the hardware monitoring chip without interfering with ACPI? I'm not
saying that would be particularly nice, but I don't think we have any
other option, do we?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
