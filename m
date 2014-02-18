From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 18 Feb 2014 04:07:59 +0000
Subject: Re: [lm-sensors] sensors command now hangs [update 2]
Message-Id: <5302DC9F.2010804@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <53027C66.60608@gmail.com>
In-Reply-To: <53027C66.60608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/17/2014 04:43 PM, David Anderson wrote:
> Not using Noveau driver at all here.
>          lsmod |grep nov
> shows nothing.  I just thought it was interesting that someone
> else had a hanging sensors command.
>
Hi David,

That grep wont help much, as it is nouveau (with an added u),
not noveau.

> On 02/17/2014 03:17 PM, Guenter Roeck wrote:
>
>> I think I already asked this - in your original e-mail,
>> you mentioned that the sensors command 'now hangs', and that
>> only started happening some time ago. What did you change -
>> if anything - in your system before this started to happen ?
>
> The only change I can think of
> was to move from Ubuntu 13.04 to
> Ubuntu 13.10.
>
Right now I have no idea what may be different. 13.4 is the 3.8 kernel
if I remember correctly, and 13.10 should be 3.11. I did a quick diff
in the relevant drivers but did not see anything that might cause
the problem.

To find out what exactly is hanging, you might try something like

cd /sys/class/hwmon
for d in *
do
(echo $d:
cd $d
if [ ! -f name ]
then
cd device
fi
ls
grep . *
)
done

The last line of output should show the attribute causing the hang,
or rather the one accessed before it.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
