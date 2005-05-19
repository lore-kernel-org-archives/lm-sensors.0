From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: sis735 testing
Message-Id: <20021014192817.B28116@mercury.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1034640340.26433.18.camel@Daemon>
In-Reply-To: <1034640340.26433.18.camel@Daemon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Thomas:

* thomas <Thomas.NAGY@eleve.emn.fr> [2002-10-15 02:05:40 +0200]:
> I saw that help is needed for testing with the sis735 chipset
> (http://www2.lm-sensors.nu/~lm78/newdrivers.html)
> 
> I'd be glad to participate. Feel free to email-me at the above adress.

I've had one tester with a SiS735 already, but more wouldn't hurt.
Grab the latest i2c and lm_sensors from CVS and try them out.  I
would appreciate the following info.:  the results of "lspci -v",
both before and after you try to load the driver for the first time.
Also, any syslog messages which are produced by i2c-sis645.

Let me know if you need any help getting that far.  Don't forget
to read lm_sensors2/doc/busses/i2c-sis645 too. :)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
