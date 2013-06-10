From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 10 Jun 2013 07:40:17 +0000
Subject: Re: [lm-sensors] k10temp-pci-00c3 goes from 11 to 0 degrees
Message-Id: <20130610094017.331ac1f1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABp=A6OdWf_q8vcc65R532xJswsYQBnNgX9ZyyaLDy6hx4qWGA@mail.gmail.com>
In-Reply-To: <CABp=A6OdWf_q8vcc65R532xJswsYQBnNgX9ZyyaLDy6hx4qWGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

Please keep the list in Cc.

On Mon, 10 Jun 2013 00:25:45 +0200, Steven Vanden Branden wrote:
> Op zondag 9 juni 2013 20:45:33 schreef u:
> > So you have an unsupported Super-I/O. Would be great if you could try
> > to find out what it is. Another user reported a Fintek F71868AD with
> > that device ID. We don't support it yet, and without a datasheet we
> > can't support it, but maybe your Windows monitoring tool has support
> > and the good temperature reading you were seeing is from that chip and
> > not the AMD CPU integrated sensors.
> 
> I suppose that its the same i/o chip , and i also suppose the other user asked 
> fintek for a datasheet?

You shouldn't suppose, and I don't know.

> The windows monitor is the msi control center. It shows 2 temperatures, one 
> from the apu and 1 from inside the casing. I do not know if those 2 are 
> controlled by that same chip.

If the tool doesn't say, it's difficult to guess.

> How does the reading of the temperature works for apu's? We probebly need that 
> finteck chip to read the apu temperature also?

Well normally all recent CPU have an embedded digital thermal sensor,
but apparently it isn't returning proper values in your case.

Note though that these integrated digital sensors are documented by
both Intel and AMD as having very bad accuracy at low temperatures. As
the sensor is can't return negative values, the "0" you get may simply
mean that your CPU is very well cooled.

But it is also possible that your CPU digital sensor is defective, I
don't know. There have been many such cases reported in the past, for
specific CPU lines.

Either way, most boards also have a monitoring chip, which can monitor
several temperatures, and often one of the temperature inputs is
connected to an analog temperature inside or underneath the CPU. This
may be what you're seeing in the BIOS / Windows.

> Im very sure the sensor works nice because windows and bios work fine too! 
> Also the fan can be controlled via windows or the BIOS. So i suppose that i 
> also uses that same chip?

Yes, it is likely that the Super-I/O is responsible for both
temperature monitoring and fan control.

> Please let me know if i have to send a mail to MSI or Finteck for that 
> datasheet? You know where i can find a datasheet of the motherboard so i can 
> verify the same chip is there?

Best is to open the case and read the chip marking.

Your motherboard's manual doesn't mention the Super-I/O chip name,
unfortunately.

Asking MSI and/or Fintek for a datasheet is always a good idea. But
first you have to ensure this is a Fintek chip, and find the exact chip
name.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
