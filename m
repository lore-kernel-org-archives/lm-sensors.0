From: Andre Prendel <andre_prendel@gmx.de>
Date: Fri, 06 Feb 2009 08:43:35 +0000
Subject: Re: [lm-sensors] [Patch] libsensors: Ignore directories and
Message-Id: <20090206084334.GA5913@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090205090331.GA5150@ubuntu>
In-Reply-To: <20090205090331.GA5150@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 05, 2009 at 03:32:22PM +0100, Jean Delvare wrote:
> On Thu, 5 Feb 2009 15:20:17 +0100, Andre Prendel wrote:
> > So I will take a closer look at valgrind. I have used only the
> > memcheck tool so far. After that you will get an updated patch.
> 
> The memcheck tool is very nice indeed. But in this case the tool I had
> in mind is callgrind (with kcachegrind to look at the results.)

Hey,

running sensors under callgrind with (1.) and without (2.) the patch
below, gives me the following result (callgrind_annotate).

1.)

 [...]
 42,709  ???:sensors_read_one_sysfs_chip [/usr/local/lib/libsensors.so.4.0.2]
 ...
 1,925  ???:vsscanf [/lib/tls/i686/cmov/libc-2.8.90.so]
 935  ???:sscanf [/lib/tls/i686/cmov/libc-2.8.90.so]
 [...]

2.)

 [...]
 43,272  ???:sensors_read_one_sysfs_chip [/usr/local/lib/libsensors.so.4.0.2]
 ...
 3,080  ???:vsscanf [/lib/tls/i686/cmov/libc-2.8.90.so]
 1,496  ???:sscanf [/lib/tls/i686/cmov/libc-2.8.90.so]
 [...]

I don't know what the numbers exactly mean. Could you explain please?

In real life of course you can't feel any speed
improvements. Nevertheless, IMO doing useless work (parsing directories
and symlinks) doesn't make sense.

Andre

> -- 
> Jean Delvare

---
--- lm-sensors-dev/lib/sysfs.c	2009-02-05 22:02:25.000000000 +0100
+++ my-sensors-dev/lib/sysfs.c	2009-02-05 22:21:09.000000000 +0100
@@ -357,12 +357,15 @@ static int sensors_read_dynamic_chip(sen
 		sensors_fatal_error(__func__, "Out of memory");
 
 	while ((ent = readdir(dir))) {
-		char *name = ent->d_name;
+		char *name;
 		int nr;
 
-		if (ent->d_name[0] = '.')
+		/* Skip directories and symlinks.  */
+		if (ent->d_type != DT_REG)
 			continue;
 
+		name = ent->d_name;
+
 		sftype = sensors_subfeature_get_type(name, &nr);
 		if (sftype = SENSORS_SUBFEATURE_UNKNOWN)
 			continue;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
