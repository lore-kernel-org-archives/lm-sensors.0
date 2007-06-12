From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Jun 2007 20:44:28 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-pre] s/SENSORS_/HWMON_/  in Kconfig,
Message-Id: <20070612224428.6fea0dba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <466E2E83.4010203@gmail.com>
In-Reply-To: <466E2E83.4010203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, Hi Jim,

On Tue, 12 Jun 2007 07:23:46 -0400, Mark M. Hoffman wrote:
> Hi Jim:
> 
> * Jim Cromie <jim.cromie@gmail.com> [2007-06-11 23:26:27 -0600]:
> > 
> > (patch attached, with this stuff at the top - hope thats ok)
> > 
> > This changes SENSORS to HWMON in Kconfig and Makefile,
> > which makes it agree with 'menuconfig HWMON' at the top of Kconfig,
> > and with the dir-name itself.  ISTM that theres no reason
> > (save legacy) to keep this arbitrary difference.
> 
> It will break 'make oldconfig', although I don't care *too* much about that.
> Does anyone else care one way or the other?

Yes, it will break 'make oldconfig', this is the reason why I never did
it. But in fact, I don't care too much either. People will simply
select their driver again, no big deal.

However, if we do that, let's do it completely and clean up the
occurrences of CONFIG_SENSORS_* that are left under drivers/i2c/chips
at the same time. Otherwise some confusion will be left. Jim, can you
please submit a new patch doing this?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
