From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: CVS?
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD4405648566@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Sensors-detect sees it (at address 0x7C) but cannot identify it.
> > The documentation calls it "Embedded PCI-X On Board Registers".
> > Does that mean anything to anyone?
> 
> In case you didn't notice it already, 0x7C isn't a standard address.
> It's marked "Reserved for future use" in the SMBus 2.0 specification,
> and latest version of i2cdetect and sensors-detect don't even scan it.

I didn't know - thanks.

However, I'm stuck with it - it's not our hardware.

I'll mention it to the supplier next time they come in.

Meanwhile, I have to get the driver working, but what I'm
hearing is that nobody else will be interested - or at least,
not as part of the standard sensors release.  Is
there anything in the code that will actively stop a
chip driver using it? I can live without i2cdetect and
sensors-detect for this one. I'll I2C_DRIVERID_EXP0
for it to avoid clashes. 

On a lighter note - I asked our IT department if they
had recently started blocking the CVS port (2401) on 
the firewall and explained why I was asking, and got 
the reply "so what web page can't you see?"

Ho-hum - off to do a bit of education..

I can telnet to port 80, but not 2401. I'm still betting 
on a firewall, most likely the one here.

John.
