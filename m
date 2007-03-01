From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Mar 2007 07:15:18 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070301081518.9c065c02.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans-J?rgen,

On Tue, 27 Feb 2007 20:58:26 +0100, Hans-J?rgen Koch wrote:
> Well, the current implementation assumes that the MAX6650 is initialized by 
> the BIOS. On the other hand, the 5V/12V setting is done by the driver, the 
> value is hardcoded in the source. This doesn't look like a clean solution.

Indeed it wasn't acceptable. Hardware monitoring drivers should, in
general, leave the chip configuration untouched by default.

> I suggest to add module parameters to allow configuration of 5V/12V, 
> prescaler, count and mode. Then we _know_ the settings and can drop the 
> config and the count file. We also get rid of the hardcoded 5V/12V setting 
> and don't need to rely on a BIOS that might or might not do what we want.
> 
> Any objections?

I agree with the general direction. Details may need to be discussed
though.

> > The speed file, what is it doing? If it is used to set the desired fan
> > speed, then the right name would be fan1_target. Does it only apply to
> > one fan or all? Is it always active?
> 
> It sets the speed of the single fan for a MAX6650. For a MAX6651, it sets a 
> speed that is valid for all connected fans, if I understand the data sheet 
> correctly. In any case, this works only if mode is set to "closed loop".

This is what I don't understand, in the case of the MAX6651. I don't
quite see how you can implement a closed loop with 4 possibly different
inputs and only one output.

-- 
Jean Delvare

