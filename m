From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jul 2007 15:30:52 +0000
Subject: Re: [lm-sensors] py-smbus
Message-Id: <20070708153052.GD3584@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1183894739.4690ccd3a0748@webmail.monix.cz>
In-Reply-To: <1183894739.4690ccd3a0748@webmail.monix.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Petr:

* petr@tpc.cz <petr@tpc.cz> [2007-07-08 17:05:00 +0200]:
> thanks for quick reply, python-dev installed, I thing I am one step closer but I
> am still getting some Errors. The log is attached.

Argh.  Just attach logs as plain text please.

Anyway, it also requires some header files which are installed by the
lm-sensors package.  If you do 'make user && sudo make user_install' from that
package, you will get them.

Yes, py-smbus is part of that package, so it should be possible to build it
without first building & installing the rest of it.  I haven't gotten around
to fixing that yet, sorry.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
