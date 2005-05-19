From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Possible bug in i2c_register_entry ?
Message-Id: <20040928231914.25c45f28.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
In-Reply-To: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I stumbled upon a possible bug in i2c_register_entry() (file
> i2c-proc.c).
> 
> The function counts the number if sysctl entries by looking at
> i2c_client.procname . My sensor module needs to register sysctls that
> are not visible through proc, so their procname entry is NULL.
> 
> My question is: shouldn't i2c_register_entry() rely on
> i2c_client.ctl_name for counting the number of entries ?

As strange as it may sound if you consider the age of the code, I
believe that you are right and we should rely on ctl_name instead of
procname. It has gone unnoticed so far most probably because all
hardware monitoring device drivers export all their sysctl entries to
procfs.

I will fix that in CVS, and send a similar fix to Marcelo Tosatti for
Linux 2.4, although I'm not sure he will accept it. The fix doesn't
apply to 2.6 since we are using sysfs instead of procfs now.

BTW, for which device are you writing a driver?

Thanks for reporting.

-- 
Jean Delvare
http://khali.linux-fr.org/
