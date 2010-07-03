From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Jul 2010 11:00:05 +0000
Subject: Re: [lm-sensors] W83667HG-B or -A
Message-Id: <20100703130005.30be90eb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C2F097F.4070106@gmail.com>
In-Reply-To: <4C2F097F.4070106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Iain,

On Sat, 03 Jul 2010 10:57:19 +0100, Iain wrote:
> I have an Asus P7F-E and sensors-detect tells me I have a W83667HG-B so I was very interested to see the drivers that have been 
> posted over the last few days for the -B, especially as the asus_atk0110 driver doesn't work on this board.
> 
> However, the chip on the board is physically marked as W83667HG-A and appears to have a devid of B353.

This is odd. B353 is definitely the ID of a -B chip. I would trust the
ID over the top marking.

> Is it reasonable to assume that the recent -B drivers will work with this chip ?  If so, I'd be happy to help out with testing.

Yes, it should work. I've added you to the list of requests. I will
post a link to a standalone driver for easy testing soon.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
