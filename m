From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Ticket 714
Message-Id: <20011111165250.A12035@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200111091109.FAA08820@buzzsaw.buzzsaw.net>
In-Reply-To: <200111091109.FAA08820@buzzsaw.buzzsaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Isn't '0x00' the host (or another host if more than 1 is on the same
bus, which is illegal I think)? I forgot... I'd have to dig out the
Philips docs to be sure. 


Phil

On Fri, Nov 09, 2001 at 07:57:50PM -0500, Mark D. Studebaker wrote:
> I agree. I've never heard of a device at 0x00 before,
> it is probably something ill-behaved.
> 
> 'i2cdetect 0' will list the devices that are present, but
> we already know from the sensors-detect output that there is
> something at 0x00.
> 
> 'i2cdump 0 0' will list the registers in the device at 0x00.
> And you say when it gets to address 0x2d in device 0x00 the ethernet
> dies? very very strange.
> 
> Let us know what the ethernet datasheet says...
> 
> mds
> 
> 
> 
> 
> Rick F Nicholson wrote:
> > 
> > I added the "LM75" to the mix just because it had been detected. I normally loaded
> > just "i2c-viapro" and "w83781d".
> > 
> > I think your comment about something else on the i2c bus being ill-behaved is
> > relevent. The onboard network drops out consistantly  when a "Bus Collision"
> > occurs.
> > 
> > Also tried just the "i2c-isa" and got the same results.
> > 
> > rfn

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
