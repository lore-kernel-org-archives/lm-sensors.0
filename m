From: Lee Burchett <zaknafien13@gmail.com>
Date: Fri, 24 Feb 2012 13:58:48 +0000
Subject: Re: [lm-sensors] Chip missing from the drivers list.
Message-Id: <4F479798.9040803@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330089448.3270.9.camel@torre-enrique>
In-Reply-To: <1330089448.3270.9.camel@torre-enrique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/24/2012 08:17 AM, Enrique wrote:
> Hello,
>
> my name is Enrique and after looking how to monitor the temperature of
> the system in my computer with lm-sensors, it turn up that my chip
> "Nuvoton W83677HG-I Super IO Sensors" is not supported yet.
>
> This mail is to make you know about this, and also that I'm up to help
> with the testing.
>
> Best regards,
>
> Enrique.
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

Enrique,

I have the same chip in my system. Guenter helped me get it working. 
Luckily, this chip is already supported in the latest version. If you 
get Guenter's driver for the NCT6776F 
(http://roeck-us.net/linux/drivers/) and pull the latest trunk of 
lm-sensors from the repository, then you should be good to go. I did 
have to add

w83627ehf

to my /etc/modules file. I'm not sure what distro you are using, but 
that worked on Ubuntu x64 11.10 with the 3.0.0-16-generic kernel.

Good Luck
-Lee

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
