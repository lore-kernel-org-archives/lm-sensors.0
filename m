From: "Frank Phillips" <frankalso@gmail.com>
Date: Wed, 29 Aug 2007 12:45:55 +0000
Subject: Re: [lm-sensors] [PATCH] v1 of IBM power meter driver
Message-Id: <78171f0a0708290545w7a819177keb959079d0116fb1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com>
	 <20070828015029.GA10107@khazad-dum.debian.net>
	 <20070828131942.18449886@hyperion.delvare>
	 <20070828162851.GJ32667@tree.beaverton.ibm.com>
	 <20070829114959.5ddb8d79@hyperion.delvare>
In-Reply-To: <20070829114959.5ddb8d79@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Yani Ioannou <yani.ioannou@gmail.com>

> It needs at least review and testing, but maybe there are a few more
> steps before merging can be considered. Adding Yani (the author) to Cc,
> please work with him if you're interested.

As a user, I can tell you that it completely fills my dmesg with this sort

ipmisensors: sensor 50 (type 1) reading 60
ipmisensors: Send 0x2d 0x30 0x0
ipmisensors: received message
ipmisensors: sensor 48 (type 1) reading 28
ipmisensors: Send 0x2d 0x1b 0x0
ipmisensors: received message
ipmisensors: sensor 27 (type 2) reading 34
ipmisensors: Send 0x2d 0x1a 0x0
ipmisensors: received message
ipmisensors: sensor 26 (type 2) reading 187
ipmisensors: Send 0x2d 0x18 0x0

That's the only problem I have. It would be great to see it merged.

Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
