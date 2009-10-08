From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Oct 2009 14:08:43 +0000
Subject: Re: [lm-sensors] 8-bit ADC, LSB = 8mV - 2.048V or 2.04V?
Message-Id: <20091008160843.262f3e98@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <hakqgi$q6$1@ger.gmane.org>
In-Reply-To: <hakqgi$q6$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

On Thu, 08 Oct 2009 08:46:57 -0500, Ian Pilcher wrote:
> Thanks to the nonsensical responses I'm getting from MSI, I'm digging in
> to the W83627EHF datasheet to try to figure out what's connected to what
> on my board.
> 
> According to the datasheet, this chip uses an 8-bit analog-to-digital
> converter for voltage measurements, where the least significant bit
> represents 8 mV.  They state that this results in a maximum measurement
> of 2.048 V (2048 mV), but I can't figure out their math:
> 
>     bit 0 (LSB)       8 mV
>     bit 1            16 mV
>     bit 2            32 mV
>     bit 3            64 mV
>     bit 4           128 mV
>     bit 5           256 mV
>     bit 6           512 mV
>     bit 7          1024 mV
>                   ---------
>                    2040 mv     (2.04 V)
>                   ====> 
> Am I missing something?

You are mathematically correct, but the datasheet is possibly correct
too ;)

By their analog nature, ADC chips don't map discrete voltage values to
their digital representation, but voltage _ranges_. For example, a
voltage of 16 mV would be represented as 0x02 but a voltage of 17 mV
would be represented as 0x02 too. So the reality isn't that "16 mV is
represented as 0x02" but rather "voltages ranging from 16 mV to 24 mV
are represented as 0x02" so that all values within the ADC range are
covered.

Under this light, you understand that the values represented by 0xff
would be not just 2.040 V but any value between 2.040 V and 2.048 V,
which means that the datasheet is correct.

In practice this is an error of 0.2%, which you can just ignore. The
error incurred by scaling resistors and electrical noise is at least as
important.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
