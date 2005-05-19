From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: ticket 721
Message-Id: <3BEF1061.BE5A65E3@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3BEBE198.3050607@sarvega.com>
In-Reply-To: <3BEBE198.3050607@sarvega.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

rats.
No idea what it could be then.
Could you verify what chip it actually is (look at your board).
Also send us the output (after you load i2c-piix4 but NOT w83781d)
of prog/dump/i2cdump x y, where x is probably 0 and y is probably 0x2d.
Also the output of sensors-detect.
thanks
mds






"John K. Lash" wrote:
> 
> Reply from support:
> 
> Get CVS release of lm_sensors and
> use ?modprobe w83781d init=0? which should prevent the hangs.
> Let us know if it doesn?t at
> sensors@stimpy.netroedge.com.
> MDS 11/8/01
> 
> ------------------------
> 
> Still no luck. I grabbed sensors2 and i2c as described in download.html page.
> 
> I generated a patch file:
> 
>   mkpatch/mkpatch.pl . /usr/src/linux > /tmp/pat
>   cd /usr/src/linux
>   patch -p1 < /tmp/pat
> 
> I didn't see any new settings in the make xconfig section.
> 
> Then I ran
>   make dep && make clean && make bzImage && make modules && make modules_install
> 
> Then I went back to the i2c directory and ran
>   make
>   make install
> 
> then went to sensors2
> 
>   make
>   make install
> 
> Pushed new kernel and modules to my test system, rebooted and ran
> 
>   modprobe w83781d init=0
>   modprobe i2c-piix4
> 
> and it hung. on the next boot I tried the modprobes in the reverse order and it hung after the
> second modprobe.
> 
> This kernel has mods for reiserfs and kernel crash dump in it (should have mentioned that
> originally). They haven't given me trouble in the past but I can build against a clean 2.2.19 if
> that would be helpful.
> 
> I'm including the patch file (can't think of anything else useful to do ;-)
> 
> --john
> 
> --
> John Lash       jkl@sarvega.com 630-734-5925
> 
> Sarvega Inc.
> 745 McClintock, Suite 230
> Burr Ridge, IL 60527
> 
>
