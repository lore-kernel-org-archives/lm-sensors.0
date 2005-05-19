From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Upcoming rpms: i2c headers under /usr/include/i2c
Message-Id: <20050101170600.0b719701.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041230173527.GF10397@neu.nirvana>
In-Reply-To: <20041230173527.GF10397@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> packaging up i2c and lm_sensors I had to move the i2c headers
> somehwere else than under /usr/include (and /usr/local is "forbidden"
> for packages).
> 
> Due to lack of any further creative thinking I just added another i2c
> directory hierarchy, so the rpms will offer
> 
> /usr/include/i2c/linux/i2c -> 2.9.0
> 
> and glibc-kernheaders will contain the old i2c headers under
> 
> /usr/include/linux/i2c
> 
> Building lm_sensors against that is not an issue, as the location of
> the headers can be specified. I wonder if there are other projects
> depending on the i2c headers, that would have to be diverted to the
> new location when packaged.

I have no idea whether other packages need it. If there are, these would
probably be third-party multimedia drivers.

Please note that almost all headers included in lm_sensors are not
supposed to be "exported" to /usr/include (or whatever) since they
really are headers for kernel space, not user space. I have removed all
header exports from i2c 2.9.0, and lm_sensors will probably go the same
path soon. The ony file which is really needed from userspace is
i2c-dev.h (the one which is in lm_sensors, but which should probably be
moved back to i2c at some later time).

> I also packaged the headers into i2c-kernheaders instead of
> ivtv-devel, as this seems to be the current practice at Red Hat
> (headers for conventional libs get into foo-devel, headers for kernel
> modules get into foo-kernheaders).

I assume you mean i2c-devel, not ivtv-devel?

-- 
Jean Delvare
http://khali.linux-fr.org/
