From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030612123059.4f15a4e1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> No but it worked, and was the first attempt I made to get it to work.
> Maybe the values being passed are wrong, or we are getting sign
> extension?

I suspect the value is wrong, and masking reverted back to the good
value. Now we have to understand where the value goes wrong, possibly
why, and find the better fix we can.

> I believe it is a UTF patch, I googled for perl and UTF8 and found a
> few references to this bug in other scripts, and there is reference to
> Redhat using an unreleased patch.

Patch 18379 is not related to UTF. BTW, there are much much more than
this only patch in Red Hat's Perl. There are at least 50, three quarters
of them being taken from Perl's CVS (so one quarter is Red Hat's own set
of patches). I really wonder why there is only one patch showing in your
output. There are 28 patches containing the "UTF" string, so it may be
hard finding which one is causing the problem. And we are not even sure
any patch is faulty.

Some questions now:

1* I'd like to make sure you and my friend are using the same version of
Perl. He is using perl(2:5.8.0-88).i386 (Red Hat 9). Which version are
you using?

2* How did you get the output you attached in your last mail?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
