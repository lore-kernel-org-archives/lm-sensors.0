From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [PATCH] 2.6.4 for linux-2.4.18 on web page
Message-Id: <3D4465DA.18E2C364@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D439792.17CDB691@attbi.com>
In-Reply-To: <3D439792.17CDB691@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There are already two ways to build the package - separately from
the kernel, or using 'mkpatch' to patch the kernel.
Your patch is a third way. Whether that way reduces the support
requests, I have no idea. But worth a try.

I'll put a link on the home page and download page.


Albert Cranford wrote:
> 
> I have backported i2c&lm_sensors-2.6.4 patches for kernel
> 2.4.18 since everyone cannot be at the bleeding edge.
> 
> Maybe this will take some of the pressure off the support
> business.  Sorry it took me soo long to think of it.
> 
> Sould we comment this on the news page?
> Albert
> 
> http://personal.atl.bellsouth.net/mia/a/c/ac9410/albert/albert.html
> --
> Albert Cranford Deerfield Beach FL USA
> ac9410@bellsouth.net
