From: Etienne Buira <etienne.buira.lists@free.fr>
Date: Thu, 30 Jun 2011 20:42:30 +0000
Subject: Re: [lm-sensors] Using Asus P5Q-E sensors/pwm
Message-Id: <20110630204230.GA16936@epicure.lazyet.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110628194643.GM21173@epicure.lazyet.homelinux.net>
In-Reply-To: <20110628194643.GM21173@epicure.lazyet.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

(sorry Luca about the CC, didn't notice it as I'm more used to lists
where replies goes directly to the list).

On Thu, Jun 30, 2011 at 01:47:15PM +0200, Jean Delvare wrote:
> On Thu, 30 Jun 2011 13:34:48 +0200, Luca Tettamanti wrote:
> > On Thu, Jun 30, 2011 at 12:19 PM, Etienne Buira
> > > Yeah, I know about q-fan, but it doesn't gives enough air in some
> > > situations, even in turbo mode
> 
> Is it OK if you disable smart fan control altogether? If even the
> fastest smart fan setting doesn't work for you, then maybe your cooling
> solution is simply not adequate.

q-fan turbo is most of the time enough, it is just not smart enough to
figure out my weird cooling installation when the weather is getting
warmy (though, nothing seems to be really boiling, but some temps might
reduce parts lifetimes). And it obviously cannot figure out when I don't
care about noise, and when I do.

> > > (...)
> > > If none, do you know if an acpi compatible solution is on cooking time?
> > > Or would it be possible/not too hard to implement? (I might volunteer to
> > > write some code, if I'm directed in some way to relevant docs)
> > 
> > The interface does not seem complicated, but I feel I'm still missing
> > something... e.g on my old P5B-E Q-FAN setting were applied only after
> > a reboot, on a newer M4A79XTD nothing happens, while my M5A78L seems
> > to work correctly...
> 
> Would you mind sharing your code? I would love to give it a try and
> report how it goes on my P5QL Pro.

I plussify, and would like to test if not as risky as lax acpi.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
