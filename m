From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Sep 2009 13:22:10 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: add support for Asus P7P55D
Message-Id: <20090928152210.593e5d48@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090923191240.GA15198@dreamland.darkstar.lan>
	<51f3faa70909232018v7e621190m84deb648b08d2135@mail.gmail.com>
	<20090928131700.GA19243@nb-core2.darkstar.lan>
In-Reply-To: <20090928131700.GA19243@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Lucas,

On Mon, 28 Sep 2009 15:17:00 +0200, Luca Tettamanti wrote:
> I have a new patch for you :)
> It contains the previous changes to handle the bigger ASBF buffer plus a new
> method to enable the EC as suggested by Asus. Be sure to compile with
> HWMON_DEBUG_CHIP enabled.

Wow, that's a lot of code to just enable the EC, I hoped it would be
more simple than this :(

Wouldn't it make sense to also disable the EC when the asus_atk0110
driver is removed? To restore the chip to its initial state.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
