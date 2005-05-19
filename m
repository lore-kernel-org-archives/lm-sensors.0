From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: APM and beep_enable
Message-Id: <20030211141617.11c154b3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0302081319390.4702-100000@linux.local>
In-Reply-To: <Pine.LNX.4.44.0302081319390.4702-100000@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > BTW, is there a way to enable or disable this beeping using sensors?
> > I just took a look at the documentation and couldn't find anything
> > related to it.
> >
> yes, i can simply do an echo of the following form:
> 
> echo "0 65536" > /proc/sys/dev/sensors/w83627hf-isa-0290/beep
> 
> and the beeping is disabled, but i must do it manually. it was my hope
> that the system execute any particular script after the return from a
> suspend (like the init-scheme during booting the machine, well resume
> is not a runlevel but...) so that i can do this in an convincing way.
> is there such a scheme?

Nice trick, I didn't know this one.

Well, I think there is a scheme, but as I seldom used APM myself (my
laptop uses ACPI instead), I can't tell you more. What I am sure of is
that it aint a lm_sensors related, but apm related, problem, so you
should have more luck reading the apm documentation or asking on the apm
mailing-list. All you need to look for is how to have arbitrary commands
issued when the systems wakes up.

Hope that helps,
Good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
