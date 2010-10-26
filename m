From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 26 Oct 2010 14:01:02 +0000
Subject: Re: [lm-sensors] via-cputemp: can't compile it
Message-Id: <20101026140102.GA22667@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <osc7c6hpu7hmbgl0afmslfbh49adnlocs5@4ax.com>
In-Reply-To: <osc7c6hpu7hmbgl0afmslfbh49adnlocs5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 26, 2010 at 09:30:44AM -0400, Jean Delvare wrote:
> On Sat, 23 Oct 2010 21:20:17 -0700, singumal wrote:
> > V3.2.0 sensors-detect told me that my VIA M800 Mini-ITX has a VIA
> > Nano thermal sensor.  Checked the lm-sensors.org wiki on Devices
> > as instructed.  For the indicated via-cputemp driver, my CentOS
> > 5.5 kernel is just 2.6.18 so I'd need to make a kernel module;
> > got the Makefile and via-cputemp.c from the indicated site, but
> > can't compile it, no instructions, doing "make" in a directory
> > with those two files, I get a number of errors starting with:
> > 
> > via-cputemp.c: In function "via_cputemp_probe":
> > via-cputemp.c:106: error: called object "cpu_data" is not a function
> > 
> > I already have the matching kernel-devel and kernel-headers
> > installed in the system.
> > 
> > Please tell me what I am missing in assumptions or environment
> > setup.
> 
> Your kernel is simply too old for the via-cputemp driver as it exists
> today. You run kernel 2.6.18 and the via-cputemp was added in kernel
> 2.6.33, that's over 3 years apart.
> 
> So you will have to adjust the code yourself, or find someone who is
> willing to spend time on this task. But be aware that kernel developers
> usually don't work on old versions for free.
> 
Or just get and compile a more recent version, such as 2.6.35, on your system,
and see if it boots. That is what I usually do.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
