From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Mar 2010 12:10:33 +0000
Subject: Re: [lm-sensors] Andigilog asc7621 driver: Temperature scaling
Message-Id: <20100307131033.6230abf6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B930BB3.6030201@kenm.demon.co.uk>
In-Reply-To: <4B930BB3.6030201@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ken,

On Sun, 07 Mar 2010 11:30:13 +0000, Ken Milmore wrote:
> 
> Example:
> 
> The 5V sensor with an input of precisely 5V should give an input MSB 
> register value of 192.
> 
> Using the "full scale" ratios:
> 
>     192 * 6640 / 256 = 4980
> 
> Using the 3/4 scale ratios:
> 
>     192 * 5000 / 192 = 5000
> 
> Error calculation:
> 
>     (5000 - 4980) / 5000 = 0.4%
> 
> This corresponds to a 1-bit error in the 8 bit voltages, or a 3-bit 
> error in the 10 bit voltages, effectively giving only 7-bit accuracy in 
> the calculated values.  An unnecessary error I think you'll agree.
> 
> Although the full scale values could probably be "tweaked" to make them 
> slightly better, the rounding issues inherent with integer arithmetic 
> make it difficult to get right on the button near the nominal voltages, 
> where highest accuracy is appropriate.  This is easily avoided by using 
> the simple 3/4 scale ratios given in the data sheet.

No, you're off track, sorry. The only problem in the driver's formula is
that 6640 was computed as 5000 * 255 / 192, but the formula divides by
256 instead of 255. This is the inconsistency that leads to the 0.4%
error (1/256 = 0.4%). Just use consistent numbers and it will work
fine. The rounding issues inherent to integer arithmetic induce much
smaller errors, down to a level you won't notice them. In the case
above, the max error would be 0.5/6640 = 0.0075%... Way below the
resolution and accuracy of the sensors.

Now, if you insist on using the 3/4 scale values as a basis, really, I
don't care. All I'm saying is this this design change is not _required_
to make the driver return correct values.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
