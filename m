From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 09 Oct 2007 16:08:21 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <191fb4ca0710090908o75faae66u22c691d9dbe1fd70@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, Juergen,


On 10/9/07, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 08 Oct 2007 20:31:55 +0200, Juergen Bausa wrote:
> > > Aha, that explains it. Can you apply the attached patch and reload the
> > > driver? Could you also please post the output of 'lsmod'?
> >
> > not much information:
> > /var/log/messages.0:Oct  4 00:17:43 lisa kernel: dme1737 0-002e: Write to register 0x30 failed (-1)! Please report to the driver maintainer.
>
> As I expected...
>
> > i2c_nforce2             7232  0

Yes, I looked at the driver and it indeed only returns -1 on error.

> Juerg, you could patch i2c-nforce2 to return more useful error codes.
> Such a patch could go upstream. Alternatively, building the i2c-nforce2
> driver with CONFIG_I2C_DEBUG_BUS=y may provide some hints.

I was thinking of doing that. First I have to try to recreate the
problem on my machine.

Juergen: Do you feel like recompiling i2c_nforce2 with debugging enabled?

...juerg



> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
