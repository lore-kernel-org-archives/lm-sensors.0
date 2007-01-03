From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 03 Jan 2007 23:05:46 +0000
Subject: [lm-sensors] w83627ehf module floods log file
Message-Id: <4dfa50520701031505w14c60e1fv97891ff428d46de9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701032236.24178@goldspace.net>
In-Reply-To: <200701032236.24178@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

There are several ways to suppress this information in /var/log/messages:

1. Turn kernel driver debugging off:
Device Drivers -> Generic Driver Options -> Driver Core verbose debug messages

Or, if you can't turn that off,
2. Reconfigure syslogd to ignore the messages. This depends on which
distro you are using. Look under /etc/syslog.conf, /etc/syslog.d/*, or
man syslog. The messages are printed at KERN_DEBUG level, and
typically syslogd ignores these messages.

Or, if you can't turn it off,
3. Reconfigure syslogd to send KERN_DEBUG messages to a separate log
file. man syslog.

Hope that helps,
David

On 1/3/07, Nameserver.ru <Info at nsr.ru> wrote:
> I have noticed the w83627ehf module (with patch to support DHG) floods
> /var/log/messages this way:
>
> ...
> Jan  3 21:54:40 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:54:43 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:54:46 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:54:49 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:28 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:31 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:34 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:37 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:40 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> ...
>
> You see, every 3 seconds the module generates new message. Is it possible to
> suppress this logging?

