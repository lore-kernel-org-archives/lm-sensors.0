From: =?iso-8859-1?Q?Jean-Fran=E7ois_Dagenais?= <jeff.dagenais@gmail.com>
Date: Thu, 09 May 2013 12:38:28 +0000
Subject: Re: [lm-sensors] i2c multimaster and the device driver detect function
Message-Id: <3322BACE-9434-4249-8621-C1AD0D340A8A@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130212164811.GV8668@pengutronix.de> <3D8D1B67-2846-4B78-B402-6B9FD1CB10E6@gmail.com> <20130508175417.GB29689@roeck-us.net> <FCF1B5D0-FF63-40D5-B7B4-D5969628AAD3@gmail.com> <20130509035313.GA26817@roeck-us.net>
In-Reply-To: <20130509035313.GA26817-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org


On 2013-05-08, at 11:53 PM, Guenter Roeck wrote:

> Guess the real conclusion is that one should avoid two active masters
> in the first place if possible.

I agree, I can't think of any benefits worth the trouble.

> Is one of the I2C adapter drivers your own ? If so, you can disable auto-detection
> in the adapter code by setting the adapter class to 0 (specifically, don't set it
> to I2C_CLASS_HWMON). You can do the same in the Kontron driver if you have the
> source (it is GPL so you should be able to find it). While not perfect, that should
> be better than disabling auto-detection in the affected chip drivers.

That's great advice!! I will look into this, thanks!

> Note that the Kontron driver also sets I2C_CLASS_SPD, which means EEPROMs are
> auto-detected on address 0x50.

Funny, I had to explicitly inject "I2C_BOARD_INFO("24c32", 0x50)" to see
Kontron's JIDA chip.

>> [...] Right now I have a working setup where some slaves are
>> declared on bus 0 (PLD i2c master) and others on bus 1 (FPGA i2c master). I have
>> yet to stress test the setup within the next day or so, but so far, it seems to
>> work ok.
>> 
> Sure, it does work, I am just not sure what the benefits are of having two
> masters in this scenario.

My thoughts exactly. I would have avoided it. Right now I am trying to improve
and existing design.

>  Guess you are saying that the I2C master in the
> Kontron PLD can not drive the AD7147 - is that correct ?

Well no, it does drive it, we have it in stable production. It's just that when
you have your finger on the wheel, CPU usage goes up to 5-15%. More intense
polling of the sensors also takes a toll on the CPU. For different reasons other
than the ad714x, the FPGA i2c core option suddenly became attractive.

> If so, and if that
> means you have to use your own I2C core anyway, why bother using the Kontron
> PLD's I2C bus to start with ? You could just ignore it (ie not instantiate

> or build it at all) and use your own.

Yeah, we already considered that... our FPGA's reset and flash select are
controlled by an i2c I/O expander! Hehe, so this I/O expander needs to be
mastered from the kempld. Reality is a bummer ;)

> 
> Did you tell Kontron about the problems with their PLD ? Maybe they have a
> solution.

Yes we did. If I remember correctly, the problem is the absence of an interrupt
line from the PLD to the CPU, which explains the high CPU since the driver
sleeps-polls for async PLD completions and statuses. ... I know...

Thanks for the reply!
Cheers,
/jfd
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
