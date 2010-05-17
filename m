From: Arne Riecken <arne.riecken@googlemail.com>
Date: Mon, 17 May 2010 08:01:41 +0000
Subject: Re: [lm-sensors] after some days,
Message-Id: <AANLkTinaMv-dLbpxaa5ZmRKpDhfvmPEcDBIz5v34cJmd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
In-Reply-To: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

What to do now to track down the problem? I need to check the sensors
data. But doing sensors -s in a cron job is no real solution.

2010/5/12 Jean Delvare <khali@linux-fr.org>:
> On Tue, 11 May 2010 11:39:33 +0200, Jean Delvare wrote:
> I took a look, I see the BIOS is defining an I/O region as part of
> PNP0C02 for the hardware monitoring chip (you probably can see it
> in /proc/ioports), but it doesn't seem to make any use of it. So I
> would rule out a BIOS interaction.
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
