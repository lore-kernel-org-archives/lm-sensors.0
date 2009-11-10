From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 10 Nov 2009 20:39:44 +0000
Subject: Re: [lm-sensors] LPC47M233 support
Message-Id: <20091110203943.GA4795@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <63318d900911090621m4aa0c4eai39ca047accab0208@mail.gmail.com>
In-Reply-To: <63318d900911090621m4aa0c4eai39ca047accab0208@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 09, 2009 at 11:21:54AM -0300, Hans Goossen wrote:
> Hello,

Hello Hans,

> The CHANGES file of version 3.1.0 said:
> "Add SMSC LPC47M233 support"
> 
> But then in Revision 5757 said:
> The SMSC LPC47M233 isn't currently supported
> 
> So what is the status of this? I've just compiled the latest stable
> version (3.1.1) but can't get my sensors working. I've an IBM Netvista
> M50.

The SMSC LPC47M233 isn't supported. There is no kernel driver
supporting this chip.

The intended driver smsc47m1 doesn't support the chip, so the hardware
detection were removed from sensor-detect (in Revision 5757).

Jean, please correct me if I'm wrong.

> Any ideas ?
> 
>      greetings,
> 
>            hans

Regards,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
