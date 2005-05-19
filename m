From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710093133.02134d7d.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 Jul 2003 09:12:55 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> CVS is known to compile great, so you must have done a mistake
> somewhere, or your system is special (or broken).
> 
> Remember you have to *install* i2c before trying to *compile*
> lm_sensors2. I would do a fresh CVS checkout and reinstall everything
> from scratch, just to make sure no file was accidentally modified in
> your local directories.
Yes I done that. First make and make install in /usr/src/modules/i2c and then in /usr/src/lm_sensors2

I removed all the directories in /usr/src/modules and then done a fresh
compile. I even done a cvs update -d before I compiled.

Did I forget anything?

Thanks for your Feedback.

Zeno
