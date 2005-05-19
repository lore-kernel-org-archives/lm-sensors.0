From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: lm_sensors - CVS and 2.5.60 (which tag?)
Message-Id: <3E5020E3.7000101@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302110036.09647.spstarr@sh0n.net>
In-Reply-To: <200302110036.09647.spstarr@sh0n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

head is fine for lm_sensors.
but you need CVS i2c as well,
and it's incompatible with 2.4 and earlier 2.5 kernels.
see our download page for some details.

Shawn Starr wrote:
> What is the correct tag for lm_sensors2? head is fine? the mkpatch perl script 
> is broken because of the changes of later 2.5 kernel builds.
> 
> Also, when I do manually add my sensor chip the i2c initializes but the kernel 
> panics on i2c_register of the w83781d (during the w83781d 's init) ;-(
> 
> I'm sure if I hack on the code I could get it to work tomorrow.
> 
> Shawn.
> 
