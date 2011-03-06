From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 06 Mar 2011 18:47:56 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan RPM
Message-Id: <20110306184756.GA10626@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

On Sun, Mar 06, 2011 at 12:21:48PM -0500, Ian Dobson wrote:
> 
> Hi Guenter,
> --------------------------------------------------
> From: "Guenter Roeck" <guenter.roeck@ericsson.com>
> Sent: Sunday, March 06, 2011 6:07 PM
> To: "Ian Dobson" <i.dobson@planet-ian.com>
> Cc: <lm-sensors@lm-sensors.org>
> Subject: Re: RFC: nct6776f support in the w83627ehf and fan RPM signal 
> de-bounce
> 
> > Hi Ian,
> >
> > On Sun, Mar 06, 2011 at 07:38:24AM -0500, Ian Dobson wrote:
> >> Hello All,
> >>
> >> Firstly I'd like to thank Guenter for all his work adding support for the
> >> nct6776f superIO chip.
> >>
> >> During my testing of the driver on a Asus p8p67 pro motherboard and a 
> >> Arctic
> >> cooling fan I've come across a small problem that the RPM reading is
> >> sometimes incorrect, usually the incorrect reading is almost double the
> >> expected value and is only incorrect for 2 seconds (Next actual read from
> >> the chip). Looking at the tacho signal from the fan with an oscilloscope 
> >> I
> >> can see short pulses/dropouts which cause the incorrect reading. Looking
> >> through the data sheet I see that the nct6776f and nct6775f both support
> >> de-bouncing the fan rpm signal (logical device b address 0xf0 bit 1-5 for
> >> nct6776f or 1-4 for nct6775f). After enabling the rpm de-bounce for the 
> >> CPU
> >> fan I've not seen any more miss readings. I tested for 24hours and 
> >> usually I
> >> see a incorrect reading within 10-30 minutes.
> >>
> >> The first question is, should we offer the possibility to enable rpm
> >> de-bounce for chips that support it? If yes then what interface should we
> >> use? I can see 3 possibilities:-
> >> 1) Through sysfs fanX_debounce (0/1). I already have a patch for this and
> >> the diff is about 60 lines of code
> >> 2) Through a module parameter (fan_debounce=X) where X could be 0/1 for
> >> disable/enable for all fans or a decimal value which is the bit pattern 
> >> for
> >> the de-bounce to enable.
> >> 3) Always enable the fan de-bounce if the chip supports it.
> >>
> >> Note enabling de-bounce does not appear to have any negative effects.
> >>
> > Thanks a lot for the feedback and testing.
> >
> > Since there will always be just one of those devices in a system, option 
> > 2) or 3)
> > seem to be better choices; I like to avoid adding new attributes if there 
> > is another
> > option and if the attribute would only be used by a single driver.
> >
> > We could implement 3) for simplicity, but question is if this might have 
> > any
> > undesired side effects on other boards. So 2) might be the safer approach.
> >
> > Thoughts, anyone ?
> >
> > Thanks,
> > Guenter
> 
> I already have a patch for 1 or 2, just let me know what you want.
> 
Why don't you send the patch for 2) to the list ? If it is ok, I'll
add it to the series.

> I can't imagine that enabling de-bounce should have any undesired side 
> effects on other boards. I have afew contacts that have various Asus socket 
> 1155 boards with nct6776f chips, so maybe I can get them to test my 
> de-bounce patch to see if there are any side effects.
> 
Me not either. Just playing safe.

As it is, I am really much more concerned that I am unable to get an
Acked-by: for the patch series, much less a Reviewed-by:, nor a Tested-by:
from anyone but you. That might result in the series not making it into 2.6.39,
which I think would be unfortunate.

Here are the requirements for Acked-by:

"If a person was not directly involved in the preparation or handling of a
 patch but wishes to signify and record their approval of it then they can
 arrange to have an Acked-by: line added to the patch's changelog.
 ...
 Acked-by: is not as formal as Signed-off-by:.  It is a record that the acker
 has at least reviewed the patch and has indicated acceptance.  Hence patch
 mergers will sometimes manually convert an acker's "yep, looks good to me"
 into an Acked-by:."

So, for anyone interested in seeing support for NCT6775F and NCT6776F in 2.6.39, 
consider the above. If you think the patch series and your review of it meets
above criteria, please consider sending me an Acked-by: for the series, or,
if you only reviewed individual patches, for the patches you reviewed.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
