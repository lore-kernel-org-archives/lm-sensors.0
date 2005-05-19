From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030612103222.5f8b592e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> With LANG=en_US.UTF8
> It fails to detect the ITE IT8705F / IT8712F / SiS 950, but I don't
> get the warnings anymore.
> 
> with LANG=en_US
> it does detect the IT8705F

That's almost what I had expected. I think that your issue and the
warnings were mostly unrelated. I was able to reproduce the warning on a
non-UTF system, and a friend of mine, who is using a Red Hat 9 system in
"UTF mode", could run this version (well, Red Hat's one but the fix is
almost the same) and had his chipset detected. What's more, your first
proposal was to mask with 0x7f, not 0xff, which was not very logical. So
I think there is a *second* bug hiding in there. Maybe it's only
relative to your particular chipset, maybe not.

Where does the output differ when the chipset is successfully found?

> (...)
> Probing for `VIA Technologies VT8231 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ I guess it's there?
> Probing for `IPMI BMC KCS'
>   Trying address 0x0ca0... Failed!
> Probing for `IPMI BMC SMIC'
>   Trying address 0x0ca8... Failed!

> This is on Redhhat 9 perl with a patch.. as shown below...

Do we have any chance to know what this patch does? Not sure it as an
interest though.

OK, the next step will be to prepare a specially modified sensors-detect
script with a lot of debugging info for your particular chipset. Then,
I'll ask you to run it both with and without the UTF8 locale, and we'll
see where the hell the bug is lurking.

The process could be drastically accelerated if you have a possibility
to meet me on IRC (Khali@freenode).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
