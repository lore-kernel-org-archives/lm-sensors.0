From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <20040104210140.GF30841@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-01-04 14:08:45 -0500]:
> * Mark D. Studebaker <mds4@verizon.net> [2004-01-02 23:42:13 -0500]:
> > > 1506 - asb100 detection - Mark?
> 
> OK.  I'll look at this one today.

Here's the key error message:

>Error: First argument not a number!
>Syntax: i2cdetect I2CBUS
>  I2CBUS is an integer
>  Installed I2C busses:
>    i2c-0       smbus           SMBus Via Pro adapter at e800           Non-I2C

That error message must be from an old i2cdetect.  The one in 2.8.2
accepts 'i2cdetect -l'.  The user must somehow have a new version
of sensors-detect but an old version of i2cdetect.

I discovered this while building 2.8.2, but I confirmed anyway that 2.8.2
detects asb100 on a 2.4 kernel.

I'll close the ticket.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
