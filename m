From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 01 Nov 2005 22:59:46 +0000
Subject: [lm-sensors] SiS630 sensors.conf errors
Message-Id: <20051101225911.1d1d72b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051030235843.GF26397@paradise.net.nz>
In-Reply-To: <20051030235843.GF26397@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Volker,

> > This is only an example. You are free to change, delete or add
> > statements. Also feel free to submit a patch to etc/sensors.conf.eg if
> > you think it's worth it.
> 
> I had posted my complete settings. IMHO sensors-detect should not
> require any user interaction for coming up with a correct and functional
> configuration. The average Linux (and other) desktop user doesn't know
> how to edit a configuration file anyway.

What do you propose?

There are a few thousand different motherboards out there, only
counting PC hardware. Each motherboard needs its own configuration
file. Without the hardware, we can't tell. Even with it, it's not
always easy. Only one motherboard manufacturer (Tyan) provides
configuration files for his boards. Most other manufacturers don't
even provide the technical data a user needs to write a configuration
file.

If sensors-detect isn't supposed to be interactive and users are not
supposed to edit configuration files, then we need a complete database
of configuration files for all motherboards out there. Are you going to
provide this?

Face it, hardware monitoring is not meant for the average user. It's
not a matter of how sensors-detect works, although it can certainly be
improved. The problem is that this topic is fundamentally complex, and
you can hardly simplify it without voiding the whole point of hardware
monitoring. You can only monitor something if you know what the normal
situation is, and this can only be defined on a case by case basis by
advanced users.

Things will improve greatly the day motherboard manufacturers ship
BIOSes which do setup the hardware monitoring chip properly. They have
the knowledge to do so, we don't. If they did their job, most users
could live without ever running "sensors -s". This wouldn't solve the
other issues though: labels, scaling resistors, etc.

> Thanks for the good work,

Thanks :)

-- 
Jean Delvare
