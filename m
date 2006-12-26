From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 26 Dec 2006 08:59:08 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <4590E45C.7020102@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Techeng,

>   I am very interested in how do you know which motherboards are
> equipped with Winbond 793. Even for the ASUS motherboard with 627DHG I
> purchased, I had to consult our FAE.

>   Where did you get this information?

The mailing list is still CCed, I think others might have some ideas how to
issue right google queries.

1) User reports - we added support to sensors-detect and let the user report to
us that they have this chip

As soon as the chip is added to sensors-detect the more chance that user with
such chip will show up ;)

2) google.com

filetype:pdf W83793G

or

filetype:pdf W83793

This query will find 3 motherboards

Similar way for w83627dhg. This might be too restrictive

More could be found via:

W83627DHG motherboard super
W83793G motherboard

Rudolf

