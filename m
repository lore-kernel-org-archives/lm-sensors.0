From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030612022306.AA44.MORRIS@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

khali> > Probing for `ITE IT8705F / IT8712F / SiS 950'
khali> >   Trying address 0x0290... Failed!
khali> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ I guess it's there?

Yes exactly, that says success and everything else proceeds as expected.

khali> What's more, your first
khali> proposal was to mask with 0x7f, not 0xff, which was not very logical.

No but it worked, and was the first attempt I made to get it to work.
Maybe the values being passed are wrong, or we are getting sign extension?

khali> Do we have any chance to know what this patch does? Not sure it as an
khali> interest though.

I believe it is a UTF patch, I googled for perl and UTF8 and found a few
references to this bug in other scripts, and there is reference to
Redhat using an unreleased patch.

On Thu, 12 Jun 2003 10:32:22 +0200
Jean Delvare <khali@linux-fr.org> wrote:

khali> 
khali> > With LANG=en_US.UTF8
khali> > It fails to detect the ITE IT8705F / IT8712F / SiS 950, but I don't
khali> > get the warnings anymore.
khali> > 
khali> > with LANG=en_US
khali> > it does detect the IT8705F
khali> 
khali> That's almost what I had expected. I think that your issue and the
khali> warnings were mostly unrelated. I was able to reproduce the warning on a
khali> non-UTF system, and a friend of mine, who is using a Red Hat 9 system in
khali> "UTF mode", could run this version (well, Red Hat's one but the fix is
khali> almost the same) and had his chipset detected. What's more, your first
khali> proposal was to mask with 0x7f, not 0xff, which was not very logical. So
khali> I think there is a *second* bug hiding in there. Maybe it's only
khali> relative to your particular chipset, maybe not.
khali> 
khali> Where does the output differ when the chipset is successfully found?
khali> 
khali> > (...)
khali> > Probing for `VIA Technologies VT8231 Integrated Sensors'
khali> >   Trying general detect... Failed!
khali> > Probing for `ITE IT8705F / IT8712F / SiS 950'
khali> >   Trying address 0x0290... Failed!
khali> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ I guess it's there?
khali> > Probing for `IPMI BMC KCS'
khali> >   Trying address 0x0ca0... Failed!
khali> > Probing for `IPMI BMC SMIC'
khali> >   Trying address 0x0ca8... Failed!
khali> 
khali> > This is on Redhhat 9 perl with a patch.. as shown below...
khali> 
khali> Do we have any chance to know what this patch does? Not sure it as an
khali> interest though.
khali> 
khali> OK, the next step will be to prepare a specially modified sensors-detect
khali> script with a lot of debugging info for your particular chipset. Then,
khali> I'll ask you to run it both with and without the UTF8 locale, and we'll
khali> see where the hell the bug is lurking.
khali> 
khali> The process could be drastically accelerated if you have a possibility
khali> to meet me on IRC (Khali@freenode).
khali> 
khali> -- 
khali> Jean Delvare
khali> http://www.ensicaen.ismra.fr/~delvare/
khali> 

--
Jim Morris morris@wolfman.com
