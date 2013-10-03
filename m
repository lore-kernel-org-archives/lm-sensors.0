From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 03 Oct 2013 16:18:07 +0000
Subject: Re: [lm-sensors] jc42: rfc - alert support
Message-Id: <20131003161807.GB30315@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <2300ADBB-ED1D-4538-9523-3E76A9E4E8C4@gmail.com>
In-Reply-To: <2300ADBB-ED1D-4538-9523-3E76A9E4E8C4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 03, 2013 at 11:52:54AM -0400, Jean-Francois Dagenais wrote:
> Hi guys,
> 
> I'm considering adding support for the alert callback in the jc42.c driver. My
> current application involves SE98 chips which support window and critical
> checking with interrupt/smbalert.
> 
> I would like to use the smb alert. I see that jc42.c goes as far as programming
> the min, max and crit values in the chip, but the chip's comparator is never
> enabled nor is there an alert callback installed when the driver is registered
> with i2c core.
> 
> I would have expected this functionality to be already implemented and am weary
> as to why it's not.
> 

Interesting .... you "expected" this to be implemented, and you are "weary"
as to why it isn't. Good start. Do you have a contract which would entitle you
to have it implemented ?

There are several reasons why it isn't.

1) When I wrote the driver, I did not need it.
2) I am not getting paid for work that isn't needed
3) No one else offered to pay for it either
4) The amount of time I have available for fun work is limited
5) No one else volunteered to do it either

Pretty much the same is true for every other functionality not currently
implemented in the Linux kernel - just in case you expected it to be there
and that you are weary that it isn't.

In case you wonder, yes, I am getting a bit frustrated with people
expecting that everything they need or want is provided to them for free.

> Is there any context or fore-notion I should know about before diving into an
> implementation? Am I just being paranoid or is there greater forces at play
> here?
> 
SMBus Alert support is notoriously tricky to implement, as pretty much every
chip I ever dealt with implements it differently. If alert support is added
to the driver, it will have to be on a per-chip basis; it is way too risky to
enable it for all JC42 compliant chips and just hope that it works.
Maybe we could risk doing that after it was tested with several chips and
turned out to work identical on all of them, but only then and after some
serious discussion.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
