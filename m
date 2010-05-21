From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 21 May 2010 09:04:52 +0000
Subject: Re: [lm-sensors] [PATCH 0/2 v2] hwmon: (ltc4245) fix GPIO support
Message-Id: <20100521110452.4cac5613@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271199569-3880-1-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1271199569-3880-1-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Tue, 13 Apr 2010 15:59:27 -0700, Ira W. Snyder wrote:
> This patch series fixes support for using a GPIO line as an analog input to
> the ADC on the LTC4245 chip. Jean suggested dropping support for multiple
> GPIO lines, and then adding it back as an optional feature.
> 
> I think this is fairly unintrusive to the ltc4245 code, and the multi-GPIO
> support is well encapsulated in a seperate function, hidden behind a kernel
> configuration option.
> 
> I have tested the sensors utility with the -EAGAIN code for stale values.
> The output looks like this:
> 
> ltc4245-i2c-1-22
> 12V  Input:      +11.66 V
> 5.0V Input:       +5.10 V
> 3.3V Input:       +3.19 V
> VEE  Input:       +0.00 V
> 12V  Output:     +11.66 V
> 5.0V Output:      +5.08 V
> 3.3V Output:      +3.19 V
> VEE  Output:      +0.00 V
> Dig 3.30v Output: +3.26 V
> ERROR: Can't get value of subfeature in10_input: Can't read
> Dig 2.25v Output: +0.00 V
> ERROR: Can't get value of subfeature in11_input: Can't read
> Dig 1.80v Output: +0.00 V
> 12V  Power:      816.20 mW
> 5.0V Power:        4.90 W
> 3.3V Power:        1.44 W
> VEE  Power:        0.00 nW
> 12V  Current:     +0.07 A
> 5.0V Current:     +0.96 A
> 3.3V Current:     +0.45 A
> VEE  Current:     +0.00 A
> 
> Using cat to read the inX_input nodes, I get the expected output:
> 
> cat: in9_input: Resource temporarily unavailable
> 
> So I think that the lm-sensors software will handle this method of showing
> stale values just fine.

I still think the current error handling is less than ideal. If it
becomes common that hwmon drivers return errors, I'd prefer them to
look nice in the output of "sensors". Something like:

> Dig 3.30v Output: +3.26 V
> Dig 2.25v Output:     N/A
> Dig 1.80v Output:     N/A

Hopefully this wouldn't be too hard to implement. What do you think?

We might have to invent new libsensors error codes to differentiate
between error cases, or give callers a way to retrieve the original
error code.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
