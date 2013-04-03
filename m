From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Apr 2013 00:34:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) Use is_visible to determine if attributes should be creat
Message-Id: <20130403003452.GA30903@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364660359-27990-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1364660359-27990-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 02, 2013 at 12:40:45PM +0200, Simon Guinot wrote:
> On Sat, Mar 30, 2013 at 09:19:19AM -0700, Guenter Roeck wrote:
> > Simplify code and reduce object size by more than 300 bytes (x86_64).
> > 
> > Cc: Jamie Lentin <jm@lentin.co.uk>
> > Cc: Simon Guinot <sguinot@lacie.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/gpio-fan.c |  104 +++++++++++++++++-----------------------------
> >  1 file changed, 39 insertions(+), 65 deletions(-)
> 
> Hi Guenter,
> 
> It is quite a smart optimization. Just we have to take care about
> attribute ordering now.
> 
Agreed, but since this is what the 'index' argument to is_visible is for
in the first place, it should be acceptable.

> I have tested you patch on an ns2max board, with several setup
> combinations (alarm and controls). For each of them, the expected sysfs
> attributes are available and the fan is also working.
> 
> Tested-by: Simon Guinot <simon.guinot@sequanux.org>
> 
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
