From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Mar 2010 10:44:47 +0000
Subject: Re: [lm-sensors] Andigilog asc7621 driver: Temperature scaling
Message-Id: <20100307114447.5969dd51@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B930BB3.6030201@kenm.demon.co.uk>
In-Reply-To: <4B930BB3.6030201@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 07 Mar 2010 10:20:13 +0000, Ken Milmore wrote:
> Regarding the scale factors, I think you'll find that those given for 
> the 2.5V, 3.3V and 5V ranges are far enough wrong introduce a 2-bit 
> error in the 10-bit values.  The driver goes to some trouble to get the 
> full 10 bit precision by combining both the MSB and LSB registers, then 
> throws that precision away in the calculations!
> 
> You really do need to use the 3/4 scale voltage values, or some 
> equivalent rational scaling, to get the right answers here.  That's why 
> Andigilog provide them in the data sheet! :-)

Whether you use the full scale or 3/4 scale voltage values as the base
for the calculation doesn't matter, both can work as long as the
calculation is consistent. What really matters is to multiply before
you divide.

> I will try and get a patch together as soon as time permits.

Great, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
