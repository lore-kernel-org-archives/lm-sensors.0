From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: 1250
Message-Id: <20030619093408.6d41cc88.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Some times ago, Philip Pokorny sent you a patch that could possibly
> > solve your problem with lm_sensors. Did you try it? Did it work?

> No it didn't. I couldn't get the patch to work. He told me exactly
> what to do after try several times myself to patch the source, with
> errors. I got the same errors, so doesn't look like it was me. One of
> the lines it was suppose to look for wasn't there. I grepped the
> source files and I think a couple of the lines weren't there. 
> Looks like a bad patch.  
> I sent the patch to someone else and apparently they didn't have any
> success either.

I'd like you to try again. Attached is a modified version of the same
patch that should apply. I tested it some minutes ago, and it does apply
cleanly to lm_sensors-2.7.0. Go inside the directory where the
lm_sensors sources reside and apply with "patch -p1 <
/path/to/lm_sensors-2.7.0-sysctl-2.patch".

We are planing to release a new version of lm_sensors in a few days and
I'd like to know if your problem is still present or not.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
--- lm_sensors-2.7.0/lib/proc.c	Sun Nov 10 15:13:38 2002
+++ lm_sensors-2.7.0/lib/proc.c	Wed May 28 14:04:25 2003
@@ -184,6 +184,7 @@
   sysctl_name[3] = the_feature->sysctl;
   if (sysctl(sysctl_name, 4, buf, &buflen, NULL, 0))
     return -SENSORS_ERR_PROC;
+  if (sysctl_name[0] != CTL_DEV) { sysctl_name[0] = CTL_DEV ; }
   for (mag = the_feature->scaling; mag > 0; mag --)
     value *= 10.0;
   for (; mag < 0; mag ++)
