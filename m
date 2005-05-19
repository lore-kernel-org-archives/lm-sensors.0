From: akpm@osdl.org (Andrew Morton)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [PATCH] Connector and SuperIO inclusion.
Message-Id: <20040921031702.333f34bc.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040921095933.GA6274@uganda.factory.vocord.ru>
In-Reply-To: <20040921095933.GA6274@uganda.factory.vocord.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> Connector driver adds possibility to connect various agents using
>  netlink based network.

Well I'm not sure what to make of this.  Can see a few minor implementation
problems but I don't get the big picture.  (No pun intended - that drawing
doesn't help a lot either).  You'll need to describe the motivation for
this with a little more care.

You'll also need to split the patch up and document the separte parts,
please.  The `connector' thing shouldn't be in the same patch as SuperIO
device driver stuff!  Each "concept" should appear in its own patch.

When you have prepared and fully described the patches, please send them to
linux-kernel for review and comment.

Thanks.
