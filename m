From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 11 May 2012 21:39:25 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (it87) Convert to use devm_kzalloc
Message-Id: <1336772365.22553.231.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2012-05-11 at 17:10 -0400, Jean Delvare wrote:
> On Tue,  8 May 2012 19:31:53 -0700, Guenter Roeck wrote:
> > This makes the code a bit simpler and smaller.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/it87.c |   10 ++--------
> >  1 files changed, 2 insertions(+), 8 deletions(-)
> 
> You'll have to adjust this patch as it is killing label ERROR2 which is
> still in use now that patch "hwmon: (it87) Create voltage attributes
> only if voltage is enabled" was updated.
> 
Actually, since I am touching it, I'll also convert the request_region
call to devm_request_region. That will remove most of the labels. I'll
send out a revised patch in a minute.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
