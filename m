From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Ticket 1751
Message-Id: <20040814222227.670f6b26.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
In-Reply-To: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> sensors -s is also run during each reboot. To disable that, just run
> 'update-rc.d -f lm-sensors remove'

Once done, your chip should be fine after reboots. You should then try
to write to the various voltage limits (either through /etc/sensors.conf
and "sensors -s", or through the sysfs interface directly, which should
be easier). Most likely, one (or a limited number) of these is causing
the problem. Please test them all and report which are, and which are
not. Hopefully we'll see some pattern show. I know this represents some
work but I can't think of another way to find out what triggers the
problem.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
