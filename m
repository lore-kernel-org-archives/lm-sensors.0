From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 14 Sep 2007 03:37:10 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0709132037g71121df0tdcaf752ee07a33c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 9/9/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
> On Thu, 6 Sep 2007 20:01:04 -0700, Juerg Haefliger wrote:
> > > We must rework the checks in the dme1737 printing functions to process
> > > the ignore statements properly, and to only display errors for missing
> > > features, not missing channels. I'm attaching the patch I have come up
> > > with. I can't test it as I do not have the hardware. Juergen, can you
> > > please test and report?
> > >
> > > Juerg, can you please review and test too?
> >
> > Ok I'm officially confused now. Your patch only prevents error
> > messages if ignore statements are added. Is that the intended
> > behavior?
>
> No, it's not. See how confusing the API is, it managed to fool me.
> sensors_get_label() succeeds even for missing features!
>
> Attached is an updated patch. Voltages and temperatures part is
> unchanged (honor ignore statements), fans and pwms part is much more
> simple (simply ignore errors). Please test and report.

This one behaves correctly.

Acked-by: Juerg Haefliger <juergh at gmail.com>

...juerg


> Jean Delvare
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
