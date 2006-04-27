From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Apr 2006 08:18:29 +0000
Subject: [lm-sensors] Patch regarding the I2C_HEADERS variable in
Message-Id: <20060427101829.3c0a53a8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <92c85b0e0604240431l54394a80xf6e58be07af5d32b@mail.gmail.com>
In-Reply-To: <92c85b0e0604240431l54394a80xf6e58be07af5d32b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alon,

> I consider the following as a nuisance, but still a bug.
> I've noticed that lm_sensors's compilation always assumes that there
> is a special path for i2c headers, which is held in I2C_HEADERS
> (default is '/usr/local/include'). In my opinion, it should be
> possible to unset that variable, in case there is no such special
> path. The attached patch does exactly that.

I disagree.

You can have installed i2c in two different ways: either you patched it
into your kernel sources, or you installed it externally. In the former
case, you must set I2C_HEADERS to point to your kernel source tree. In
the latter case, you must set I2C_HEADERS to point to
/usr/local/include (the default) or wherever you installed the headers
that come from the i2c package. This should not be /usr/include, as
this directory contains the kernel headers the glibc was compiled with
and they should never be changed when installing a new kernel.

So in both cases, I2C_HEADERS points to a non-standard location and
needs to be set, or gcc won't find the header files.

-- 
Jean Delvare

