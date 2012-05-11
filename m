From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 May 2012 09:23:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (it87) Create voltage attributes only if voltage is enabled
Message-Id: <20120511112352.5c4e74e7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 May 2012 21:20:44 -0700, Guenter Roeck wrote:
> On Thu, May 10, 2012 at 04:32:33PM -0400, Jean Delvare wrote:
> > I think this is the unfortunate result of a copy / paste / edit from
> > another datasheet. If you look at the IT8716F datasheet, it said:
> > 
> > "Enables PCIRSTIN# (pin 91), and switches VIN7 function to internal
> > voltage divider for VCCH5V"
> > 
> > So my take is that the editor dropped the reference to PCIRSTIN#
> > because pin 91 can't be that on the IT8783E/F, but forgot to mention
> > the other alternative functions (which the IT8716F didn't have.) The
> > wording was pretty confusing in the first place, and the many
> > configuration options of the IT8783F only make things worse. I just
> > can't get how manufacturers can't come up with less confusing designs.
> > 
> Whoever finds the most confusing solution gets a prize.
> 
> But, seriously, it is not entirely their fault. They probably have n customers
> with n^2 conflicting requirements, and try to meet them all.

Having a few options is fine, but when it reaches that level of
complexity, I believe they should simply manufacture more chip variants
for the different use cases.

If they really don't want to do that, I'm sure it would be possible to
reach the same level of flexibility with less clutter and confusion. I
suspect they keep reusing past designs and only modify one thing each
time. Starting from scratch once in a while would help a lot.

> > So my personal guess is that this bit switches VIN7 to the internal
> > source just as with the other chips.
> > 
> Hmmm ... no idea what I should do. Play it safe or assume this is an error
> in the data sheet ? I tend towards playing safe, but not too much.
> Guess I am waiting for someone to convince me otherwise...

I would not skip VIN7 until we know more. People will never report
about missing 5VSB monitoring, but they will report if 5VSB looks wrong.

Do we have any tester for the IT8783F yet? What you could do for now is
emit a warning / call for report when the case happens. When someone
reports, we have our tester and we'll know what should be done.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
