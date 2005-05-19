From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Support for VT8231
Message-Id: <20040719202749.7df62b0c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <A15B1A44-D51B-11D8-8070-000A95BD93BE@dartmouth.edu>
In-Reply-To: <A15B1A44-D51B-11D8-8070-000A95BD93BE@dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm trying to get sensors to work on a mini-itx motherboard and have 
> run into the problem that the VT8231 chip isn't supported under the
> 2.6 kernel.
> 
> I would be very grateful if it could be put on the priority list to
> get ported for the 2.6 kernel.  Unfortunately, my coding skills aren't
> good enough to do the port myself, but I would be happy to offer my
> skills at testing.
> 
> For reference, I'm using a Epia 800 motherboard and running Gentoo 
> linux (2.6.7 kernel)

Looks like somebody (we never heard of as far as I can remember) is
somewhat working on this. You may want to take a look:
http://tser.org/vt8231/

I will not work on this myself since I know that the vt8231 had some
non-standard issues and I don't have one for testing (and I've already
ported many chip drivers, time for other people to do now ;)).

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
