From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Lm_sensors Support DB Entry #849
Message-Id: <20020519174850.A30891@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020519233411.GA13485@chrysler.kbs.twi.tudelft.nl>
In-Reply-To: <20020519233411.GA13485@chrysler.kbs.twi.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 20, 2002 at 01:34:11AM +0200, Boi Sletterink wrote:
> Hi,
> 
> another update on my previously reported problem (Ticket # 849).
> 
> I finally got around to checking out my mainboard and it seems that it has
> an ICS 94228 (rev. 8) clock generator. The good news is that you can find
> the datasheet online: http://www.icst.com/products/summary/via_kt266.htm
> 
> After reading a bit, I found that it is indeed programmable through the I2C
> bus. However, it is rather strange that it is supposed to be on address 0xd2
> instead of 0x4e, where the non-existing lm75 was detected. Then again, I
> don't know much about I2C so I might be wrong here...

A look at the datasheet tells me that they include the r/w bit (lsb)
in the address.  So instead of 0xd2, the address (relative to our
scheme) is bit shifted right one, or 0x69.  That's typical to what
we've seen this kind of chip showing up as, and indeed it shows up in
your scan included in your ticket.  It is also typical to see this
kind of chip hang the bus on a probe, so it might be good to skip this
address when running sensors-detect if you have that kind of trouble.

Humm.. 0x4e remains a mystery.  Thanks anyway for taking the time this
weekend to poke around! 


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
