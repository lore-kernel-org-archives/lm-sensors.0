From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Mon, 26 Sep 2005 17:22:15 +0000
Subject: [lm-sensors] [PATCH] fix functionality constant for read_byte_pec
Message-Id: <200509261516.AA01321@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509240308.AA01315@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509240308.AA01315@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 25 Sep 2005 23:32:39 +0200, Jean Delvare wrote...
> Does the PEC implementation look OK to you? How does my simplification
> proposal sound to you?

Since I have never used a PEC-capable slave device,
I can understand only in respect of the maintainability of source. 
I agree with your opinion.

> Do you have a immediate need for PEC support yourself?

No.

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
