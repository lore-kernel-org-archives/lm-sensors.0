From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Date: Thu, 03 Oct 2013 16:29:54 +0000
Subject: Re: [lm-sensors] jc42: rfc - alert support
Message-Id: <AB2809AE-1B34-4767-9D23-01431F489809@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2300ADBB-ED1D-4538-9523-3E76A9E4E8C4@gmail.com>
In-Reply-To: <2300ADBB-ED1D-4538-9523-3E76A9E4E8C4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 2013-10-03, at 12:18, Guenter Roeck <linux@roeck-us.net> wrote:
> ...
> Interesting .... you "expected" this to be implemented, and you are "weary"
> as to why it isn't. Good start. Do you have a contract which would entitle you
> to have it implemented ?
> 
> There are several reasons why it isn't.
> 
> 1) When I wrote the driver, I did not need it.
> 2) I am not getting paid for work that isn't needed
> 3) No one else offered to pay for it either
> 4) The amount of time I have available for fun work is limited
> 5) No one else volunteered to do it either

These are all fine reasons. I guess it was just my personal perception that I
figured someone else should have needed this enough to do it by now. Most likely
someone already did but never bothered to send upstream.

> 
> Pretty much the same is true for every other functionality not currently
> implemented in the Linux kernel - just in case you expected it to be there
> and that you are weary that it isn't.

Been around long enough to know this.

> 
> In case you wonder, yes, I am getting a bit frustrated with people
> expecting that everything they need or want is provided to them for free.

Come one man relax a bit, I was just asking!! For your information, I will give
it a shot and send upstream after your frustrations are justified for some of
the comments you receive I'm sure and I totally understand why you would get
frustrated. But in this case my tone was nowhere near arrogant or blaming or
anything, simply interrogative and precautionary. I have several contributions
merged and not yet merged and I know how the open-source model works. Please
take a few deep breaths here, I'm your friend, not your whinny enemy.

> 
>> Is there any context or fore-notion I should know about before diving into an
>> implementation? Am I just being paranoid or is there greater forces at play
>> here?
>> 
> SMBus Alert support is notoriously tricky to implement, as pretty much every
> chip I ever dealt with implements it differently. If alert support is added
> to the driver, it will have to be on a per-chip basis; it is way too risky to
> enable it for all JC42 compliant chips and just hope that it works.
> Maybe we could risk doing that after it was tested with several chips and
> turned out to work identical on all of them, but only then and after some
> serious discussion.

Now this is information I can use! Thanks! ;-P

Anyone else?
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
