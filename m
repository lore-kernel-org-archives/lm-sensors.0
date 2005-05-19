From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <3FB59DE4.55A72B0F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

never mind.
I think, on the iopener, when sensors-detect gave the IBM warning,
I was running as non-root.
It doesn't give the warning when run as root.
Sorry for the false alarm.

But anyway, would it be helpful to put out a message in sensors-detect
when it can't determine the system type, even as root?

And yes, on the 2 "typical" machines, it doesn't mention VPD.

nice job on the dmidecode package and website BTW.

Jean Delvare wrote:
> 
> > tested new sensors-detect on 4 machines.
> > 2 w/ ACPI+DMI worked fine.
> 
> Typical configuration. The output doesn't even mention VPD, right?
> 
> > One with neither (iopener) gave the standard Thinkpad warning at the
> > beginning.
> 
> Should not happen. This could happen if /dev/mem is unreadable for some
> reason. Could you download dmidecode CVS and give a try to biosdecode?
> Then edit the Makefile, remove -DUSE_MMAP, compile again and retry.
> Might crash. If it does, this means I should use mmap() to access
> /dev/mem in sensors-detect - although I don't even know how to do that.
> 
> Anything special about that iopener? You once sent me a copy of the BIOS
> area and there's nothing strange at first sight, except that it actually
> doesn't support any of ACPI, SMBIOS nor VPD.
> 
> If biosdecode works OK on it (both with and without -DUSE_MMAP), please
> try to track down why system_safeness_by_vpd in sensors-detect returns
> 0. There are three reasons it could (you'll see in the code). The third
> one is the more likely to cause problems (I think).
> 
> > On my HP ia64 machine it didn't give any ACPI or DMI info but didn't
> > give the Thinkpad warning either... what's up with that?
> 
> That's the expected behavior. This is why VPD supersedes the other
> methods. If ACPI or DMI isn't present, you can't conclude, while VPD
> being not there *does* mean that it's not an IBM system (with the
> exception of one very specific Thinkpad model).
> 
> Thanks a lot for the feedback.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
