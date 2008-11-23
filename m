From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Sun, 23 Nov 2008 23:41:27 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <68676e00811231541q1129e347tbfe122ea0e7c7963@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(top posting is bad)

On Sun, Nov 23, 2008 at 8:25 PM, Thierry Bothorel
<thierry.bothorel@gmail.com> wrote:
> 2008/11/21 Luca Tettamanti <kronos.it@gmail.com>:
>> On Fri, Nov 21, 2008 at 12:39 AM, Thierry Bothorel
>> <thierry.bothorel@gmail.com> wrote:
>>> 2008/11/20 Luca Tettamanti <kronos.it@gmail.com>:
>> Ok, I see that you motherboard uses the old interface (and has
>> non-working stub of the new one - just like mine); the driver should
>> work fine, but testing will involve a recompilation of the kernel
>> (what version are you using?), are you comfortable with this?
>
> To be honest, no :-). Can I do that from a live-cd  or from a
> virtualized machine and just copy and install the final deb file on my
> real system and install it ?

Hum, not really. If you're on Debian the recompilation is mostly automatic:
http://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-common-building
YMMV with other distros.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
