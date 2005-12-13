From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 13 Dec 2005 02:20:03 +0000
Subject: [lm-sensors] [PLUG] lm_sensors and fan speed
Message-Id: <20051213022003.GB7423@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051209165101.GA23690@jupiter.solarsys.private>
In-Reply-To: <20051209165101.GA23690@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Art:

> Mark M. Hoffman wrote:
> >Please don't strip the lm-sensors list from the CC's.

* Art Alexion <art.alexion at verizon.net> [2005-12-10 20:36:04 -0500]:
> Sorry, I am used to just hitting reply :-[

No worries.

> >OK, that's quite old as far as the relevant driver is concerned.  There are at
> >least two patches since 2.6.12 that I think might solve it.  But you won't need
> >to rebuild a kernel to find out.  Just add this line to /etc/modules.conf:
> >
> >	options w83627hf init=0
> >
> >Unfortunately, it will take a reboot for this to take effect.  (The driver
> >already overwrote whatever BIOS inits were performed, the only way to get
> >them back is to "run" the BIOS.)
> >
> >I suggest the init=0 module option because it will make your (older) version
> >of the driver behave more like the default of the latest version - especially
> >with respect to the two patches that I think might solve it.
> >  
> >
> OK. Done

... did it seem to help?

> >Other questions: does 'sensors -s' appear anywhere in your init scripts?
> >  
> >
> yeah.  /etc/init.d/lm-sensors reads
> 

OK, good.

> >Are you happy with the output of 'sensors', or do you want to dive into
> >its config a bit to get better info?  If you're only interested in CPU
> >temperature via some KDE program, then what you have is good enough.
> >  
> >
> The only other thing that I know I am interested in is displaying more
> S.M.A.R.T. monitor info, which I think is a ksensors issue rather than
> an lm_sensors issue.  That said, what other sorts of information is
> available?

Well, the sensors output showed some fans with 0 rpms.  If you do have fans
there that are capable of speed sensing, then read here:

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/fan-divisors

You may also change the labels on the sensors output, so that e.g. 'temp1'
becomes 'CPU Temp'.  All of that and more is controlled by /etc/sensors.conf.
Or, as I said, if you're happy with the display from ksensors, that's fine
too.

As for SMART readings, have you tried smartmontools?

Here are the slides from my March PLUG talk (lm-sensors & smartmontools):

http://members.dca.net/mhoffman/presentations/20050302-plug

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


