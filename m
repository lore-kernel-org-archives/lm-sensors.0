From: Mark Hansen <meh@Winfirst.Com>
Date: Sat, 03 Jan 2015 18:14:56 +0000
Subject: Re: [lm-sensors] Trying to get lm_sensors working on an ASUS M5A97 R2.0 motherboard
Message-Id: <54A831A0.4030702@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <54A5E332.7090000@Winfirst.Com>
In-Reply-To: <54A5E332.7090000@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 1/3/2015 9:43 AM, Guenter Roeck wrote:
> On Thu, Jan 01, 2015 at 04:15:46PM -0800, Mark Hansen wrote:
>>  I have a new CentOS 7.0 system running on an ASUS M5A97 R2.0 motherboard and
>>  am having a hard time getting the configuration correct.
>>
>>  I started by running sensors-detect, which seemed to work. I decided I need
>>  the "it87" module and added that to /etc/sysconfig/lm_sensors.
>>
>>  I then took a configuration from the lm-sensors Wiki:
>>
>>  http://lm-sensors.org/wiki/Configurations/Asus/M5A97-Pro
>>
>>  Note: I realize this is the Pro and not the R2.0.
>>
>>  I took the values shown on the BIOS monitoring screen and applied various labels
>>  and min/max settings to what I thought matched in the sensors output. It all looks
>>  good (assuming I did things correctly) except that it's showing one voltage output
>>  that is not on the BIOS screen. This value is outside the min/max range and so it
>>  shows as "ALARM" and I can't figure out how to get rid of it.
>>
>>  The sensors output is shown below. The specific value I'm talking about
>>  is called 3VSB. How can I remove this from sensors or set the min/max values
>>  for it?
>>
> 3VSB is in7, so you can either configure "ignore in7" or configure in7_min and
> in7_max.
>
> Guenter
>

Thank you, Guenter. That was the ticket.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
