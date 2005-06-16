From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Jun 2005 11:04:12 +0000
Subject: [lm-sensors] Added sysfs support for decode-dimms.pl
Message-Id: <dp3KEJQm.1118911965.8288000.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
In-Reply-To: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Burkart,

On 2005-06-15, Burkart Lingner:
> I needed to take a closer look at my RAM's SPD-EEPROMs today. Too bad
> the sysfs of Kernel 2.6 wasn't supported by decode-dimms.pl, so I had
> to add support for that myself. Since there probably are more people
> out there who'd like to use this tool on a Kernel 2.6 system, it might
> be a good idea to include the patched file in the next release of
> lm_sensors.

Yes, definitely.

> The new version can be found at http://www.bollchen.de/decode-dimms.pl.
> Of course the "ADDED" comments should be removed then, I just left them
> in for now and I can strip them later on demand. The new version does
> work with Kernel 2.6 and it should as well work with older Kernels and
> their proc-fs. Since I only have a system running 2.6, could anyone
> with an older Kernel please do a test run? That would be greatly
> appreciated, to make sure I didn't mess anything up.

I just took a look at your script. It's not bad but I would like the
sysfs support to be added in a cleaner manner if possible. Rather than
having a if(sysfs) test on each read, we could have a single function
returning the wanted bytes, and all the checks would be in there. The
advantage is that it would avoid code duplication, would make the code
easier to read, and would allow for yet others access methods to be
added more easily in the future (e.g. reading from a dump file). Could
you try to modify your script to do that? You're probably not that far.
You may check how I did this in decode-vaio.pl, although you should be
able to do something more simple.

Other comments on the code itself:

1* Your sysfs version doesn't print the guessed bank number anymore?

2* Your sysfs version reads the whole EEPROM contents while only the
lower half is used. This will make the script twice as slow, so it
should be avoided if possible. Maybe the read method I implemented in
decode-vaio.pl may help (or use head -c, but I'm not sure it's
portable).

So it would be great if you could work on this. If you come up with a new
version, I'll test it on my systems (both 2.4 and 2.6 kernels).

Last point, when submitting changes, the best method is to provide the
output of diff -u between the original and modified file. This is way
easier than looking at "ADDED" and "MODIFIED" tags, and can be
applied to CVS directly.

Thanks,
--
Jean Delvare
