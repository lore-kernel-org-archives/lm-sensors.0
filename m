From: chris@nfluid.co.uk (Chris Smith)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Ticket 815
Message-Id: <0202151407300A.01391@oberon>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Will be interested for your confirmation that it?s the 766 not getting
> initialized. 
> My theory was the 627HF wasn?t getting initialized.

It's an assumption of mine.
The 627HF sits on the LPC bus and after you've gone through the BIOS it is 
visible at 0x0c00.

My thinking is that the BIOS maps an address space spanning 0x0c00 to the LPC 
bus through which it can change the i2c serial address to 0x2c.

Or something like that - from tests registers C0A58 and C0A5C of the AMD-766 
datasheet don't change regardless of BIOS init or not, so its not those - I'm 
going to painstakingly dump out all the Function 0 and Function 3 registers 
to see what changes through a BIOS init -  But it's so tedious!

(You haven't come across a nice way of doing this in your travels have you???)

Very busy at the moment, so I won't get at it for a while.... unless I get 
bored or something... :o)

Cheers,
Chris
-- 
Chris Smith
  Technical Architect - netFluid Technology Limited.
  "Internet Technologies, Distributed Systems and Tuxedo Consultancy"
  E: chris@nfluid.co.uk  W: http://www.nfluid.co.uk
