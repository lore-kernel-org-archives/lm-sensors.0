From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: W83627HF SuperIO support in lm_sensors
Message-Id: <20030929214248.5c0c86bc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929180436.GB1779@pua.nirvana>
In-Reply-To: <20030929180436.GB1779@pua.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> On Mon, Sep 29, 2003 at 05:49:47PM +0200, Alfredo Milani-Comparetti
> wrote:
> > The main problem is that the W83627HF module is not included amongst
> > the loadable modules that can be MODPROBEd with your latest kernel
> > for RH9. This leads to a SENSORS-DETECT routine that suggests to
> > load W83627HF, which, in turn, is actually unavailable.
> > At present I've reverted to the original kernel from RH9 and written
> > by hand a PERL script which enables some bits in the SuperIO chip in
> > order to let it be found on the SMBus, but I think it would be nice
> > to be able to find all available modules for all known chips :-)
> 
> I used the kernel-patching method described in the lm_sensors 2.8.0
> documentation. Could you try to do the same, to reproduce whether the
> problem is in the packaging or in the upstream sources?

Known "problem" (much more of a feature actually). Our patching script
does only include the more stable drivers. Other drivers are only
available when you compile modules outside of the kernel tree. Our
sensors-detect script doesn't know about that of course, and detects
whatever it can.

If you want more drivers, either tweak the FILES and Config.in files in
mkpatch, or build the modules directly in the lm_sensors directory
instead of patching the kernel.

Hope that helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
