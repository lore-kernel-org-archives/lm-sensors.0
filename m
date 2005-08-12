From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 12 Aug 2005 19:50:38 +0000
Subject: [lm-sensors] pc87360  voltage reference constants
Message-Id: <20050812195032.12472f35.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42FCC357.1000802@divsol.com>
In-Reply-To: <42FCC357.1000802@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Im looking to understand why my temps are so high,
> esp in comparison to values from my soekris as obtained from
> http://phk.freebsd.dk/soekris/env4801/
> 
>     VREF = 1.214  V245 = 2.450
>     Temp 2 (status=0x81)   54 C
> 
> in your code,
> 
>         data->in_vref = (i&0x02) ? 3025 : 2966;
>         dev_dbg(&new_client->dev, "Using %s reference voltage\n",
>             (i&0x02) ? "external" : "internal");
> 
> youve got 2 magical constants,  where are they from ?
> I cant find mention of them in the pdf,

3.025 is 1.235 * 2.45. Page 227 of the datasheet mentions internal Vref
= 1.235V, and at page 180, section 11.3.2 has: "Analog input voltage is
measured relative to 2.45 * Vref".

In section 14.4.1, external Vref is given at 1.211V, and full scale is
given at 2.097, which happens to be 1.211 * 2.45.

This is where the numbers are coming from. Now I always found it strange
that you could pick an external voltage with a *lower* value than the
internale voltage, and not much lower at that. Remember that I do not
have a PC87366 chip myself, so had no chance to measure the physical
values at a chip's pins to confirm that the driver does the right thing.
If you are using an external reference, and it is NOT 1.211 volt, then I
am not surprised if your voltages are not correct.

Note that the reference voltage is used to compute the voltages and the
thermistor-based temperatures, NOT the diode-based temperatures. The TMS
logical device is influenced by the reference voltage, but the value
isn't used in computations AFAIR.

> BTW, (since Im writing),  my patchset for pc87366 sensors-dev-attrs
> (done against rc4-mm1), also applies (clean, iirc) to rc5-mm1, and
> works  there.

I'm sorry, I didn't have the time to look at it yet. I'm currently busy
with i2c core changes and other drivers (i2c-viapro and it87.) Please be
patient.

-- 
Jean Delvare
