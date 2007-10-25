From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 25 Oct 2007 11:45:59 +0000
Subject: Re: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <20071025114559.GI30546@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071016100857.GA25544@kos.to>
In-Reply-To: <20071016100857.GA25544@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Lennert Buytenhek <buytenh@wantstofly.org> [2007-10-16 13:40:35 +0200]:
> On Tue, Oct 16, 2007 at 01:08:57PM +0300, Riku Voipio wrote:
> 
> > On thecus n2100, the bootloader does not setup fans to run. In order
> > to protect the user from frying their gear, start up fans on boot.
> > 
> > Depends on:
> > 
> > f75375s: Add new style bindings
> > f75375s: allow setting up fans with platform_data
> > 
> > patches sent to lm-sensors mailing list.
> > 
> > Signed-off-by: Riku Voipio <riku.voipio@movial.fi>
> 
> Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
