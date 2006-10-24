From: hanyongkui99@gmail.com (Yongkui Han)
Date: Tue, 24 Oct 2006 14:46:14 +0000
Subject: [lm-sensors] About the "CPU temp" output of ADM1025A chip
Message-Id: <2ca62ec0610240746q20e42596w9bc4ca125647f69e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
In-Reply-To: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Thank you for your reply.

On 10/23/06, Rudolf Marek <r.marek at assembler.cz> wrote:
>
> Hi  Yongkui
>
> > I calculated the time constant based on the temperature curve of "CPU
> > temp". It is about 20 seconds.
>
> Ok. Important question: Is the fan switched off - disconnected? I think we
> see
> the "slow" start because the system cools down. The board has some kind of
> automatic cooling. Of course without the fan it might be bit dangerous if
> system
> temperature grows, but I think this is necessary to test it ;) Or if you
> are
> curious and want to test it ;)


Yes, the fan is connected and running all the time.  I plan to test it
without the fan this weekend. I will let you know the new high temperature
without the fan as soon as possible.


> >
> > In my opinion, the time constant of the silicon chip is about 10
> > milliseconds.
>
> Well what constant?


The thickness of the silicon chip is about 0.5mm, the thermal resistance is
about R = 0.4 K/W, the thermal capacitance is about C=0.025 J/K, so the time
constant = R*C = 0.01 second.
The time constant of the heat sink is about several minutes.
So it is my expectation that although the temperature of the silicon chip
changes rapidly, the temperature of the heat sink changes very slowly (in
minutes). So if the thermal diode is not inside the silicon layer but near
the heat sink or heat spreader, then the temperature change will be as slow
as the temperature curve of my experiments (or even slower).

> Does this suggest that the "CPU temp" is not the temperature of the
> > thermal diode inside the Pentium 4 CPU?
>
> Also from the previous mail with graphs, I think it is but system is
> cooled
>
> > Oh, I just thought of one possible reason for this. Perhaps the current
> > or the voltage drop of thermal diode is not changing so fast as the
> > temperature change of the silicon area around it. So the temperature
> > readings from the diode will lag. If this is true, this could explain
> > why the readings from the thermal diode is not changing as rapidly as
> > the temperature of the silicon area around it.
>
> Yes but not in range of hundreds of seconds.
>
>
> > I am confused here. I still think the "CPU temp" should be the readings
> > from the thermal diode inside the Pentium 4 CPU chip. But the fact that
> > this "CPU temp" is changing slowly in seconds and it could not reach a
> > high temperature makes me doubt it.
>
> I think because of that hidden autoregulation. I would suggest to
> disconnect the
> fan connector (of course not the heatspreader ;) and try it without that.


Will the hidden autoregulation (cpu fan speed change) prevent the
temperature of the silicon chip from increasing rapidly (from tens of
milliseconds to tens of seconds)? I have doubt on that.
Anyway, I plan to try it without fan working to see what will happen.

Sorry for delay,
>
> Regards
> Rudolf
>

Thank you very much for your ideas on this!

Regards,
Yongkui
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061024/b199ac84/attachment.html 
