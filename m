From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <s62KuN6T.1106238493.8706410.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501201042300.5315@localhost.localdomain>
References: <20050108103449.345def67.khali@linux-fr.org>
In-Reply-To: <20050108103449.345def67.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nico@cam.org
Cc: LM Sensors <sensors@Stimpy.netroedge.com>, lkml <linux-kernel@vger.kernel.org>, Jonas Munsin <jmunsin@iki.fi>, Simone Piunno <pioppo@ferrara.linux.it>, Greg KH <greg@kroah.com>


Hi Nicolas,

> It looks like only temp3 is used for the CPU temperature, fan1 is the
> CPU fan and fan2 the case fan.

This is coherent with your chip configuration.

> I experimented with isaset tweaking individual bits in register 0x14
> (blindly I confess, haven't read the datasheet) and flipping bit 3 from
> 0 to 1 (writing 0xdf) apparently reverses the behavior, i.e. the CPU fan
> speed now increases with the CPU temperature.

That's odd. This bit isn't supposed to significantly change the
behavior. When cleared (default), possible duty cycles range from 0 to
100%. When set, the possible duty cycles range from 20% to 100% (except
for PWM=0 which still results in a 0% duty cycle). I hardly understand
how setting this bit can result in the change you describe.

> In the mean time I'm willing to try out things
> with isaset if you can suggest basic tests (easier than upgrading kernel
> for the time being).

OK. Remember you better keep an eye on the CPU fan in case your tests
stop it. I would also suggest that you take a look at the datasheet so
that you better understand what you are doing:
http://www.iteusa.com/product_info/file/pc/IT8712F_V0.81.pdf
(page 79 of the document, which is 97 of the PDF file - don't ask)

The best test I can think of is to switch your CPU fan to manual PWM
mode. To do that, write 0x40 to register 0x15. CPU fan should go to half
speed. Write 0x7F and if should go to full speed, except if the polarity
is not correct in which case 0x00 will do (and 0x7F will stop the fan
completely so you don't want to keep it that way).

I suggest that you use the -y flag of isaset so that you can overwrite
register values quickly if things turn bad.

Once you know if the polarity is correct, you can try different values of
PWM between 0x00 and 0x7F and see how exactly your fan reacts to them.
You can also study more precisely how bit 3 of register 0x14 (the one
you played with already) affects the PWM vs speed curve.

Thanks,
--
Jean Delvare
