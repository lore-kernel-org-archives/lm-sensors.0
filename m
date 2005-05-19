From: alexb@tyan.com (Alex Buckingham)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: Searching for a board with a PC87366
Message-Id: <3174569B9743D511922F00A0C9431423066040D3@TYANWEB>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I restarted the system.
It was hung up on the re-boot. 
This was what was on the screen;

skipped services in run level6:
Init: no more processes left in the run level

I don't know what all that means.
I tried init 6 and it recovered correctly.
I did not have time to do a complete install. Hopefully it will not hang
again.
I only live 15 minutes away so it is no big deal to come in for a little
while on the weekend.

Alex


-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Sunday, October 24, 2004 9:33 AM
To: Alex Buckingham
Cc: Brandon Hammersley
Subject: Re: Searching for a board with a PC87366


Hi Alex,

I've found what in my code was causing the kernel oops. I cannot
understand why (will ask more knowledged 2.6 kernel developers), but
this is in an optional part of the code so I simply got rid of it and
the driver should now work. I'll test it when the test system is back
online (I am in no hurry, but maybe you are).

I'll send a preview of my code to the kernel developers, so as to know
whether they like it the way I did, or not. I'll let you know their
answer.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
