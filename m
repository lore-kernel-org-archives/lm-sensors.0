From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Lm_sensors
Message-Id: <20040118184344.7a0bdf21.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Hello Axell!
> > I'm make patch to add support lm90 and asb100 sensors into fedora 
> > kernel. It's work fine for me on Gigabyte  Ga-7vaxp (lm90 cpu
> > sensor) and Asus P4pe (asb100). Patch based on standart lm_sensors
> > patch. I'm testing this patch on 2135, 2138, 2140 and 2149 kernel,
> > all ok. Patch replace your lm_sensors path. I'm think, support for
> > this modern sensors is needed for community.
> > Sorry for bad english.
> > DenV <den@nekto.com>
> > (some rpms for Fedora core http://den.tourinfo.ru/pack)
> 
> On Wed, Jan 14, 2004 at 12:06:10PM +0300, Den wrote:
> > Hello Axell!
> > PS. This patch is need 2 lines in configs:
> > CONFIG_SENSORS_ASB100=m
> > CONFIG_SENSORS_LM90=m
> > 
> > DenV <den@nekto.com>
> 
> thanks for the feedback and the testing, they are probably best to be
> shared with the lm_sensors list (Cced).
> 
> These two drivers are built by the lm_sensors project only when doing
> the kernel modules build option, as they are considered
> experimental. lm_sensors's patching method is more conservative.

This is about to change. It was decided (oh well, *I* decided and nobody
complained so far) that we would now include all drivers with both
methods. There's no reason that I can see to do it differently.

Not all drivers have been included back into the "patch the kernel tree"
method yet, but in the long term they should.

I've been adding five drivers today (lm83, lm90, asb100, max6650 and
w83l785ts). Patches to enable more of them, or all, are welcome. Else we
will probably add them on request only (unless I suddently get plenty of
free time, but it's rather improbable).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
