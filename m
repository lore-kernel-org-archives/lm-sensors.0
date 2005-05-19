From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: Data block transactions fail on i2c-i801 controller?
Message-Id: <20040921005425.GE758@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
In-Reply-To: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops, forgot to CC the list...

----- Forwarded message from "Mark M. Hoffman" <mhoffman@lightlink.com> -----

From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: David Knierim <david_knierim@earthlink.net>
Date: Mon, 20 Sep 2004 20:22:55 -0400
Subject: Re: Data block transactions fail on i2c-i801 controller?

Hi David:

* David Knierim <david_knierim@earthlink.net> [2004-09-20 16:40:33 -0400]:
> 
> Hi,
>    I'm working with server based on Intel 7520 (Lindenhurst) chipset.   This uses the i2c-i801 bus driver.   An lm93 is attached to this bus.    If I load the lm93 in it's default mode, which "allows SMBus block data transactions if the host supports them", it takes a long time for sensors to run.   This is the output of "time":
> real    0m10.901s
> user    0m0.010s
> sys     0m0.010s
> 
> If the lm93 is loaded with it's disable_block mode, which disables data block transactions, the operation is much faster:
> real    0m1.261s
> user    0m0.010s
> sys     0m0.010s
> 
> 
> In both cases, there are no errors logged to dmesg or /var/log/messages.   The output is correct in both cases.   The data block transaction mode just takes a lot longer to complete.
> 
> 
> Any ideas??

Please uncomment line 42 "#define DEBUG" and rebuild, reinstall,
and try again.  Now you should get some log messages... please
send those here; hopefully the original authors (Phil & MDS) can
have a look as well.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
