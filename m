From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Intel S845WD1-E
Message-Id: <200404281155.24746.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404280005.56044.lists@localguru.de>
In-Reply-To: <200404280005.56044.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 28 April 2004 11:23, Jean Delvare wrote:
> > Ah, nice! I'm running Debian/woody (kernel 2.4.18) which contains the
> > following source packages of lm-sensors and i2c:
> >
> >    Package: lm-sensors-source - Version: 2.6.3-5
> >    Package: i2c-source - Version: 2.6.3-5
> >
> > Are these versions too old?
>
> They are admittedly old, but I'd expect the i2c-i801 driver to already
> support your Intel chip though. The best way to make sure is to try,
> don't you think? Just try modprobing i2c-i801 and see what happens. If
> it doesn't work, then provide the output of "lspci -n".

jippt, I will test it and give you a report!

Ciao
