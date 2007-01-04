From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 04 Jan 2007 20:02:30 +0000
Subject: [lm-sensors] w83627ehf module floods log file
Message-Id: <20070104210230.369646f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701032236.24178@goldspace.net>
In-Reply-To: <200701032236.24178@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 3 Jan 2007 15:05:46 -0800, David Hubbard wrote:
> Hello,
> 
> There are several ways to suppress this information in /var/log/messages:
> 
> 1. Turn kernel driver debugging off:
> Device Drivers -> Generic Driver Options -> Driver Core verbose debug messages
> 
> Or, if you can't turn that off,
> 2. Reconfigure syslogd to ignore the messages. This depends on which
> distro you are using. Look under /etc/syslog.conf, /etc/syslog.d/*, or
> man syslog. The messages are printed at KERN_DEBUG level, and
> typically syslogd ignores these messages.
> 
> Or, if you can't turn it off,
> 3. Reconfigure syslogd to send KERN_DEBUG messages to a separate log
> file. man syslog.
> 
> Hope that helps,
> David

Correct, but that being said...

> On 1/3/07, Nameserver.ru <Info at nsr.ru> wrote:
> > I have noticed the w83627ehf module (with patch to support DHG) floods
> > /var/log/messages this way:
> >
> > ...
> > Jan  3 21:54:40 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> > Jan  3 21:54:43 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> > Jan  3 21:54:46 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> > Jan  3 21:54:49 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> > Jan  3 21:59:28 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> > Jan  3 21:59:31 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> > Jan  3 21:59:34 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> > Jan  3 21:59:37 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> > Jan  3 21:59:40 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8

This really suggests that the driver fails to actually increase the fan
clock divider for fan4. This could be a bug in the drivers, worth
investigating. David, care to take a look?

-- 
Jean Delvare

