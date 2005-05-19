From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710094220.332b64d6.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 Jul 2003 09:37:55 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Did you by any chance forgot the "-r lk2-4" when checking i2c out? The
> default (HEAD) branch is deprecated and unmaintained, the one that is
> known to work is lk2-4. This would explain the errors your get.

I do:
# cvs -d :pserver:anon@cvs.lm-sensors.nu:/home/cvs login

(Log in using the password, "anonymous".)

# cvs -d :pserver:anon@cvs.lm-sensors.nu:/home/cvs checkout lm_sensors2

# cvs -d :pserver:anon@cvs.lm-sensors.nu:/home/cvs checkout -r lk2-4 i2c

Then I even do cvs update -d

Any hints?

Thanks
Zeno
