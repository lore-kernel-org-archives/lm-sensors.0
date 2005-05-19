From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Need help with SMBus access
Message-Id: <20020619093448.F1893@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <88104910359.20020617214333@nm.ru>
In-Reply-To: <88104910359.20020617214333@nm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



You will need to make a driver to drive the I2C/SMBus on the mobo.
That's done through ISA or PCI, depending on the chip.  See
lm_sensors2/kernel/busses for our drivers.  Then, the use that driver
to drive the I2C/SMBus chip on that bus, see lm_sensors2/kernel/chips.

Of course, if you use any of our code, make sure you comply with our
license.

Good luck!


Phil

On Mon, Jun 17, 2002 at 09:43:33PM -0700, Roman Morozov wrote:
> 
>    Dear colleagues!
> 
>    I have to write some hardware monitoring and controlling software
>    (it's currently for Win32 - ops. =)), exactly air- or watercooling
>    thermoelectric system for CPU cooling.
> 
>    It seems, best way to do it is to monitor CPU temperature and on
>    some threshold value use fan controlling circuit to turn it on/off.
> 
>    I've done ISA-bus reading, (I've had ITE it8705f on my Gigabyte
>    GA-7VTXE+), it's pretty easy. But I have brains (or whatever I had
>    inside =)) melted with SMB access. Can you give me some hints about
>    how should I start? I have some MBs with Via686a.
> 
>    Thank you anyway!
> -- 
> Best regards, Roman                          mailto:red-lynx@nm.ru
> Moscow Inst. of Electronic Engineering
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
