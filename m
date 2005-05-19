From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <20040103110717.4a1bcd49.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 1499 - i2c-sis645 renamed to i2c-sis96x in kernel 2.6, any way we can
> handle this in sensors-detect? Khali or other perl guy?
> 
> 1503 - i2c_get_client() function in 2.4 kernels - Khali?
> 
> 1506 - asb100 detection - Mark?

I am the only one thinking that this ticket system should be canceled?
I don't think anyone but MDS reads then regularly. Half of the time we
would need more information but don't hear back from the posters,
leaving the ticket opened for months. Or the discussions ends up on the
mailing-list. I think it would be much easier for everyone that we close
the tickets system (well, leave the existing ones in place for research
purposes, but do not allow for newer tickets) and direct the users to
the mailing list. This might be the time for a more "professional" list
(I'm of course refering to the technical aspect, not the quality of
support ;)) so that Phil doesn't have to handle subscriptions by
himself.

Let's take a look at these tickets anyway.

For #1499, wouldn't listing both devices be sufficent? Well, the system
would complain about not finding one of the modules, but that left
apart, would it work or not? I can implement what you want in
sensors-detect, but I don't know much about i2c-sis*. I think I remember
MMH telling me there was some kind of trick there.

#1503 is for Ky?sti. He said that i2c_get_client was broken (locking
issue IIRC) and would need fixing. BTW, what's that function supposed
to do and how can we possibly not use it at all while a few external
drivers do? (just curious)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
