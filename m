From: David Brownell <david-b@pacbell.net>
Date: Wed, 16 Apr 2008 17:52:03 +0000
Subject: Re: [lm-sensors] lm75: Convert to new-style I2C driver
Message-Id: <200804161052.03649.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
In-Reply-To: <200804161434.54335.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 16 April 2008, Jean Delvare wrote:
> 
> > Sorry. Is there any plan to support new-style device drivers for PC hardware 
> > in the future ?
> 
> I have something in mind but it's not clear if it will really happen.
> 
> We can't enumerate the I2C/SMBus hardware monitoring chips on PCs as we
> do on embedded platforms, because there are soooo many different PC
> motherboards (some of which cannot even be identified) that we wouldn't
> be able to list them all. So we still have to rely on probing somehow.

Hence my lm75 new-style conversion, supporting both binding styles.

I didn't actually look at that in as much detail as it deserves...
arguably "legacy" binding should be explicitly turned on as a result
of a user mode probe, along the lines of sensors-detect.

- Dave


> However, I agree that switching to new-style i2c devices would be nice.
> So what I have in mind is a dedicated kernel driver that would do the
> probing and would instantiate the (new-style) I2C/SMBus hardware
> monitoring devices.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
