From: =?iso-8859-1?Q?Jean-Fran=E7ois_Dagenais?= <jeff.dagenais@gmail.com>
Date: Thu, 09 May 2013 01:50:44 +0000
Subject: Re: [lm-sensors] i2c multimaster and the device driver detect function
Message-Id: <FCF1B5D0-FF63-40D5-B7B4-D5969628AAD3@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130212164811.GV8668@pengutronix.de> <3D8D1B67-2846-4B78-B402-6B9FD1CB10E6@gmail.com> <20130508175417.GB29689@roeck-us.net>
In-Reply-To: <20130508175417.GB29689-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org


On 2013-05-08, at 13:54, Guenter Roeck wrote:

> [...]
> Isn't it the point of having multiple masters on the same bus, that each of
> them can manage the same devices ?

I wouldn't think so. You mention why in your last paragraph and I totally see
and agree with that. So that is not my intention at all.

> 
> Question for me is why you would want two masters in the same system context
> point to the same I2C bus. Usually the second master would be something like an
> IPMI controller or a second CPU/controller board in a redundant system.

I guess that's one scenario. In our scenario, we have an assambled board stack.
The main board has a sub-par i2c master onto which heavy slaves such as the
ad7147 capacitive input device consumes too much cpu power (cpu has to poll the
Kontron PLD which houses the i2c master core). Our hoped solution was to
allocate an i2c IP core in our FPGA. But board inter-connect budget didn't allow
for separate i2c segments, especially in the light that both master are said to
support multimaster operation. I got this working experimentally right now, I
just stumbled on jc42's detect, and am trying to project this kind of design to
the future. Right now, my only solution is to patch my version of jc42 not to
auto-detect, and explicitely enumerate my temperature sensors like my other
slaves in arch setup... yikes.

> 
> Even then the multi-master scenario is problematic, as you still end up with
> multiple masters controlling the same device. That is a problem inherent to I2C,
> and especially problematic with multi-page devices (typical problem: master 1
> sets page, master 2 sets page, master 1 accesses wrong data). I don't think there
> is a clean solution to solve that, other than to block i2c access for one of the
> masters entirely.

Other than the redundant/resiliency scenario, why would you setup the same slave
on two different masters? Right now I have a working setup where some slaves are
declared on bus 0 (PLD i2c master) and others on bus 1 (FPGA i2c master). I have
yet to stress test the setup within the next day or so, but so far, it seems to
work ok.

Thoughts?
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
