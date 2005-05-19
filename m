From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: 1250
Message-Id: <20030626154052.1c2a5ddf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Sorry, must have hit send. Anyways.

Well, that happens to *me* also sometimes ;)

> > This would make sense. David, correct me if I'm wrong, but I believe
> > that you can actually write to the files (simply using "cat 1 2 >
> > /proc/sys/dev/sensors/via686a-isa-6000/in1" for example). So, if
> > "sensors -s" fails, this must be because of libsensors *thinking* it
> > cannot write.
> 
> Actually no. Not using cat. I get this error if do that:
> 
> bash-2.05b# cat 1 2 > /proc/sys/dev/sensors/via686a-isa-6000/in1
> cat: 1: No such file or directory
> cat: 2: No such file or directory
> 
> I can though 'echo' to it:
> bash-2.05b# echo 1 2 > /proc/sys/dev/sensors/via686a-isa-6000/in1
> Haven't done that before though so not sure why it changed it to:
> 0.99 1.99 1.07
> from the defaults in there. Doesn't matter now though. Root can write
> to the file using 'echo'

(hitting me head on the table) I of course meant echo, not cat :) Glad
you figured it out by yourself.

> > 1* Are you using i2c & lm_sensors 2.7.0 or CVS?
> 
> 2.7.0 both, not CVS.

Could you possibly give a try to CVS? It could be interesting to see if
the problem could have been already been solved as a side effect of
another fix.

> > 2* Are you using the mkpatch method or the traditional separated
> > compilation tree method?
> 
> Not sure, Probably closer to the 2nd one. I could try not using the
> ebuild below if you think it might be the problem.

I think you're right, 2nd method. I don't think it changes anything that
you use ebuild (except that you may not be able to use it for CVS).

> SRC_URI="http://www2.lm-sensors.nu/~lm78/archive/${MY_P}.tar.gz
> 	mirror://gentoo/${P}-sensors-detect-gentoo.diff.bz2"

BTW, what's this patch? I'd like to know what Gentoo changed in our
original sensors-detect script.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
