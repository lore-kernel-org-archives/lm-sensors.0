From: Nate Case <ncase@xes-inc.com>
Date: Mon, 16 Jun 2008 16:50:04 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm90) Support ADT7461 in
Message-Id: <1213635004.7559.327.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1213374973-3262-3-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1213374973-3262-3-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2008-06-15 at 14:18 +0200, Jean Delvare wrote:
> Values above 63 degrees C are also broken due to the cast to s8. You
> wrote yourself above that the ADT7461 treats the values as unsigned,
> so
> this conversion function should really return a u8 not s8. The cast
> from u8 to s8 and back should happen only when you write the value to
> struct lm90_data and read it back from the structure, respectively
> (and
> I guess this will be done implicitly so you may not even have to
> care.)
> I agree that you end up writing the same value to the chip register,
> but it's convenient to also be able to use the value inside the driver
> (for debugging purposes if nothing else) so it should be correct all
> along the way.

Point taken -- "broken" sounds a bit harsh since it does actually work
at those temperatures as s8/s16 :)  The driver didn't appear to use the
values in any way that would have resulted in unexpected behavior
(though I suppose this could change and could also confuse during debug
like you mention).  I'll change those to unsigned.

Quick question before I address all of your feedback with patch v2: You
didn't mention these specifically, but I'm assuming you'd also want the
tempX_from_reg_adt7461() functions to use u8 and u16 as well?

Thanks for the feedback.

-- 
Nate Case <ncase@xes-inc.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
