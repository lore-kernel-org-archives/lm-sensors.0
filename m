From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Wed, 17 Aug 2005 08:28:41 +0000
Subject: [lm-sensors] Re: [PATCH] w1: add ds2433 cache (0/3)
Message-Id: <20050817062826.GB15506@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200508150937.01419.bgardner@wabtec.com>
In-Reply-To: <200508150937.01419.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 15, 2005 at 09:37:01AM -0500, Ben Gardner (bgardner@Wabtec.com) wrote:
> Hi Evgeniy,
> 
> Here's my last modifications to the ds2433 w1 driver.
> I added caching of the data if the 32-byte block contains the recommended 
> crc16 in the last two bytes of each block. 
> The driver only allows writes of full 32-byte blocks if the CRC16 in the block 
> is correct.
> I also added a family_data member to the w1_slave structure.
> 
> Also included in this series is lib/crc16.[ch], which is modeled after 
> lib/crc_ccitt.[ch]
> 
> These patches are based off the w1 patches that Greg just applied.
> 
> Signed-off-by: Ben Gardner <bgardner@wabtec.com>

I ack all 4 patches and will apply and push them upstream hopefully
today.

Thank you.

-- 
	Evgeniy Polyakov
