From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 10 Oct 2014 14:35:02 +0000
Subject: Re: [lm-sensors] systemd integration: Problem with modprobe in lm_sensors.service
Message-Id: <20141010163502.165917d1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201410081842.s98Igvmj004161@hobgoblin.ariadne.com>
In-Reply-To: <201410081842.s98Igvmj004161@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dale, Guenter,

On Thu, 9 Oct 2014 10:52:15 -0700, Guenter Roeck wrote:
> On Wed, Oct 08, 2014 at 02:42:57PM -0400, Dale R. Worley wrote:
> > I am running Fedora 16 with kernel 3.14.19-100.fc19.x86_64 and
> > systemd-204-21.fc19.x86_64.
> > 
> > On startup (and sometimes shutdown), I see a message like this in
> > /var/log/messages:
> > 
> >     Oct  6 13:53:37 hobgoblin modprobe[623]: modprobe: ERROR: missing parameters. See -h.
> > 
> > This message appears to be due to invocations of modprobe with these
> > arguments:
> > 
> >     /sbin/modprobe -qab
> >     /sbin/modprobe -qabr
> > 
> > Grepping all the system files (and looking in the journal), it seems
> > likely that these invocations are made by systemd, under control of
> > /usr/lib/systemd/system/lm_sensors.service:
> > 
> >     [Unit]
> >     Description=Initialize hardware monitoring sensors
> >     After=syslog.target
> > 
> >     [Service]
> >     EnvironmentFile=/etc/sysconfig/lm_sensors
> >     Type=oneshot
> >     RemainAfterExit=yes
> >     ExecStart=-/sbin/modprobe -qab $BUS_MODULES $HWMON_MODULES
> >     ExecStart=/usr/bin/sensors -s
> >     ExecStop=-/sbin/modprobe -qabr $BUS_MODULES $HWMON_MODULES
> > 
> >     [Install]
> >     WantedBy=multi-user.target
> > 
> > Which suggests that $BUS_MODULES and $HWMON_MODULES are empty in this
> > context.
> > 
> > I've found the threads "PATCH: systemd integration" and "PATCH:
> > systemd integration version 2".  But they don't deal with the fact
> > that modprobe prints an error message if the list of modules to be
> > loaded is empty.  Those error messages go into /var/log/messages, and
> > eventually logwatch sends e-mail to root complaining about them.
> > 
> > There doesn't seem to be a facility in systemd to optionally start a
> > program depending on settings in another file.  So maybe what is
> > needed are supporting scripts along these lines:
> > 
> > #! /bin/sh
> > 
> > if [ -n "$BUS_MODULES" -o -n "$HWMON_MODULES" ]
> > then
> >     /sbin/modprobe -qab $BUS_MODULES $HWMON_MODULES
> > fi
> > 
> > exec /usr/bin/sensors -s
> > 
> > and
> > 
> > #! /bin/sh
> > 
> > if [ -n "$BUS_MODULES" -o -n "$HWMON_MODULES" ]
> > then
> >     /sbin/modprobe -qabr $BUS_MODULES $HWMON_MODULES
> > fi
> > 
> 
> Not sure if there is anything we can do about that; it is a distribution
> problem, not a lm-sensors problem.
> 
> Jean, any idea ?

Jaromir Capik (Red Hat / Fedora package maintainer, Cc'd) reported the
same problem some time ago:
http://lists.lm-sensors.org/pipermail/lm-sensors/2014-January/040993.html

His proposal looks pretty much the same as what Dale just suggested:
wrapper shell scripts.

My reply is here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2014-July/042145.html

As a summary, I agree that there is a problem, but I am not a big fan
of using wrapper shell scripts to solve it, for it defeats the purpose
of systemd. Unfortunately I have to admit that I did not take the time
to actually implement my idea in openSUSE, so I still don't know for
sure if it would work OK.

What really surprises me though is that Dale seems to see the problem
on Fedora, while I thought Jaromir had already committed his fix there,
regardless of upstream acceptance. This is really a system integration
issue so distributions are perfectly free to diverge. The example
systemd service files are really only templates to build upon, they can
be modified to accommodate distribution specifics as needed.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
