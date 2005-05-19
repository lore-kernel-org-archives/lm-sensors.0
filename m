From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: [PATCH] 2.5 support for i2c-i801.c and i2c-piix4.c
Message-Id: <3E6F4226.81E62FB0@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030311234449.GA19259@kroah.com>
In-Reply-To: <20030311234449.GA19259@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg KH wrote:
> 
> Hi,
> 
> Here's a patch against the latest cvs tree that adds proper pci id
> support and probing for the i2c-i801.c and i2c-piix4.c drivers.  I've
> tested it here on different machines, and it seems to work well.  I also
> cleaned up a few preinitiaized variables and made some functions static
> that needed to be.
> 
> Feel free to commit this if you want.
> 
> On a related note, does anyone mind if I submit these drivers (along
> with the needed build files) for incluson in the 2.5 kernel tree?  Same
> thing goes for my driver model patches I sent out the other day.
> 
> As it seems that the listed kernel maintainers for i2c aren't doing
> anything anymore, the responsible person for getting kernel changes into
> the mainline seems a bit hard to find right no

One other thought. Watch the BK tree since Christoph H
is submitting his versions of i2c to Linus and there
may be conflicts.
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@attbi.com
