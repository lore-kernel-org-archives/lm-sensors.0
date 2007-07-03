From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Jul 2007 12:05:14 +0000
Subject: [lm-sensors] Getting rid of LM_DATE
Message-Id: <20070703140514.1ec402ae@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all, hi Phil,

For lm-sensors 3.0.0, I think we could get rid of LM_DATE. It's only
used in libsensors:

lib/data.c:const char *libsensors_date = LM_DATE;

And this symbol is not even advertised, so it is quite unlikely that
anyone is using it. Even we don't use it. I think that this string is
redundant with LM_VERSION anyway, so it's not very useful. So I propose
to get rid of LM_DATE and libsensors_date. Any objection?

LM_VERSION is also only used in libsensors:

lib/data.c:const char *libsensors_version = LM_VERSION;

It is also not advertised, still we use it in sensors:

prog/sensors/main.c:extern const char *libsensors_version;
prog/sensors/main.c:  printf("%s version %s with libsensors version %s\n", PROGRAM, VERSION, libsensors_version);

This needs to be cleaned up (I'll do.)

If we get rid of LM_DATE, then I also propose to get rid of the
"version" target in the Makefile. Changing the version string directly
in version.h seems rather easier. Phil, would that change be OK with
you?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
