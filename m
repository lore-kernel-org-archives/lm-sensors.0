From: hanyongkui99@gmail.com (Yongkui Han)
Date: Mon, 30 Oct 2006 17:49:20 +0000
Subject: [lm-sensors] About the "CPU temp" output of ADM1025A chip
Message-Id: <2ca62ec0610300949j1fd2f338qa4ed2a9199f8d91f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
In-Reply-To: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I did some experiments without the CPU fan. The enclosed pdf file is for the
cpuburn benchmark.

I run the CPU burn benchmark for only 1 minute (plus 15 minutes system idle
before running cpuburn, and 15 minutes system idle after cpuburn stops
running), I even got the following message when the cpuburn program started
running for less than 1 minute:
---------------------------------------------
Message from syslogd at localhost at Mon Oct 30 11:39:21 2006 ...
localhost kernel: CPU0: Temperature above threshold

Message from syslogd at localhost at Mon Oct 30 11:39:21 2006 ...
localhost kernel: CPU0: Running in modulated clock mode

Message from syslogd at localhost at Mon Oct 30 11:39:26 2006 ...
localhost kernel: CPU0: Temperature above threshold

Message from syslogd at localhost at Mon Oct 30 11:39:26 2006 ...
localhost kernel: CPU0: Running in modulated clock mode

Message from syslogd at localhost at Mon Oct 30 11:54:30 2006 ...
localhost kernel: CPU0: Temperature above threshold

Message from syslogd at localhost at Mon Oct 30 11:54:30 2006 ...
localhost kernel: CPU0: Running in modulated clock mode
----------------------------------------------
This message means the Pentium 4 is running in modulated clock mode, I
forgot which temperature value will trigger this mechanism, perhaps it is
88C. I am not sure about this value, I will find this value in Pentium 4's
manual later and let you know.

Without the CPU fan, the CPU Temp cannot be cooled down rapidly. The CPU
Temp is staying at high temperature (>80C, CPU Temp = 84C, M/B = 64C) for
long time.

When I first turned on the computer with the CPU fan is turned off, the CPU
Temp is about 39C, the M/B Temp is 35C. They are both increasing even if
the linux operating system is idle. CPU Temp: 39C --> 40C --> 41C ......
--> 51C.  When you just run some small program such as vi, the CPU Temp will
go up: 49C --> 52C --> ...... --> 62C --> 63C.


I am wondering whether I can control the speed of the CPU fan. I would like
the CPU fan to run at a fixed speed, such as 3130 RPM or maximum RPM.

My CPU fan is Intel Fan & Heatsink A65061-001, with 3 wires, green, yellow,
and black.

Any suggestions on controlling the CPU fan speed?

Thanks!
Yongkui


