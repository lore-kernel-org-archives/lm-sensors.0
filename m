From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 26 Oct 2005 00:14:15 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <435EAE3D.3@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> It looks like it works.

Cool.

I will add some more information to the archive. It seems it is ICH4 compatible because it reserves for ACPI the 16 bytes.
So HW PEC should be supported too.

Pavel could you please dump with isadump:

isadump -f 0x400 16

Thanks

Regards
Rudolf
