From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 15:24:54 +0000
Subject: [lm-sensors] set min/max volt for it8712...
Message-Id: <20051218162454.7e10010d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43A06B75.90608@free.fr>
In-Reply-To: <43A06B75.90608@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

> Hmmm, I suspect you're right ;-)
> Ok, I didn't read it (lm_sensors' FAQ).
> Read only man page & /etc/sensors.conf and hoped that it would be
> sufficient.
> But I'm not really wrong : now, I don't know why, but after reboot, all
> works fine :
> volts, fan, temp, DDR2, all in xsensors.

See FAQ 4.14.1:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e14

Also from sensors' manual page:
       -s     Evaluates all `set' statements in the  configuration  file.  You
              must  probably  be  `root'  to do this. If this parameter is not
              specified, no `set' statement is evaluated.

I guess that your initialization scripts include a call to "sensors
-s", which is why rebooting seemed to magically solve the problem.

-- 
Jean Delvare

