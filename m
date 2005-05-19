From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Kernel connector.
Message-Id: <20040830175829.71c97ff0@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1093870749.12911.77.camel@uganda>
In-Reply-To: <1093870749.12911.77.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 30 Aug 2004 16:59:09 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> Kernel connector.
> 
> Hmm, do not know how to describe... And do not have a mega picture(may
> draw if you want).
> 
> This driver adds possibility to connect anything with anything using
> netlink based network.
> One must register callback and identificator. When driver receives
> special netlink message with appropriate identificator, appropriate
> callback will be called.
> I think that the code better explains what I'm trying to say.
> 
> cn_queue.[ch] - main queue processing routings.
> connector.[ch] - interface to the external modules.
> ucon.c - userspace daemon. It is broken a bit, but the main idea is
> very clear.
> cn_test.c - module to test new connector.
> Makefile - it will link all above cruft.

While driving home I realized, that this connector can be easily
extended to support _any_ kind of messages, not only cn_msg.
If callback supplier will provide length of the message that should be
redirected to him and some ->check() callback, then main connector after
receiving the message checks all registered callback suppliers, and if
lengths are equal pass either skb, or data, or anything else to the
supplier's->check() functions, which must decide should this packet be
redirected to callback spuuplier or not.

Obviously it can be extended to support ioctl, but I do not think it is
really needed.


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
