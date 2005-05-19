From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: bmc and fan speed control
Message-Id: <2538186705050916461ae5461e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <427FF313.7070202@mds.gotdns.com>
In-Reply-To: <427FF313.7070202@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/9/05, Mark Studebaker <mds@mds.gotdns.com> wrote:
> 2.4 bmcsensors doesn't have write support at all.
> In fact I didn't realize that 2.6 _did_ have write support.
> Nice Yani!
> That is obviously a requirement for setting anything.

Well I added it for setting max/min/hysteresis limits when porting the
driver but I couldn't actually test it (my bmc doesn't offer any write
support) .. so..err I'm surprised if it works :-). I haven't heard
about it one way or the other from anyone yet.

> I've never seen  an IPMI SDR that looked  like PWM control or fan divisor.
> IPMI systems tend to want to control their  own fan speeds, in my experience, so taking manual control
> of PWM doesn't really fit  the IPMI paradigm too well.

That's my (limited) experience too, Aj what specific bmc/motherboard
are you using? I'd be interested to take a look at any documentation.

> For example, with my IPMI system I was testing  the fan reading so I stuck a pencil in the
> CPU fan. It tried to  restart the fan 3 times in about 10 seconds  and then the system
> did an instantaneous shutdown. Nice I guess but made testing harder :)

lol... mine just blinks red leds at me which seems very useful in the
case of a meltdown with me not around. I used my finger I think though
not a pencil - ouch ;-). It tends to run the fans at very low speeds
though.

> I'm not familiar with how a general-purpose  output (like PWM) would be implemented
> in IPMI. bmcsensors is  all about sensor _inputs_ and their limits.
> 
> So I don't think PWM control via bmcsensors makes a lot of sense.

Thanks, yes if this is only supported by one or two strange bmcs then
it probably wouldn't make sense trying to add support.

Yani
