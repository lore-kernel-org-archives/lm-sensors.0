From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 26 Jun 2005 10:24:02 +0000
Subject: [lm-sensors] code question on pc87360 module
Message-Id: <20050626102339.5269411b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42BDF4E6.1010303@divsol.com>
In-Reply-To: <42BDF4E6.1010303@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> soekris:~# more /proc/ioports |grep pc87360
> 6620-662f : pc87360
> 6640-664f : pc87360
> 
> the last 2 lines arent there until modprobed, but I cant find
> where/how they're inserted - I grepped all i2c code for an
> ioremap, they're all in i2c/busses/, none of which appear to
> match these modules, or the objects which comprise them.
> 
> i2c_sensor              4480  1 pc87360
> i2c_isa                 2304  0
> i2c_core               23696  3 pc87360,i2c_sensor,i2c_isa
> 
> anybody got a clue for the needy ?

Search for request_region()/release_region() in pc87360.c.

-- 
Jean Delvare
