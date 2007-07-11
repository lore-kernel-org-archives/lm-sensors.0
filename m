From: petr@tpc.cz
Date: Wed, 11 Jul 2007 00:05:47 +0000
Subject: Re: [lm-sensors] py-smbus
Message-Id: <1184112347.46941edbf0357@webmail.monix.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1183894739.4690ccd3a0748@webmail.monix.cz>
In-Reply-To: <1183894739.4690ccd3a0748@webmail.monix.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,
> Hi Petr:
> 
> * petr@tpc.cz <petr@tpc.cz> [2007-07-08 17:05:00 +0200]:
> > thanks for quick reply, python-dev installed, I thing I am one step
> closer but I
> > am still getting some Errors. The log is attached.
> 
> Argh.  Just attach logs as plain text please.
> 
> Anyway, it also requires some header files which are installed by the
> lm-sensors package.  If you do 'make user && sudo make user_install'
> from that package, you will get them.

I was trying to install lm-sensors from the source but following occured: 
root@ubuntu:/usr/local/install/lm_sensors-2.10.3# make user
make: *** No rule to make target `sysfs/libsysfs.h', needed by `lib/sysfs.ad'. 
Stop.

> 
> Yes, py-smbus is part of that package, so it should be possible to build
> it
> without first building & installing the rest of it.  I haven't gotten
> around
> to fixing that yet, sorry.
> 
> Regards,
> 
> -- 
> Mark M. Hoffman
> mhoffman@lightlink.com
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
