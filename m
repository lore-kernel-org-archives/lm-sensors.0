From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Jun 2006 20:43:26 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060601224326.c6dfdc72.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

> > BTW: the output of 'sensors -u' might be easier for you to parse.
> 
> Definitely much easier to parse than the plain "sensors" output.  But
> according to the man page, the "-u" treats all chips as unknown.  The output
> from "sensors -u", however, correctly identifies the chips and uses the
> correct sensors.conf section, so I think the man page needs an update here
> to more clearly describe what the "-u" option does.

-u means that a generic printing routine is used, instead of the chip
specific one. This is what was meant with "unknown chip". I agree the
help is maybe not very clear, patches are welcome.

In an ideal world, all chips would be printed properly by the generic
printing routine and we wouldn't even need chip specific ones. This is
where we are heading with the sysfs interface standard. But as long as
libsensors must be told about all symbols for each chip (as opposed to
dir scan/discovery) this doesn't present much interest, unfortunately.

> Is there a spec anywhere for this autoconfigurator?  Han's early link is
> still very thin on the details and the Google SOC doesn't list this sensors
> project that I can see.

Look at entry "The Fedora Project".

-- 
Jean Delvare

