From: benoit.plessis@univ-lemans.fr (Benoit Plessis)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <1063050239.1801.15.camel@osiris>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
In-Reply-To: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le dim 07/09/2003 ? 19:26, Jean Delvare a ?crit :
> > I have an as99127f too, and i've found a little pb with the temp,
> > on the as99127f i have the hyst and limit temp need an extra scale by
> > two so i have scaled every one (in the following patch) and you need
> > a compute line to restore the correct temp for the temp itself.
> 
> I'm not sure you're doing the right thing there. It is known that there
> are different versions of the AS99127F, with different temp conversion
> formulae. See this snippet of our default configuration file.

Actually by doing this i restored the original way of working of the
as99127f part of w83781d, in my first patch where too specific to
the ASB100.
and yes i read that files before

> > I've some weird pb with the in0, in1 in5 and in6 min and max value,
> > too but the old w83781d driver gives the same results (ie 0.00)
for in0/in1 it do solved that (it may have been a personal reply to mark
hoffman) but i still have the beep (need to unplug the buzzer) and 
the in5/in6 hyst/max are still at 0.00.

> We have had many reports about beeping issues with the AS99127F, and it
> turned out that a bad VRM setting and/or bad in0 limits were the cause.
> Make sure it's all OK for you.
Actually the sensors program said it's a CPU temp failure (but at 33.4
.).
-- 
Benoit Plessis					+33 6 77 42 78 32
<benoit.plessis@tuxfamily.org>
1024D/B4D74B76 B9A7 3697 661D 25FB A609  E69E 92CA FFAB B4D7 4B76
