From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 May 2011 13:23:10 +0000
Subject: Re: [lm-sensors] Updated emc6w201 driver
Message-Id: <20110522152310.1c286a61@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110522102625.7e065405@endymion.delvare>
In-Reply-To: <20110522102625.7e065405@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 May 2011 10:26:25 +0200, Jean Delvare wrote:
> Feedback welcome. I intend to prepare a patch based on this version of
> the driver and submit it for inclusion in the upstream kernel.

I am writing a short documentation for the driver. There I want to list
the hardware known to have the EMC6W201 chip, as the chip is rare so the
list should be short. It looks like:

* Dell Precision 670 workstation
* Gigabyte 2CEWH mainboard

Which makes me wonder... Could it be that the Dell Precision 670
workstation is actually based on that Gigabyte 2CEWH mainboard? Could
you please check the output of dmidecode, in particular the board
section, to see if there is any reference to Gigabyte? Does the output
of lspci look like the specifications listed here?

http://www.gigabyte.fr/products/product-page.aspx?pid80#sp

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
