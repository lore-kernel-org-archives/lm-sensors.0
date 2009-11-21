From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 Nov 2009 15:49:51 +0000
Subject: Re: [lm-sensors] pwmconfig can only control fan speed at beginning
Message-Id: <20091121164951.73d9c7ab@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
In-Reply-To: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 21 Nov 2009 07:19:01 -0800, Allen Edwards wrote:
> I searched back several months of your archives and can't find anything
> relevant to my problem.  When I run pwmconfig it finds my fans and controls
> the speeds. I can run a characterization of fan speeds vs settings and find
> that 180 is a good speed noise wise.  It is definitely controlling the fan
> speed.  But when it gets to the part about finding the min and max stall
> speeds, it will not control the fan speed, the fan just stays at full speed.
>  And, of course, fancontrol will not work.  This seems very strange to me.
>  The fan is 3 wire and I have tried it in both a 3 and 4 wire controllable
> header.

And you are using lm-sensors version...? Kernel version...? Hwmon
drivers...?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
