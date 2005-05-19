From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: Can't get 2 sensor chips working
Message-Id: <3E542C12.44611109@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302201051.40585.dpnsw@optusnet.com.au>
In-Reply-To: <200302201051.40585.dpnsw@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you can try i2cdump 0 0 0x20
then look on the scope.
If the chip is not responding you will see only the chip address and the
register address
(2 bytes for each access)
If the chip is responding you will see the 3rd byte on the bus (the chip
response)

David wrote:
> 
> Hi,
> 
> I am trying to get a PCF8591 and a PCF8574 working using the i2c-pport
> adaptor.
> 
> I have at the moment the i2c-pport and algo-bit modules loaded and am trying
> to get access to the PCF chips.
> 
> modprobe pcf8574
> modprobe pcf8591
> AND
> modprobe pcf8574 probe=0,0x20
> modprobe pcf8591 probe=0,0x48
> 
> don't actually creaate any files under proc and the modules remain unused as
> far as lsmod is concerned.
> 
> I can get the devices up if I
> modprobe pcf8574 force_pcf8574=0,0x20
> modprobe pcf8591 force_pcf8591=0,0x48
> 
> everything loads, I get the relavent files under
> /proc/sys/dev/sensors
> 
> it doesn't look like I am really taking to the chips though.
> 
> Changes I make on the inputs aren't reflected in the values under /proc.
> 
> If I run the i2cdetect 0 I get UU showing in both 0x20 and 0x48
> 
> I have used my scope and know that signals are getting to the chips in
> question but it isn't a storage scope so I can't look to see if the pulses
> are really valid i2c pulses.
> 
> Any hints on what to do next.
> 
> --
> Best Regards,
> 
> David Price
