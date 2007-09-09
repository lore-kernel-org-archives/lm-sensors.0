From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 09 Sep 2007 15:38:58 +0000
Subject: Re: [lm-sensors] [PATCH] update w83791d driver with new sysfs
Message-Id: <20070909153858.GF31992@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
In-Reply-To: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-09-06 11:30:47 +0200]:
> Hi Charles,
> 
> On Tue, 4 Sep 2007 13:31:56 -0700, Charles Spirakis wrote:
> > Significant documentation changes. Hopefully it reads better now and I
> > believe I've cleaned up the global beep enable vs. beep bitmask vs.
> > alarm bitmap aspect.
> > 
> > Also cleaned up the store_beep() per your earlier comment in this thread.
> > 
> > -- charles
> > 
> > ---
> > Add new sysfs alarm methodology to w83791d driver
> > 
> > Signed-off-by: Charles Spirakis <bezaur@gmail.com>
> 
> Looks good to me, thanks!
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
