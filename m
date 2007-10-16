From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 16 Oct 2007 11:09:29 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon/sis5595: Split
Message-Id: <20071016110929.GF3731@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071015204125.643d149d@hyperion.delvare>
In-Reply-To: <20071015204125.643d149d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

> On Mon, 15 Oct 2007 13:27:13 +0200, Ivo Manca wrote:
> > From: Ivo Manca <pinkel@gmail.com>
> > 
> > Use sysfs_create_group instead of individual calls to device_create_file by splitting sis5595_attributes_opt into sis5595_attributes_in4 and sis5595_attributes_temp1.
> > 
> > Signed-off-by: Ivo Manca <pinkel@gmail.com>
> > ---
> >  sis5595.c |   39 ++++++++++++++++++---------------------
> >  1 file changed, 18 insertions(+), 21 deletions(-)

* Jean Delvare <khali@linux-fr.org> [2007-10-15 20:41:25 +0200]:
> Looks good, I like it.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
