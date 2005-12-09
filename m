From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 09 Dec 2005 17:58:07 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic card
Message-Id: <4399C5AF.4080101@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Christoph Anton Mitterer wrote:
> Hi.
> 
> Modern Nvidia graphic cards support temperature monitoring of the GPU.
> It would be nice to see lm_sensors support that. Is there anything going
> on in that field?

I once did a chip driver for my motherboard with W83785R which Is found on some Nvidia cards
too.

Also you might take a look to our new drivers page that mentiones that and gives a pointer to
my driver (which was never included in mainline) and to the nvclock utillity which can read temps too.

If you need more info, just write back.

Regards

Rudolf

