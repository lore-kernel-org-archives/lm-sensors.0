From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: Fix for type punning in lm_sensors2
Message-Id: <20040308043707.GB29089@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040305164220.GG28985@paradies.suse.de>
In-Reply-To: <20040305164220.GG28985@paradies.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Philipp Thomas <pth@suse.de> [2004-03-05 17:42:20 +0100]:
> 
> Current gcc versions warn when type punning is used, as this breaks the
> strict aliasing analysis gcc 3.3 does by default. When checking the causes
> for these warnings I discovered that sensors_malloc_array,
> sensors_free_array, sensors_add_array_el and sensors_add_array_els in
> lib/general.c all take a 'void **' for the list. This is plain wrong as
> the C standard only allow 'char *' and 'void *' to alias any other type, so
> if these functions should take a generic pointer, it *must* be a 'void *'
> that's internally cast to a 'void **'.

Hmmm... "gcc (GCC) 3.3.2 20031022 (Red Hat Linux 3.3.2-1)" doesn't
throw any warnings about this.  What version do you use?

> The attached patch does this and adapts all places where these functions are
> called. Note that when done correctly, no cast what-so-ever in the calling
> code is needed.

Yes that does read better.

> The patch is against current lm_sensors2 cvs version.

I've applied it - thanks!

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
