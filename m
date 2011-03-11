From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 11 Mar 2011 18:32:29 +0000
Subject: Re: [lm-sensors] [PATCH 00/10] hwmon/f71882fg: Add support for new
Message-Id: <1299868349.20292.18.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299700636-9699-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1299700636-9699-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 2011-03-11 at 11:09 -0500, Hans de Goede wrote:
> Hi,
> 
> On 03/10/2011 05:00 PM, Guenter Roeck wrote:
> > On Thu, Mar 10, 2011 at 02:51:44AM -0500, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 03/09/2011 08:57 PM, Hans de Goede wrote:
> >>> Hi All,
> >>>
> >>> As already indicated in my testing request mail, I no longer have any
> >>> hardware for testing these changes. The purpose of me posting these
> >>> patches is to get a first round of review on them (although I hope no
> >>> second round will be needed). Please wait with putting these patches into
> >>> a tree for Linus until I've gotten some feedback from testers.
> >>>
> >>
> >> Ok, I've gotten some feedback from various testers and this looks good
> >> to go. So ignore my last remark, and please queue this for pulling
> >> by Linus (assuming it passes review).
> >>
> >> Note there is a small bug in the 10th patch I'll send a fixed version of
> >> that.
> >>
> > The series looks good to me, so with the test feedback I'll queue it for 2.6.39.
> >
> 
> Thanks for the review! Also thanks for the sch5627 review, I agree with all
> your comments and I'll do a new version soon.
> 
> > Do you have any Tested-by: tags ?
> 
> Oh, good one I mailed people who have been kind enough to test for me to
> ask if I could add a Tested-by tag, results:
> 
> Please add the following Tested-by tags to the
> "hwmon/f71882fg: Add support for f71889ed" commit:
> 
> Tested-by: Thomas Greve <tg42@gmx.net>
> Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
> 
> And the following tags to the
> "hwmon/f71882fg: Add support for f71869f and f71869e" commit:
> 
> Tested-by: Thomas Faber <thfabba@gmx.de>
> Tested-by: Alexey Sychev <owl@umail.ru>
> Tested-by: Dieter Bloms <dieter@bloms.de>
> 
> And the following tag to the
> "hwmon/f71882fg: Add support for f71808e" commit:
> 
> Tested-by: Jonathan Michalon <johndescs@gmail.com>

Excellent - all added.

Thanks,
Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
