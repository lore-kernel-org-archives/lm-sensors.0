From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jun 2011 12:13:31 +0000
Subject: Re: [lm-sensors] [3.0 regression?] coretemp driver output has
Message-Id: <20110628141331.146e154f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
In-Reply-To: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Artem,

On Tue, 28 Jun 2011 08:42:40 +0000 (GMT), Artem S. Tashkinov wrote:
> On Jun 28, 2011, Guenter Roeck <guenter.roeck@ericsson.com> wrote: 
> 
> > I start wondering ... do you have any ignore entries for coretemp in /etc/sensors3.conf ?
> 
> > Or, in other words, what does the system report if you execute "sensors -u"
> > instead of "sensors" ?
> 
> $ sensors -u
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:
>   temp1_input: 37.000
>   temp1_max: 80.000
>   temp1_crit: 99.000
>   temp1_crit_alarm: 0.000
> Core 0:
>   temp2_input: 37.000
>   temp2_max: 80.000
>   temp2_crit: 99.000
>   temp2_crit_alarm: 0.000
> Core 3:
>   temp5_input: 35.000
>   temp5_max: 80.000
>   temp5_crit: 99.000
>   temp5_crit_alarm: 0.000

I would be more interested by the output of:
$ sensors -u -c /dev/null

And if it still doesn't show Core 1 and Core 2, please try again under
strace:

$ strace sensors -u -c /dev/null 2> /tmp/sensors.trace

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
