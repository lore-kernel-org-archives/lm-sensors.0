From: dcb@pa.net (Douglas Bollinger)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: From Ticket 1972, Gigabyte 7dpxdw+, making it work correctly
Message-Id: <20050508131957.2aee38b4.dcb@pa.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050504174827.11115a83.dcb@pa.net>
In-Reply-To: <20050504174827.11115a83.dcb@pa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Sun, 8 May 2005 14:01:54 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> First, I invite you to read the following thread:
> http://archives.andrew.net.au/lm-sensors/msg28081.html

Thanks, that thread explains alot.  So the trick was to use 2 LM90s.
Gigabyte making easy things hard.

<snip>
> Alex van Kaam, who wrote MBM, has been working with us on this actually,
> he is the one who found how the board was wired and told us how we could
> handle the multiplexing. We did not properly implement support for it
> out of time and motivation, but Alex has been really helpful.

At least now I understand it just won't work and the ticket database is
updated to that fact as well.  From some of the previous entries, it almost
seemed like CPU temps were working for this board, but I think those users
were fooled by the bogus W83627HF temp readings.  Actually, those temp
readings probably are from the CPU sockets, but obviously those readings
aren't nearly as desirable as getting a temp directly from the CPU itself
via the LM90s.

Thanks for taking the time to look into this.

-- 
Don't you wish that all the people who sincerely want to help you
could agree with each other?
