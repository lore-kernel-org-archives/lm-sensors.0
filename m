From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: GigaByte 7DXR (cleared)
Message-Id: <3C5FF2C5.5C506B42@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020205053016.GA7663@informatik.tu-muenchen.de>
In-Reply-To: <20020205053016.GA7663@informatik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

via686a detection broken in 2.6.2, already fixed in CVS, as noted on our home page.

Martin Stumpf wrote:
> 
> Hi,
> 
> > I have a GigaByte 7DXR Mainboard. With this board the lm-sensors do
> > not work correctly.
> Now I found a working module combination. I first have to load
> i2c-isa then i2c-viapro and last via686a.
> 
> > The I2C-ViaPro is loaded and the LM80 and LM75.
> My question is why does sensors-detect only finds LM80 and LM75 which
> do not work correctly.
> 
> I don't know, whether this can be fixed?
> 
> P.S.: A friend with a NMC board had problems, too. He said
> aensors-detect didn't find anything. And then after a while
> he found the working combination i2c-isa, i2c-viapro, via686a.
> 
> Regards,
>   Martin
