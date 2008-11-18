From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Tue, 18 Nov 2008 09:25:01 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081118092501.GG12095@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 10, 2008 at 10:38:06AM +0100, Jean Delvare wrote:
> On Sun, 09 Nov 2008 18:27:53 -0700, Jordan Crouse wrote:
> > Jean Delvare wrote:
> > > For what it's worth, Jordan Crouse seems to think that blacklisting on
> > > a per-revision basis may still work.
> > 
> > I think it can.  A much larger sample would probably need to be taken to 
> > be completely sure - but I hope that we'll find that the problem is 
> > deterministic enough for a blacklist.  I think we would agree that a 
> > blacklist would be the more user friendly solution.
> 
> OK, but then we should probably extend Rudolf's patch to ask users
> potentially affected by the errata to report to us. The report should
> include the CPUID information (e.g. contents of /proc/cpuinfo), the
> output of sensors (or the raw temperature values from sysfs), and
> whether or not the user thinks the temperature values are correct.

How do you find out whether your system is affected by this erratum?
The erratum is: due to inaccuracy of reported temperature (doesn't
meet a certain accuracy threshold) triggering of HTC/STC feature is
inaccurate.

I am just curious how you'd like to determine the accuracy of the
thermal sensor ... As an example, if the sensor reports 70 degC when
the true temperature is 65 degC -- is it worth to blacklist it?

Jordan, do you know more details about the deviation of the reported
temparature sensor values from the real ones?

I'd prefer not to blacklist but to keep the warning about potential
inaccurate temperature values as introduced by Rudolf. I use k8temp on
my private machines -- Athlon X2 and a Turion X2 (both are revF CPUs
and thus affected by erratum 141). I admit, this is more or less a
gimmick but I would miss it (if blacklisted).


Regards,

Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
