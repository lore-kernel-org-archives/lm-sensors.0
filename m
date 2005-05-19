From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <20030907171729.7e9a40cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
In-Reply-To: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(Hi Benoit, I didn't realize it was you until now! Nice to have famous
people writing to the list ;))

> > finally i got something working at least on my 2 Asus based
> > mainboards. i moved the as99127f support out of w83781d.c to a new
> > as99127f.c and added the specific part for ASB100. 
> 
> Oops, I am about 85% done with an independent driver for asb100.  But,
> your effort is not in vain - separating as99127f from w83781d is good
> work all by itself.  Do you have an as99127f to test on?  Or do both
> of your boards have asb100?

I do have an AS99127F for testing, if none of you do. However, note that
I'm rather busy these days (well, weeks), so it will take some time
before I can test anything seriously. (The more problematic thing being
that I have *no* Internet access at all for now. This mail was composed
off-line. I hope I'll have at least a 56kpbs line within a week, to
start with.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
