From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Sep 2008 11:42:14 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <20080926134214.66f01f1b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Anthony,

On Thu, 25 Sep 2008 17:13:17 -0700, Anthony Arobone wrote:
> Finally got the board all hooked up again.  I've attached a text file with
> all the output I could think of.  Notice the dmesg warning when modprobing
> lm85.

Can you please provide a dump of your chip? You should be able to get
it the following way:

# rmmod lm85
# modprobe i2c-dev
# i2cdump 0 0x2e b

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
