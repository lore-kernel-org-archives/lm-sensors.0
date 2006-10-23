From: r.marek@assembler.cz (Rudolf Marek)
Date: Mon, 23 Oct 2006 18:35:00 +0000
Subject: [lm-sensors] About the "CPU temp" output of ADM1025A chip
Message-Id: <453D0B54.4020207@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
In-Reply-To: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi  Yongkui

> I calculated the time constant based on the temperature curve of "CPU 
> temp". It is about 20 seconds.

Ok. Important question: Is the fan switched off - disconnected? I think we see 
the "slow" start because the system cools down. The board has some kind of 
automatic cooling. Of course without the fan it might be bit dangerous if system 
temperature grows, but I think this is necessary to test it ;) Or if you are 
curious and want to test it ;)

>  
> In my opinion, the time constant of the silicon chip is about 10 
> milliseconds.

Well what constant?

> Does this suggest that the "CPU temp" is not the temperature of the 
> thermal diode inside the Pentium 4 CPU?

Also from the previous mail with graphs, I think it is but system is cooled

> Oh, I just thought of one possible reason for this. Perhaps the current 
> or the voltage drop of thermal diode is not changing so fast as the 
> temperature change of the silicon area around it. So the temperature 
> readings from the diode will lag. If this is true, this could explain 
> why the readings from the thermal diode is not changing as rapidly as 
> the temperature of the silicon area around it.

Yes but not in range of hundreds of seconds.


> I am confused here. I still think the "CPU temp" should be the readings 
> from the thermal diode inside the Pentium 4 CPU chip. But the fact that 
> this "CPU temp" is changing slowly in seconds and it could not reach a 
> high temperature makes me doubt it.

I think because of that hidden autoregulation. I would suggest to disconnect the 
fan connector (of course not the heatspreader ;) and try it without that.

Sorry for delay,

Regards
Rudolf

