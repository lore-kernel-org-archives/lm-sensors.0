From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <20031115051208.GC10074@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
In-Reply-To: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Benoit:

Long time no talk.  I have committed the independent ASB100 driver to
CVS, if you care to try it.  You once sent a patch to separate AS99127F
into its own driver... is the patch still current?  I finally have some
time to review things like that and I didn't want to forget that you did
some work there.

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-09-10 00:36:44 -0400]:
> * Jean Delvare <khali@linux-fr.org> [2003-09-07 17:17:29 +0200]:
> 
> > I do have an AS99127F for testing, if none of you do. However, note that
> > I'm rather busy these days (well, weeks), so it will take some time
> > before I can test anything seriously. (The more problematic thing being
> > that I have *no* Internet access at all for now. This mail was composed
> > off-line. I hope I'll have at least a 56kpbs line within a week, to
> > start with.)
> 
> Ah good, I was wondering who else has this chip for testing - I don't.
> 
> * Benoit Plessis <benoit.plessis@tuxfamily.org> [2003-09-08 21:31:33 +0200]:
> 
> > Actually as i said to mhoffman i do have an as99127f for testing and
> 
> OK.
> 
> > what i did works quite well (at least it didn't exactly like the
> > way of w83781d :p). But i do have some pb with my as99127f (beeping ..;
> 
> Common enough I guess.  Eventually we intend to remove the init code from
> the drivers (equivalent to module param. "init=0") which should solve this
> once and for all.  My independent asb100 module is written that way.
> 
> > quite strange thing). I was waiting for news from hoffman but i did
> > forget to subscribe to the list :( so i'll do this now :)
> 
> Sorry for the delay... but I'm also preparing to move again.  Not cross
> continent like my previous move, although it still takes time.
> 
> Maybe someone else with CVS access can review/commit your changes more
> quickly than I can at the moment?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
