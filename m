From: a.vankaam@chello.nl (Alexander van Kaam)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Mozart2
Message-Id: <FJEPJHGHDGKMMPFFGCLOGEKJDMAA.a.vankaam@chello.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <FJEPJHGHDGKMMPFFGCLOCEJODMAA.a.vankaam@chello.nl>
In-Reply-To: <FJEPJHGHDGKMMPFFGCLOCEJODMAA.a.vankaam@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

that is pretty correct, including the $17 register for the cpu (athlon only
I think, on pentium boards these values are way off)

mozart also appears to be from Attansic, see included image.

my problem appear to be that I get no smbus dump from it, could be my SiS
driver (looking into that now)...

Regards, Alex

- Please always attach all previous mails !
----------------------------------------------------------------------
The Motherboard Monitor:
http://mbm.livewiredev.com/
----------------------------------------------------------------------
To Subscribe to the MBM update list, go to
http://mbm.livewiredev.com/join.html
----------------------------------------------------------------------
For long you live and high you fly,
And smiles you'll give and tears you'll cry,
And all you touch and all you see,
Is all your life will ever be.
----------------------------------------------------------------------

-----Original Message-----
From: Bertrik Sikken [mailto:bertrik@zonnet.nl]
Sent: Saturday,12 October, 2002 11:22
To: Alexander van Kaam
Cc: Sensors
Subject: Re: Mozart2


Hi Alex,

Alexander van Kaam wrote:

>it appears the Asus P4B533-VM has a so called "Mozart2" sensor chip,
>probably the follow up of the ASB100 (bach).
>
>just wondering if you heard anything about it, am trying to get info from
my
>asus contact but no luck so far
>
Do you have any info on the ASB100 chip that you can share?

I figured out some stuff about this chip and put it up here:
http://home.kabelfoon.nl/~bertrik/asb100/asb100.html
Apparently Asus uses the range of registers between 0x00 and 0x1F
(not really specified in the w83781d or lm78 datasheets).

Kind regards,
Bertrik

-------------- next part --------------
A non-text attachment was scrubbed...
Name: mozart.jpg
Type: image/jpeg
Size: 35534 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20021012/f5fa1f8e/mozart.jpg
