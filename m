From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 13 Aug 2006 16:37:34 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS
Message-Id: <20060813183734.9d8f367f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A87466.9020002@winbond.com>
In-Reply-To: <44A87466.9020002@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daan,

> > The easiest way to verify if the patch itself worked, is to check
> > manually in /sys/class/hwmon/hwmon0/device/. If you have the in* files,
> > it's OK, and you simply need a newer version of user-space. You can get
> > snapshots here:
> >   http://dl.lm-sensors.org/lm-sensors/snapshots/
> 
> Right, so the patch appears to work just fine... when will it be 
> submitted for inclusion in the vanilla kernel series?
> I guess more people are waiting for this support..

It's already in, 2.6.18 will be the first released kernel have it.

-- 
Jean Delvare

