From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 May 2010 12:03:15 +0000
Subject: Re: [lm-sensors] after some days,
Message-Id: <20100520140315.7f01813c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
In-Reply-To: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Arne,

Please don't top-post.

> 2010/5/12 Jean Delvare <khali@linux-fr.org>:
> > On Tue, 11 May 2010 11:39:33 +0200, Jean Delvare wrote:
> > I took a look, I see the BIOS is defining an I/O region as part of
> > PNP0C02 for the hardware monitoring chip (you probably can see it
> > in /proc/ioports), but it doesn't seem to make any use of it. So I
> > would rule out a BIOS interaction.

On Mon, 17 May 2010 10:01:41 +0200, Arne Riecken wrote:
> What to do now to track down the problem? I need to check the sensors
> data. But doing sensors -s in a cron job is no real solution.

We still have to determine whether the driver is responsible for the
issue or not. If you can't live without the driver being loaded, we
would have to either add an option to turn the driver to read-only
mode, or to log all writes so that you can check what happens exactly.
In both cases, this requires rebuilding the driver. Are you willing and
able to do this? If you are, let me know and I'll provide a patch.

Honestly, I suspect a hardware defect. Nobody else ever reported a
similar problem, while this driver is very popular.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
