From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 11 May 2012 13:38:42 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (it87) Create voltage attributes only if voltage is enabled
Message-Id: <20120511133842.GB30787@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 11, 2012 at 05:23:52AM -0400, Jean Delvare wrote:
[ ... ]
> 
> > > So my personal guess is that this bit switches VIN7 to the internal
> > > source just as with the other chips.
> > > 
> > Hmmm ... no idea what I should do. Play it safe or assume this is an error
> > in the data sheet ? I tend towards playing safe, but not too much.
> > Guess I am waiting for someone to convince me otherwise...
> 
> I would not skip VIN7 until we know more. People will never report
> about missing 5VSB monitoring, but they will report if 5VSB looks wrong.
> 
> Do we have any tester for the IT8783F yet? What you could do for now is

Bjoern Gerhart has been testing it quite extensively. I don't recall
what they do with VIN7, though.

> emit a warning / call for report when the case happens. When someone
> reports, we have our tester and we'll know what should be done.
> 
That makes sense. I'll do that.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
