From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Dec 2011 08:39:06 +0000
Subject: Re: [lm-sensors] [PATCH] i2c multiplexer driver for Proliant
Message-Id: <20111206093906.21dccf8d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com>
	<20111127225514.GO19115@trinity.fluff.org>
	<CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com>
	<20111203162757.GA24302@ericsson.com>
	<CAKdnbx54R9t-mS9-EvyT-618wVp-YH0YDO++=m5t-JqR6h=GCw@mail.gmail.com>
	<20111203180819.2ddbcb3a@endymion.delvare>
	<CAKdnbx5V=qfa5dshRudHx+M3o8Eb6qJXCVG+ZBaBwCeKaoQYNA@mail.gmail.com>
In-Reply-To: <CAKdnbx5V=qfa5dshRudHx+M3o8Eb6qJXCVG+ZBaBwCeKaoQYNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Hi Eddi,

Please don't top-post, and only include as much context as necessary in
your replies.

On Mon, 5 Dec 2011 23:57:10 +0100, Eddi De Pieri wrote:
> I tried in rewriting the driver... but I can't understand the right way...
> 
> since sb800 is a southbus, the mux driver must be defined as
> i2c_device, platform_device, or pci_device?

Your question doesn't make sense. A driver can't be defined as a
device. But anyway I think I understand where your confusion comes
from. The SMBus multiplexing as it exists on the SB800 is very
different from what was implemented for the Tyan S4882 and S4985 boards.

In fact, now that I have a SB800 datasheet, I better understand what
you were doing and how it should be implemented. I don't even think you
need the multiplexer framework for the SB800. My understanding is that
it has 4 almost independent SMBus ports. The only thing that is shared
between them is the register set. Contrary to the S4882 and S4985 board
multiplexing, it is totally board-independent. So support should go to the
i2c-piix4 driver directly.

BTW please avoid comments in Italian in your code. Not everyone reads
Italian. Use English.

> I tried using i2c_device structure, but I can't make sb800 to match
> the id_Table..
> I tried usign pci_device structure, but the driver overwrite the pci
> space so kernel hangs...

You don't need a multiplexer device at all. Please just have i2c-piix4
driver register 4 i2c_adapter devices for the SB800. This would be a
3-step process:

1* Turn piix4_adapter to an array, so that it can hold up to 4
   i2c_adapter structures.
2* Add a mutex to prevent concurrent access to the register set. It
   should be initialized in piix4_setup_sb800(), taken at the very
   beginning of piix4_access() and released at the very end of this
   function.
3* Add support for ports 1, 2 and 3 of the SB800.

This would ideally be 3 incremental patches to make testing and review
easy. I can help with parts 1 and 2 if you want, as this can be tested
without a SB800. But it should be fairly easy overall.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
