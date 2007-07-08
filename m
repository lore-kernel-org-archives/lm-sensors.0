From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2007 12:42:18 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 support for 2.6 (2nd revision)
Message-Id: <20070708144218.412d67aa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
In-Reply-To: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Fri, 06 Jul 2007 13:39:47 +0200, Krzysztof Helt wrote:
> I need help how to name the temperature 3 and 4. They are both on
> the MB. Do you have any standard for naming temperatures in the
> lmsensors lib (like CPU are always "Temp CPUx")?

Sensor names don't go into the library. The only place where you give
names to the sensors is in sensors.conf. As you're writing a dedicated
configuration file for your motherboard, you are free to choose
whatever names you like. You can look at other configuration files for
examples (etc/sensors.conf.eg or the ones in the wiki on
lm-sensors.org.)

> Thanks for the tip with hair-dryer.

Be careful when trying this. Electronic components don't like abrupt
temperature changes, so make sure that the air coming out of the
hair-dryer isn't too hot. If it's too hot, you'll need to find a way to
mix it with fresher air, or you might damage your hardware.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
