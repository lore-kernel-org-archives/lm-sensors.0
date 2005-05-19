From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <20030902020610.GA3972@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
In-Reply-To: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Benoit Plessis <benoit.plessis@tuxfamily.org> [2003-09-01 23:05:29 +0200]:
> Hello,
> 
> finally i got something working at least on my 2 Asus based mainboards.
> i moved the as99127f support out of w83781d.c to a new as99127f.c and
> added the specific part for ASB100. 

Oops, I am about 85% done with an independent driver for asb100.  But,
your effort is not in vain - separating as99127f from w83781d is good
work all by itself.  Do you have an as99127f to test on?  Or do both
of your boards have asb100?

> I also added the adjusting fan_div algorithm from mbmon in init_client
> but he still fail sometimes.
> I started the support of Mozart-2 chip but it seems to need some 
> special fixup in the smb bus and i don't have any chip of this kind so i
> can't test.
> 
> So there it is, in 3 files  
> patch-as99127f.diff.gz is to be applied to the lm_sensors2 cvs 
> patch-as99127f-i2c.diff.gz to the i2c cvs, and
> as99127f.c.gz to be extracted in the directory kernel/chips from
> lm_sensors2.

Thanks!  I'll look at these within the next couple days... I'm sorry I
really can't do it tonight.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
