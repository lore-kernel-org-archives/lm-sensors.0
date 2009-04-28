From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Tue, 28 Apr 2009 13:18:45 +0000
Subject: Re: [lm-sensors] Why internal sensor on atom cpu isn't yet
Message-Id: <1240924725.1065.1.camel@maxim-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1240762029.10972.15.camel@maxim-laptop>
In-Reply-To: <1240762029.10972.15.camel@maxim-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2009-04-28 at 15:13 +0200, Jean Delvare wrote:
> On Tue, 28 Apr 2009 12:39:32 +0200, Rudolf Marek wrote:
> > Maxim Levitsky wrote:
> > > I use an old patch, and it works fine, was it forgotten?
> > 
> > Hi,
> > 
> > Well I think there are more atoms with different TjMax and I became tired to ask 
> > Intel again and again.
> 
> What's the plan then, never ever support the Atom thermal sensors?
> Seems wrong, TjMax for Core/Core2 is not that clear either, but we
> still do support these.
> 

Lets just expose raw value, and let usespace (or user do the
calculation)

Just expose the  (30 degrees below maximum or so)

Best regards,
	Maxim Levitsky


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
