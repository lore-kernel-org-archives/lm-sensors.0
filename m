From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Oct 2008 20:16:32 +0000
Subject: Re: [lm-sensors] Looking for IT8720 datasheet.
Message-Id: <20081007221632.0e5a8679@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
In-Reply-To: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 03 Oct 2008 13:14:31 -0400, Frank Myhr wrote:
> Jean-Marc Spaggiari wrote:
> > When I force has_fan to 5 fans, I get:
> > 
> > fan1:       3000 RPM  (min =    0 RPM)
> > fan2:          0 RPM  (min =    0 RPM)
> > fan3:       5973 RPM  (min =    0 RPM)
> > fan4:         -1 RPM  (min =   -1 RPM)
> > fan5:         -1 RPM  (min =   -1 RPM)
> > 
> > So can I just help him to read to pwm 4 and 5 correctly?
> 
> The -1 values you're reporting for fan4 and fan5 come from
> #define FAN16_FROM_REG(val) ((val)=0?-1:(val)=0xffff?0:1350000/((val)*2))
> 
> In other words, the 8720 reports "0", the above macro converts that to
> -1. (I'm not entirely clear why this is done.)

That's a legacy from the good ol' times. Old drivers tend to report
missing fans, fan failures or impossible register values with a speed
of -1. It never made any sense to me and many drivers report this
condition as RPM = 0, with an optional fanN_fault file getting value 1
for detected fan failures.

We have no clear standard for this yet so in practice every driver is
free to report -1 or 0 for uncommon fan conditions.

> > Regarding the resistors. should I publish the values? Or it's useless?
> 
> I think it would help at least other users of your board. Perhaps add it
>  to Documentation/hwmon/it87 ?

Best is to write a configuration file for the motherboard in question
and publish it on lm-sensors.org/wiki.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
