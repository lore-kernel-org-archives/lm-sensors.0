From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: 2.6.5 problems
Message-Id: <3D8CF38C.405AEB57@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D8B5669.F64CE483@paradyne.com>
In-Reply-To: <3D8B5669.F64CE483@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I fixed both the ticket 1002 problems and some others involving
mkpatched kernels.
Now I know what export-objs does (Documentation/kbuild/makefiles.txt is
an excellent reference).

I put a note on the download page that i2c only worked for 2.4 kernels.
Let's see if we get a lot of complaints - if not we can remove the 2.2
compatibility
stuff from i2c and sensors in the next release? And I put a note on the
home page.

I don't think that the problems are serious enough to do a fast 2.6.6
release.
I'm going to go ahead and update freshmeat.

** Note that the MC1066 update to adm1021 requires SENSORS_INSMOD_8 from
i2c-proc.h.
In other words, unless we work around it somehow (I don't see how) - the
2.6.6 lm_sensors release
will REQUIRE i2c-2.6.6.
Let's think about this some more, it will increase our support issues a
lot.
But we've been keeping our dependency on i2c-2.6.1 for quite a while,
maybe it was time anyway.
Albert, if you can include the i2c-proc.h diff along with the i2c patch
and get
it into kernel 2.4 that would help.

mds


Mark Studebaker wrote:
> 
> dmi_scan.c doesn't compile in-kernel (ticket 1002)
> for at least one person, dmi_scan.c doesn't compile as a module, but it works for me (tkt 1002)
> i2c-elv.c doesn't compile for 2.2 kernels because of __exit (ticket 1005)
> 
> I'd like to look at these more this weekend and put fixes on the home page
> before we do the freshmeat thing.
