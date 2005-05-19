From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: sensors shows uninteresting chips
Message-Id: <Pine.LNX.4.53.0311302004580.4386@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130145100.722ebe68.khali@linux-fr.org>
In-Reply-To: <20031130145100.722ebe68.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 30 Nov 2003, Jean Delvare wrote:
> The sensors program displays all i2c chips it'll find even the ones that
> do not have sensors interface. For example, I have a DC10+ capture
> board, and sensors will display entries for the adv7176 and the saa7110
> that live on it. This has no interest and sensors would better keep
> quiet about them IMHO.

I am very impressed with the flexibility of driver-model in 2.6,
and urge you to read lk/Documentation/driver-model/. As a long term
solution, I propose:

1. Declare class sensors

Any device that is considered to "measure" something, would register
itself as a class device. Could be i2c, isa, ipmi, usb, smart. We could
remove dependency to i2c where it is really not the actual access to
hardware, like in via686a. The class device does not directly export
data to sysfs.

2. Declare interface(s) for class sensors

One interface is to put data out via sysfs. You may invent another and
code it just once for every device of this class.

Back to your question. A device tree for class sensors would not have
those uninteresting i2c chips, and it would contain all other sensor
devices (not on any i2c bus).

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>  +358 50 462 8786
