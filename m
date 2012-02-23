From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 23 Feb 2012 04:06:16 +0000
Subject: Re: [lm-sensors] Nuvoton W83677HG-I/W83676HG-I
Message-Id: <20120223040616.GA6183@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F45B3ED.7080701@gmail.com>
In-Reply-To: <4F45B3ED.7080701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 22, 2012 at 10:35:09PM -0500, Lee Burchett wrote:
> I have an ASRock board that uses a newer Nuvoton W83677HG-I Super I/O 
> chip. I would like to help develop (or get help developing) a set of 
> drivers for this chip. It is similar to previous versions of Nuvoton 
> chips like the W83627 series. I found the sensor drivers from Guenter 
> Roeck (Thank You) that are intended for the W83627 series. I was hoping 
> to build on these, but I don't know enough about how kernel modules work 
> to proceed.
> 
> The manufacturer was helpful in providing documentation for this chip, 
> the W83627UHG, and the W83627DHG-P. Comparing the devices, I noticed 
> that many of the data formats and I/O methods are the same, So I hope 
> that my new chip can be added in fairly easily.
> 
W83677HG-I and NCT6775F are the same. Did you try the existing driver ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
