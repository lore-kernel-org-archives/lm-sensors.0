From: christophe.dr@free.fr (christophe)
Date: Wed, 28 Feb 2007 22:59:36 +0000
Subject: [lm-sensors] support for Asus F3Jp laptop
Message-Id: <200702282359.42532.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <e47808320702280701i14a0ee20vb4745361c55d09bb@mail.gmail.com>
In-Reply-To: <e47808320702280701i14a0ee20vb4745361c55d09bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le Mercredi 28 F?vrier 2007 23:31, Vaidotas Zemlys a ?crit?:
> [...]

I had the same problem (solved in a thread some weeks ago) with an asus w1n 
laptop. The problem was that smbus was hidden.
You can check if your smbus is hidden by runing : 
lspci|grep SMBus


-- 
christophe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070228/0ca06677/attachment.bin 
