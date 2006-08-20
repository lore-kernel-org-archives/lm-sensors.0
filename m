From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 20 Aug 2006 22:28:43 +0000
Subject: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error
Message-Id: <1156112923.4051.51.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E8C9AE.3060307@gmail.com>
In-Reply-To: <44E8C9AE.3060307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, Mark Studebaker <mdsxyz123@yahoo.com>, lm-sensors@lm-sensors.org, LKML <linux-kernel@vger.kernel.org>

Ar Sul, 2006-08-20 am 22:44 +0200, ysgrifennodd Michal Piotrowski:
> Hi,
> 
> This patch fixes 56 sparse "ignoring return value of 'device_create_file'" warnings. It also adds error handling.
> 

The core of these wants turning into called functions with the extra
checks included, just because of the size it now is.


