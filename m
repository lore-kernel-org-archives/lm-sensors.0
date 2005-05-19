From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Adding a note about via686a and i2c-viapro conflict in the FAQ
Message-Id: <20050206180536.GA7076@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050206130505.24f056cd.khali@linux-fr.org>
In-Reply-To: <20050206130505.24f056cd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 06, 2005 at 01:05:05PM +0100, Jean Delvare wrote:
> Hi Aurelien,
Hi !

> > Oops. Here is a new patch.
> 
> You will be happy to learn that the patch Greg and I had been working on
> is part of Linux 2.6.11-rc3-bk1 and later. This means that the via686a
> vs i2c-viapro conflict is now gone.
Wow, already in the main tree... That's very nice.

> If you still want to add a note about the problem in the FAQ, I'd prefer
> it to be in a chip-specific section, or in the Linux-2.6 specific
> section, since the problem and solution aren't exactly generic.
Ok, i have choosen the Linux-2.6 specific section as the chip-specific
section seems to be only for "Bad readings". Please find attached my new
patch.

Bye,
Aur?lien


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -u -d -p -r1.15 lm_sensors-FAQ.texi
--- lm_sensors-FAQ.texi	29 Dec 2004 10:21:23 -0000	1.15
+++ lm_sensors-FAQ.texi	6 Feb 2005 18:07:04 -0000
@@ -1266,6 +1266,12 @@ If you would like to port the driver, se
 Documentation/i2c/porting-clients in the 2.6 kernel tree for help,
 then send us the ported driver when you are done.
 
+@subsection i2c-viapro and via686a
+Until kernel 2.6.11-rc3-bk1, there was a PCI resource conflict between
+i2c-viapro (the SMBus driver for VIA bridges) and via686a (the integrated
+sensors driver for VIA bridges). This caused the second loaded driver to 
+silently fail working. So do not load both i2c-viapro and via686a together 
+unless you have a recent kernel.
 
 @node Help, Contribute, Problems, Top
 @chapter How to Ask for Help
