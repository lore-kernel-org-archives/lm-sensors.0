From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 04:04:14 +0000
Subject: Re: [lm-sensors] [PATCH 2/9] hwmon: Fix 'Macros with complex values' checkpatch errors
Message-Id: <20130314040414.GB15610@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363221864-15284-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1363221864-15284-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 13, 2013 at 06:03:03PM -0700, Alistair Strachan wrote:
> On 13 March 2013 17:44, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Fix:
> >
> > ERROR: Macros with complex values should be enclosed in parenthesis
> >
> > when it is seen due to complex code and not due to multi-line variable
> > declarations.
> >
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Alistair John Strachan <alistair@devzero.co.uk>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >
> 
> LGTM.
> 
> Acked-by: Alistair John Strachan <alistair@devzero.co.uk>
> 
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
