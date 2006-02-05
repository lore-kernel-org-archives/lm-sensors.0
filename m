From: andreas.konrad@arcor.de (andreas.konrad@arcor.de)
Date: Sun, 05 Feb 2006 17:53:43 +0000
Subject: [lm-sensors] reading CPU temp from kernel module
Message-Id: <3444758.1139162023977.JavaMail.ngmail@webmail-09.arcor-online.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <6030766.1138809619345.JavaMail.ngmail@webmail-05.arcor-online.net>
In-Reply-To: <6030766.1138809619345.JavaMail.ngmail@webmail-05.arcor-online.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

thank you very much for your answer.
I'm sorry because of the advertisement, but it is added by my email provider.

>> could anyone tell me how to read the CPU temperature within a kernel module?
>> Is this possible?
>> Any proposals?

> Using the hardware monitoring drivers, no, it's not possible. The
> drivers export temperature values, but don't know which temperature
> corresponds to the CPU - as this is completely board-dependant, the
> mapping is done in user-space. The returned values may also need
> scaling, which is done in user-space as well.

> Now, you may take you chance with ACPI. The "thermal" ACPI driver,
> where available, provides a temperature which doesn't need scaling. I
> see nothing which guarantees that the temperature provided correponds
> to the CPU, but this seems to be true in most cases.

> May I ask why you would need this information from a kernel driver?

I want to measure the influence of temperature on the performance of the CPU. Due to this I have an external hardware which generates a very precise signal every second. This signal causes an interrupt and in the interrupt service routine (= kernel-mode / kernel module) I want to printk the timestamp counter and the temperature of the CPU. First I wanted to use a user-mode application, but this way I get a too big and variing latencies. Unfortenately I don't know how to read from the bus which can deliver the temperature information.

How can I give ACPI a try? Is there a code example?

Nice day

Andreas



Machen Sie aus 14 Cent spielend bis zu 100 Euro!
Die neue Gaming-Area von Arcor - ?ber 50 Onlinespiele im Angebot.
http://www.arcor.de/rd/emf-gaming-1

