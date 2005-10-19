From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 19 Oct 2005 21:30:28 +0000
Subject: [lm-sensors] Tyan Thunder K8W S2885
Message-Id: <43569EAF.1080004@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4330AC00.50701@as.arizona.edu>
In-Reply-To: <4330AC00.50701@as.arizona.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> I had this problem too, turns out the problem was PNPACPI. Try adding
> "pnpacpi=off" to the kernel command line (or not compiling it and using
> PNPBIOS instead) and see if that fixes it.

Yes it should.

Btw you can find sensors.conf for TYAN motherboards on TYANs webpages:
http://www.tyan.com/support/html/software_utilities.html#lms
(and yes your MB is there)

Khali what about to put this link to our site :) ?

Ruik
