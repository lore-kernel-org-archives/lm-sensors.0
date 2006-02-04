From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Feb 2006 11:14:08 +0000
Subject: [lm-sensors] reading CPU temp from kernel module
Message-Id: <20060204121408.582fcec2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <6030766.1138809619345.JavaMail.ngmail@webmail-05.arcor-online.net>
In-Reply-To: <6030766.1138809619345.JavaMail.ngmail@webmail-05.arcor-online.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andreas,

> could anyone tell me how to read the CPU temperature within a kernel module?
> Is this possible?
> Any proposals?

Using the hardware monitoring drivers, no, it's not possible. The
drivers export temperature values, but don't know which temperature
corresponds to the CPU - as this is completely board-dependant, the
mapping is done in user-space. The returned values may also need
scaling, which is done in user-space as well.

Now, you may take you chance with ACPI. The "thermal" ACPI driver,
where available, provides a temperature which doesn't need scaling. I
see nothing which guarantees that the temperature provided correponds
to the CPU, but this seems to be true in most cases.

May I ask why you would need this information from a kernel driver?

> Machen Sie aus 14 Cent spielend bis zu 100 Euro!
> Die neue Gaming-Area von Arcor - ?ber 50 Onlinespiele im Angebot.
> http://www.arcor.de/rd/emf-gaming-1

This is a public mailing list, please don't spam it with advertisement.

Thanks,
-- 
Jean Delvare

