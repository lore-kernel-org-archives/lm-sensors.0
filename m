From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Fri, 21 Nov 2008 15:04:36 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <68676e00811210704x27184854w6732ace08740d27f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 21, 2008 at 12:39 AM, Thierry Bothorel
<thierry.bothorel@gmail.com> wrote:
> 2008/11/20 Luca Tettamanti <kronos.it@gmail.com>:
[cut]
>> I've rewritten my old ATK driver for the third time so that it works
>> with both interfaces (and this time I _really_ intend to push it
>> upstream); currently I'm not 100% sure of the output of the new
>> interface (the user that originally contacted me is not responsive...)
>> but the code is almost complete.
>> Thierry are you willing to test this _experimental_ driver?
>
> Yes but you will have to tell me how, i'm not an "expert".

Ok, I see that you motherboard uses the old interface (and has
non-working stub of the new one - just like mine); the driver should
work fine, but testing will involve a recompilation of the kernel
(what version are you using?), are you comfortable with this?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
