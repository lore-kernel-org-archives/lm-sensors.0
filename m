From: veso_vdd@mail.orbitel.bg (Vesselin Dimitrov)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: Ticket #920
Message-Id: <200206241157.23874.veso_vdd@mail.orbitel.bg>
List-Id: <lm-sensors.vger.kernel.org>
References: <200206221117.33609.veso_vdd@mail.orbitel.bg>
In-Reply-To: <200206221117.33609.veso_vdd@mail.orbitel.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday 24 June 2002 04:26, you wrote:
> sorry, I meant 2 not 0.
>
> Since i2cdump works (you can see "FLATRON" for example)
> but ddcmon doesn't, the problem is in ddcmon.
>
> Sensors always says the same thing?
> It doesn't ever work?
>
Always.
I think that the problem may be in i2c-voodoo3.o because after
# modprobe i2c-voodoo3
some of the scanlines on the monitor are one pixel to the left of
the others.
