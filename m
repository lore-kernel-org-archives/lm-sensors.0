From: bertrik@zonnet.nl (Bertrik Sikken)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Mozart2
Message-Id: <3DA7E9BA.5020100@zonnet.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <FJEPJHGHDGKMMPFFGCLOCEJODMAA.a.vankaam@chello.nl>
In-Reply-To: <FJEPJHGHDGKMMPFFGCLOCEJODMAA.a.vankaam@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

Alexander van Kaam wrote:

>it appears the Asus P4B533-VM has a so called "Mozart2" sensor chip,
>probably the follow up of the ASB100 (bach).
>
>just wondering if you heard anything about it, am trying to get info from my
>asus contact but no luck so far
>
Do you have any info on the ASB100 chip that you can share?

I figured out some stuff about this chip and put it up here:
http://home.kabelfoon.nl/~bertrik/asb100/asb100.html
Apparently Asus uses the range of registers between 0x00 and 0x1F
(not really specified in the w83781d or lm78 datasheets).

Kind regards,
Bertrik
