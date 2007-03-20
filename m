From: den_tichel@zonnet.nl (Jan van Tiggelen)
Date: Tue, 20 Mar 2007 18:19:02 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use
Message-Id: <20070320181903.A0F4F4DA8@mta-fe.casema.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Curt / David,

Would it be of any help if you get a full spec of the motherboard, including
the schematics? I have access to that.

That way you don't need to take the server apart, and you can be sure that
the chip is used exactly for what purpose you would expect.

Kind regards,

Jan van Tiggelen


-----Original Message-----
From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces at lm-sensors.org] On Behalf Of David Hubbard
Sent: Tuesday, March 20, 2007 7:06 PM
To: Curt Blank; lm-sensors at lm-sensors.org
Subject: Re: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use
w83627ehfbut it won't load

Hi Curt,

On 3/20/07, Curt Blank <curt at curtronics.com> wrote:
> Ug. Yes I can do that and I will. I was just thinking in order to take a
> decent picture I'm going to have to disconnect everything and this server
> has a lot. I'll do that tonight. And thanks for the quick reply.
>
> Just for grins yesterday I tried loading all the Winbond drivers and I got
> a number to load successfully but there were no sensors. Unless having
> multiple loaded causes a conflict. i2c_dev might not have been loaded
> though, if that makes a difference.
>
> -Curt

You may be able to find a picture of the motherboard online...

You also don't have to take a picture of the motherboard if you can
identify which is the hardware monitoring chip...

For example: you should be able to find the CPU. It will be close to
the Northbridge. There might be a southbridge / ATA controller on the
board. There will be very few other large chips. So just google all
the letters and numbers on each chip and you should be able to tell
what each does.

Post results here. :-)

David

_______________________________________________
lm-sensors mailing list
lm-sensors at lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


