From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Nov 2010 16:24:53 +0000
Subject: Re: [lm-sensors] [RFC v2] Support of chassis intrusion detection
Message-Id: <20101102172453.27ce1c77@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310170340.4c63de39@hyperion.delvare>
In-Reply-To: <20090310170340.4c63de39@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 2 Nov 2010 08:18:16 -0700, Guenter Roeck wrote:
> On Tue, Nov 02, 2010 at 10:29:23AM -0400, Jean Delvare wrote:
> [ ... ]
> > > Reminds me. I have a set of patches for those almost ready for submission.
> > > Hope you didn't do the same work ;).
> > 
> > I just did :( I should have read my mail earlier. Well at least we'll
> > see if we agree on what needs to be done and how to do it.
> > 
> My fault. Nothing you could have done about it. I wrote the patches
> after the original e-mail exchange and then forgot about it.
> Sorry for wasting your time.
> 
> Big question remains - want to go with your or my patches ? I'd suggest yours
> unless they are not ready, since you know the code and chips better than I do.
> Otherwise I can send out mine for review later today.

OK, let's go with mine. I'll post them later today, please review them
if you have time.

Note that I am not specially familiar with the w83792d and w83793
drivers. And I don't have a test device for any of the 3 drivers
(register dumps don't work for that kind of thing.) It might be
difficult to find testers, as not all boards with these chips have the
case open pin wired, and not all cases have an intrusion detection
switch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
