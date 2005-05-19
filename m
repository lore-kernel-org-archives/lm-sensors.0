From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH 2.6] I2C: Sync i2c-id.h with legacy i2c project
Message-Id: <oMBRVJ2v.1108716031.8808690.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050206143423.41eeaef1.khali@linux-fr.org>
In-Reply-To: <20050206143423.41eeaef1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

> Ick, what a mess. I've fixed this up in my trees now, and added the
> "reserved" numbers you had in your patch (why reserve them, why not just
> use them :)

Because they have no user at the moment, and might as well never have in
the future?

I don't really care that they are defined by anticipation or only
reserved as comments as long as this ensures that no duplicate nor
collision will exist.

Thanks,
--
Jean Delvare
