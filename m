From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jul 2007 20:28:47 +0000
Subject: Re: [lm-sensors] Getting rid of LM_DATE
Message-Id: <20070710222847.0ca1d8a5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070703140514.1ec402ae@hyperion.delvare>
In-Reply-To: <20070703140514.1ec402ae@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all, hi Phil,

On Tue, 3 Jul 2007 14:05:14 +0200, Jean Delvare wrote:
> For lm-sensors 3.0.0, I think we could get rid of LM_DATE. It's only
> used in libsensors:
> 
> lib/data.c:const char *libsensors_date = LM_DATE;
> 
> And this symbol is not even advertised, so it is quite unlikely that
> anyone is using it. Even we don't use it. I think that this string is
> redundant with LM_VERSION anyway, so it's not very useful. So I propose
> to get rid of LM_DATE and libsensors_date. Any objection?

No objection, so I proceeded with the deletion.

> LM_VERSION is also only used in libsensors:
> 
> lib/data.c:const char *libsensors_version = LM_VERSION;
> 
> It is also not advertised, still we use it in sensors:
> 
> prog/sensors/main.c:extern const char *libsensors_version;
> prog/sensors/main.c:  printf("%s version %s with libsensors version %s\n", PROGRAM, VERSION, libsensors_version);
> 
> This needs to be cleaned up (I'll do.)

Done, libsensors_version is now properly advertised and documented.

> If we get rid of LM_DATE, then I also propose to get rid of the
> "version" target in the Makefile. Changing the version string directly
> in version.h seems rather easier. Phil, would that change be OK with
> you?

And done too.

While doing these cleanups, I noticed that we have a "package" target
in our Makefile, which seems to be outdated (it still assumes CVS
instead of SVN). It appears to be redundant with the instructions in
doc/developers/release_checklist, which _are_ up-to-date. So I suppose
that Phil uses the checklist for releases and not the package target in
the Makefile, meaning that the latter could be removed. Any objection?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
