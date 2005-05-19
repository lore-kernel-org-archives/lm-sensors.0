From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: 8736x (Was: 3736x)
Message-Id: <4073441B.9050609@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081238970.407265ba15e0d@imp.gcu.info>
In-Reply-To: <1081238970.407265ba15e0d@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

agreed on all counts

Jean Delvare wrote:
> According to Mark Studebaker:
> 
> 
>>I verified that the 37365/66 fan monitoring/control is identical to
>>the one supported by pc37360-fan.
> 
> 
> Correct, except that it's 87360, not 37360.
> 
> 
>>Therefore I propose that we add the voltage and temp sensor support
>>for the 65/66 to that module, and we rename the module to pc3736x.
> 
> 
> The "fan" suffix was mainly there to avoid a name conflict with another
> pc87360 driver, not to reflect the fact that these chips were not
> complete hardware monitoring chips. These Super I/0 chips are much more
> than hardware monitoring chips and I thought that maybe there would be
> other drivers for the other logical devices (as part of the Linux
> kernel tree, or a different external project).
> 
> So the new driver name could have been pc37360-hwmon. But now that I
> come to think a little more about it, it turns out that the other
> logical devices most likely don't need a specific driver, so the suffix
> is probably not necessary and we can just drop it.
> 
> As for the exact name, I don't much like the idea of having "x" in
> driver names. It's not very informative about which values "x" can
> hold. And for example, someone googl'ing for "pc8736x" will get much
> fewer and less relevant answers than with "pc87360". Also, if other
> chips with a different name happen to be compatible with these ones,
> they won't fit in the name anyway.
> 
> The lm_sensors' project tends to use the first supported chip name as
> the driver name, as far as I can tell, and I would suggest that we
> stick to this. For this reason, I propose that we rename the driver
> "pc87360".
> 
> I would then add write support for the fan part and add the 365 and 366
> to the list of supported chips. Do we agree that we can ignore
> National's recommendation of not writing to the chip while monitoring
> is enabled?
> 
