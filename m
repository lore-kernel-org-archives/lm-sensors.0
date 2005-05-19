From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Ticket 714
Message-Id: <3BEC7B8E.95F848BC@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200111091109.FAA08820@buzzsaw.buzzsaw.net>
In-Reply-To: <200111091109.FAA08820@buzzsaw.buzzsaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I agree. I've never heard of a device at 0x00 before,
it is probably something ill-behaved.

'i2cdetect 0' will list the devices that are present, but
we already know from the sensors-detect output that there is
something at 0x00.

'i2cdump 0 0' will list the registers in the device at 0x00.
And you say when it gets to address 0x2d in device 0x00 the ethernet
dies? very very strange.

Let us know what the ethernet datasheet says...

mds




Rick F Nicholson wrote:
> 
> I added the "LM75" to the mix just because it had been detected. I normally loaded
> just "i2c-viapro" and "w83781d".
> 
> I think your comment about something else on the i2c bus being ill-behaved is
> relevent. The onboard network drops out consistantly  when a "Bus Collision"
> occurs.
> 
> Also tried just the "i2c-isa" and got the same results.
> 
> rfn
