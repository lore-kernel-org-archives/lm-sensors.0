From: dtor@insightbb.com (Dmitry Torokhov)
Date: Wed, 05 Jul 2006 03:13:22 +0000
Subject: [lm-sensors] [Hdaps-devel] Generic interface for accelerometers
Message-Id: <200607042313.27627.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
In-Reply-To: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shem Multinymous <multinymous@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Henrique de Moraes Holschuh <hmh@debian.org>, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>, hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tuesday 04 July 2006 06:26, Shem Multinymous wrote:
> 
> BTW, can the driver tell when nothing is accessing its input device,
> and avoid polling in that case?
> 

Yes (->open is called when there is a client opening one of the input
interfaces), but I don't think that "oh shit I dropped my laptop" events
belong to input layer.

-- 
Dmitry

