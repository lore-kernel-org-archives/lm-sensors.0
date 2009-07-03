From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 03 Jul 2009 19:09:12 +0000
Subject: Re: [lm-sensors] no PWM output with pwmconfig
Message-Id: <20090703210912.2011a9df@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4B9B3C.1040104@chello.nl>
In-Reply-To: <4A4B9B3C.1040104@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 03 Jul 2009 19:25:49 +0200, Hans de Goede wrote:
> Hi,
> 
> On 07/03/2009 04:54 PM, Jean Delvare wrote:
> > On Fri, 03 Jul 2009 16:35:57 +0200, Hans de Goede wrote:
> >> Yes, erm well the F718xx family has them in reverse order in hardware and
> >> I kept the hardware order for sysfs files. A bit strange I must admit.
> >>
> >> In hindsight it might have been better to reverse the order in sysfs
> >> for consistency with other drivers.
> >
> > I agree. It shouldn't be too difficult, and even though we can't easily
> > get a fully consistent interface for automatic speed mode due to each
> > chip being different in its own creative way, being as consistent as we
> > can makes things easier for the users.
> 
> Yes, but do we want to change this now, after the fact, that would
> basically come down to ABI breakage.

You can see it that way for sure. Or you can see it as fixing an
interface which was improperly implemented originally. While our
documentation doesn't explicitly say how trip points are ordered, the
"incremental" approach is the most natural one and the one implemented by
all other drivers too.

I don't care too much myself, so it's really up to you. You may also
want to contribute a patch to the documentation to make things clearer.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
