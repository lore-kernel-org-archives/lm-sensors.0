From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Apr 2009 13:13:37 +0000
Subject: Re: [lm-sensors] Why internal sensor on atom cpu isn't yet
Message-Id: <20090428151337.1b780626@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1240762029.10972.15.camel@maxim-laptop>
In-Reply-To: <1240762029.10972.15.camel@maxim-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 28 Apr 2009 12:39:32 +0200, Rudolf Marek wrote:
> Maxim Levitsky wrote:
> > I use an old patch, and it works fine, was it forgotten?
> 
> Hi,
> 
> Well I think there are more atoms with different TjMax and I became tired to ask 
> Intel again and again.

What's the plan then, never ever support the Atom thermal sensors?
Seems wrong, TjMax for Core/Core2 is not that clear either, but we
still do support these.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
