From: dpnsw@optusnet.com.au (David)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: Can't get 2 sensor chips working
Message-Id: <200302201422.11829.dpnsw@optusnet.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302201051.40585.dpnsw@optusnet.com.au>
In-Reply-To: <200302201051.40585.dpnsw@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't know if I can do that without a storage CRO. I tried altering my 
triggering but can't seem to hold the signal still long enough to actually 
see it.

Don't know if I can sample using my soundcard. I might be able to record 
(dpending on whether the pport bus runs at less than 20Khz in speed.

I then need to find an audio application that will display the waveform in 
scope mode.

Am I missing something or is this my next step?


On Thursday 20 February 2003 12:14, Mark D. Studebaker wrote:
> you can try i2cdump 0 0 0x20
> then look on the scope.
> If the chip is not responding you will see only the chip address and the
> register address
> (2 bytes for each access)
> If the chip is responding you will see the 3rd byte on the bus (the chip
> response)
>
> David wrote:
> > Hi,
> >
> > I am trying to get a PCF8591 and a PCF8574 working using the i2c-pport
> > adaptor.
> >
> > I have at the moment the i2c-pport and algo-bit modules loaded and am
> > trying to get access to the PCF chips.
> >
> > modprobe pcf8574
> > modprobe pcf8591
> > AND
> > modprobe pcf8574 probe=0,0x20
> > modprobe pcf8591 probe=0,0x48
> >
> > don't actually creaate any files under proc and the modules remain unused
> > as far as lsmod is concerned.
> >
> > I can get the devices up if I
> > modprobe pcf8574 force_pcf8574=0,0x20
> > modprobe pcf8591 force_pcf8591=0,0x48
> >
> > everything loads, I get the relavent files under
> > /proc/sys/dev/sensors
> >
> > it doesn't look like I am really taking to the chips though.
> >
> > Changes I make on the inputs aren't reflected in the values under /proc.
> >
> > If I run the i2cdetect 0 I get UU showing in both 0x20 and 0x48
> >
> > I have used my scope and know that signals are getting to the chips in
> > question but it isn't a storage scope so I can't look to see if the
> > pulses are really valid i2c pulses.
> >
> > Any hints on what to do next.
> >
> > --
> > Best Regards,
> >
> > David Price

-- 
Best Regards,

David Price
