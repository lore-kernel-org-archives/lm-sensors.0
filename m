From: malte.starostik@t-online.de (Malte Starostik)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: [Ticket #1250]: Not your fault
Message-Id: <200308090500.h7950MN31249@zaphod.home.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've just installed a new mobo and did a fresh install of Gentoo using
2.4.20-gentoo-r6 for the kernel.
Now I've successfully emerged lm-sensors-2.7.0 and sensors works just
fine for output. However, when it comes to sensors -s, I get the same
output as the reporter of ticket #1250 (except I'm using different i2c
and sensor modules).

I'll save you the boring details and strace outputs, just so much:
the files in /proc are writable but sysctl(2) fails with EACCES.
The only bug I can see in sensors(1) is that it does an exit(0)
although it was not successful :-)

The actual problem here lies in the grsecurity patch included in
gentoo-sources, see http://bugs.gentoo.org/show_bug.cgi?id&244
if interested.

Guess you can close this ticket.

Cheers,
-Malte
