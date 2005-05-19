From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Regardding Ticket #: 1791
Message-Id: <eg5HI6Z7.1097668153.7091960.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
In-Reply-To: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 13/10/2004, Jonathan wrote:

>I talked with Intel and this is what they said when I asked how to
>access the temperatur sensors from my OS:
>
>-------------------------------------
>There is one thing only you can try to get access to the temperature
>readings: You can try using the IPMI source code package for Linux* to
>get access via a software program to the IPMI bus to access temperature
>readings. You will find a download here:
>http://support.intel.com/support/motherboards/server/ism/  Please scroll
>down a little and you will see a link to  IPMI source code package for
>Linux* This driver is listed as a courtesy for customers wanting to
>validate their own solution.
>-------------------------------------
>
>Is this source code usefull for you?

The LM Sensors project already has some support for IPMI if I remember
correctly (maybe only for Linux 2.4 though). Strange that sensors-detect
didn't find the device.

At any rate, I don't know anything about IPMI above its existence, nor
do I have the time to learn so I will not be able to help you any
further in that direction. Maybe Mark D. Studebaker will be able to
follow up, maybe not.

Just a side note: I remember you said that Intel had software for Red Hat
and it wouldn't work for you because you run Gentoo. Know that with
some work you can convert a Red Hat RPM to a different type of package,
such a simple tar.gz file. Search for tools named cpio and alien. If
your Gentoo systems does have the libs the program needs, it may work.
Never done it myself so I can't tell much more, just that you might
have given up that possibility a little too early. Note that the trick
will only work for user-space tools. Kernel modules for Red Hat kernel
won't work on any other systems that the exact one they were meant for.

Good luck.

Jean Delvare
