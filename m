From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040205210753.4eaeb8f2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Attached, you'll find some minor changes, because it's bit 2 that
> signals a fan fault, and the fan labels where assigned in the wrong
> order.

Correct. I've commited these fixes.

What about Scylla's fan fault mask? The driver masks it with 0x0f, this
means four candidate bits. On the one hand I don't see why this wouldn't
be the same bit as for Poseidon and Hermes. On the other hand, without a
data sheet I can hardly conclude. If you have information, please share.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
