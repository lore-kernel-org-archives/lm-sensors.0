From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Oct 2008 12:04:58 +0000
Subject: Re: [lm-sensors] [RFC] PATCH: f71882fg add support for the f71862fg
Message-Id: <20081021140458.2eb65ad3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FC9ED8.5020206@redhat.com>
In-Reply-To: <48FC9ED8.5020206@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 21 Oct 2008 13:27:37 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Mon, 20 Oct 2008 17:08:08 +0200, Hans de Goede wrote:
> >> -		data->in_status = f71882fg_read8(data,
> >> +		if (data->type = f71882fg)
> >> +			data->in_status = f71882fg_read8(data,
> >>  						F71882FG_REG_IN_STATUS);
> > 
> > Moving this up with the other in-related reads would save you a test.
> 
> The other in related reads are done only once a minute, this needs to be read 
> every second as we actually expect it to change.

Ah, my bad. I read only the patch and not the driver code itself. I
should have guessed there was a good reading for splitting these
apparently related reads apart.

> >>  MODULE_DESCRIPTION("F71882FG Hardware Monitoring Driver");
> >> -MODULE_AUTHOR("Hans Edgington (hans@edgington.nl)");
> >> +MODULE_AUTHOR("Hans de Goede (hdegoede@redhat.com)");
> > 
> > Adding yourself is fine. Removing the other Hans, on the other hand, is
> > a bit harsh IMHO. Remove his e-mail address if you want, but please
> > leave his name.
> 
> Ok, so that would look like this? :
> MODULE_AUTHOR("Hans Edgington, Hans de Goede (hdegoede@redhat.com)");

Yes, that would be OK.

> > Let me know how you want to proceed from here. There are only 3 days
> > left until the end of the merge window, and I don't want to delay my
> > pull request to Linus until the very last moment. So if you want this
> > patch in kernel 2.6.28, we have to be very quick.
> 
> I will start working on this right away and send you 3 patches before the end 
> of the day:
> 1) cleanups
> 2) move ioport access to probe function
> 3) add f71862fg support

Sounds very good, thanks.

> Hmm, that means there is no more time left for my fschmd watchdog patches, ah 
> well. This one actually was requested by users, which is why I bumped its prio.
> 
> That leaves us plenty of time to get the fschmd watchdog and ti tmp401 stuff in 
> shape for the next release, I promise I'l be quicker this time around and not 
> wait till the last moment (again).

As you wish.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