On 10/25/06, Yongkui Han <hanyongkui99 at gmail.com> wrote:
>
> Hi Rudolf,
>
> Forgot to include the attachment. Please check the attachment.
>
> Thank you!
> Yongkui
>
>
>  On 10/25/06, Yongkui Han <hanyongkui99 at gmail.com> wrote:
> >
> > Hi Rudolf,
> >
> > I drew the curve of the fan speed together with the "CPU Temp" and "M/B
> > Temp" outputs from lm-sensors. The pdf file is attached for your reference.
> >
> > The fan speed is very stable before the cpuburn program starts running,
> > the speed is switching between 3150 RPM and 3323 RPM.
> >
> > After the cpubrun program starts running, the fan speed goes up: 3323
> > RPM ---> 3413 RPM ---> 3510 RPM ---> 3614 RPM ---> 3723 RPM. And after the
> > cpuburn program stops running, the fan speed goes down: 3614 RPM ---> 3510
> > RPM --->  3413 RPM.
> >
> > Although the fan speed goes up when the CPU temperature is increasing,
> > the difference of the fan speed is not so much: 3723 RPM vs. 3150 RPM. The
> > difference is only 573 RPM.  Will this difference in the fan speed prevent
> > the temperature of the silicon chip from increasing rapidly (from tens of
> > milliseconds to tens of seconds)?
> >
> > Do you have any insights about this?
> >
> > Thanks!
> > Yongkui
> >
> >
> > On 10/24/06, Yongkui Han <hanyongkui99 at gmail.com > wrote:
> > >
> > > Hi Rudolf,
> > >
> > > Thank you for your reply.
> > >
> > > On 10/23/06, Rudolf Marek <r.marek at assembler.cz > wrote:
> > > >
> > > > Hi  Yongkui
> > > >
> > > > > I calculated the time constant based on the temperature curve of
> > > > "CPU
> > > > > temp". It is about 20 seconds.
> > > >
> > > > Ok. Important question: Is the fan switched off - disconnected? I
> > > > think we see
> > > > the "slow" start because the system cools down. The board has some
> > > > kind of
> > > > automatic cooling. Of course without the fan it might be bit
> > > > dangerous if system
> > > > temperature grows, but I think this is necessary to test it ;) Or if
> > > > you are
> > > > curious and want to test it ;)
> > >
> > >
> > > Yes, the fan is connected and running all the time.  I plan to test it
> > > without the fan this weekend. I will let you know the new high temperature
> > > without the fan as soon as possible.
> > >
> > >
> > > > >
> > > > > In my opinion, the time constant of the silicon chip is about 10
> > > > > milliseconds.
> > > >
> > > > Well what constant?
> > >
> > >
> > > The thickness of the silicon chip is about 0.5mm, the thermal
> > > resistance is about R = 0.4 K/W, the thermal capacitance is about C> > > 0.025 J/K, so the time constant = R*C = 0.01 second.
> > > The time constant of the heat sink is about several minutes.
> > > So it is my expectation that although the temperature of the silicon
> > > chip changes rapidly, the temperature of the heat sink changes very slowly
> > > (in minutes). So if the thermal diode is not inside the silicon layer but
> > > near the heat sink or heat spreader, then the temperature change will be as
> > > slow as the temperature curve of my experiments (or even slower).
> > >
> > > > Does this suggest that the "CPU temp" is not the temperature of the
> > > > > thermal diode inside the Pentium 4 CPU?
> > > >
> > > > Also from the previous mail with graphs, I think it is but system is
> > > > cooled
> > > >
> > > > > Oh, I just thought of one possible reason for this. Perhaps the
> > > > current
> > > > > or the voltage drop of thermal diode is not changing so fast as
> > > > the
> > > > > temperature change of the silicon area around it. So the
> > > > temperature
> > > > > readings from the diode will lag. If this is true, this could
> > > > explain
> > > > > why the readings from the thermal diode is not changing as rapidly
> > > > as
> > > > > the temperature of the silicon area around it.
> > > >
> > > > Yes but not in range of hundreds of seconds.
> > > >
> > > >
> > > > > I am confused here. I still think the "CPU temp" should be the
> > > > readings
> > > > > from the thermal diode inside the Pentium 4 CPU chip. But the fact
> > > > that
> > > > > this "CPU temp" is changing slowly in seconds and it could not
> > > > reach a
> > > > > high temperature makes me doubt it.
> > > >
> > > > I think because of that hidden autoregulation. I would suggest to
> > > > disconnect the
> > > > fan connector (of course not the heatspreader ;) and try it without
> > > > that.
> > >
> > >
> > > Will the hidden autoregulation (cpu fan speed change) prevent the
> > > temperature of the silicon chip from increasing rapidly (from tens of
> > > milliseconds to tens of seconds)? I have doubt on that.
> > > Anyway, I plan to try it without fan working to see what will happen.
> > >
> > > Sorry for delay,
> > > >
> > > > Regards
> > > > Rudolf
> > > >
> > >
> > > Thank you very much for your ideas on this!
> > >
> > > Regards,
> > > Yongkui
> > >
> > >
> >
> >
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061030/252e1828/attachment.html 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cpuburn.nocpufan.pdf
Type: application/pdf
Size: 3772 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061030/252e1828/attachment.pdf 
