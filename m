From: Tony <jester402003@msn.com>
Date: Wed, 07 May 2014 07:02:06 +0000
Subject: Re: [lm-sensors] IT8620E working with it87 driver
Message-Id: <BLU436-SMTP215D045EB33AFDCC352C3B8DF4E0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMqk1ZyC2w7JnJ7xyDPwCvXkHQjwkPmG_LhyC8_doavpeXHXyA@mail.gmail.com>
In-Reply-To: <CAMqk1ZyC2w7JnJ7xyDPwCvXkHQjwkPmG_LhyC8_doavpeXHXyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ash

Thank you for you suggestion have tried loading the mod and got error no
file have download it87 driver for the web site and did make, make
install and rebooted and did sensors-detect and got the same as before
can someone tell me what i am doing wrong (I have use LM Sensor on HP
and Dell Servers and for the most part it just worked)

Cheers
Tony

On Tue, 2014-05-06 at 22:06 +0800, Ash Wiren wrote:
> > (2014-03-16) One request (Kertesz Laszlo). No datasheet. We had a report that the chip is somewhat compatible with the IT8728F for the hardware monitoring part. Be very careful with fan control as it wasn't tested. So you can try loading the it87 driver with force_id=0x8728 and see how it goes. If you do, please report!
> 
> Reporting this as working.
> 
> Regards
> Ash Wiren
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
