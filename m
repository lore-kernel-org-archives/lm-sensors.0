From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 23 Jan 2012 06:06:43 +0000
Subject: Re: [lm-sensors] [PATCH 51/82] hwmon: (pc87360) Fix multi-line comments
Message-Id: <CAJfuBxxG4ZKgAUJMHxXbKQrHLhOeN=DyD8eOtzOUG9xBR3_Qgw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327017376-20466-52-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327017376-20466-52-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 21, 2012 at 10:20 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Sat, Jan 21, 2012 at 02:17:23AM -0500, Jean Delvare wrote:
>> On Sat, 21 Jan 2012 00:13:34 -0700, Jim Cromie wrote:
>> > are these checkpatch warnings ?
>>
>> Not directly, but non-standard comment style can cause false positives
>> in checkpatch.
>>
> Exactly. Also, it was straightforward to write a little program to do it
> automatically, so it was not much effort.
>
> Any comments on http://thread.gmane.org/gmane.linux.drivers.sensors/28266/focus(286 ?

Ive just built and modprobed it on voyage linux ( a debian derivative )
Given that this patch is just cleanup, thats good for an

acked-by: Jim Cromie <jim.cromie@gmail.com>

Im a little puzzled though - I have no sensors or sensors-detect on voyage,
and its apparently not available via dselect / aptitude.

So I pulled lm-sensors-3.3.1 and built it on laptop, copied it over to
the soekris.
sensors-detect wont work, I cant install the dependencies -
not enough memory there to do apt-get install.

sensors works though, and seems to have all the info.

pc87366-isa-6620
Adapter: ISA adapter
in0:          +3.01 V  (min =  +0.00 V, max =  +3.01 V)
in1:          +2.00 V  (min =  +0.00 V, max =  +3.01 V)
in2:          +2.49 V  (min =  +0.00 V, max =  +3.01 V)
in3:          +0.60 V  (min =  +0.00 V, max =  +3.01 V)
in4:          +2.46 V  (min =  +0.00 V, max =  +3.01 V)
in5:          +2.49 V  (min =  +0.00 V, max =  +3.01 V)
in6:          +0.00 V  (min =  +0.00 V, max =  +3.01 V)
3VSB:         +3.31 V  (min =  +0.00 V, max =  +6.03 V)
VDD:          +3.05 V  (min =  +0.00 V, max =  +6.03 V)
Vbat:         +0.00 V  (min =  +0.00 V, max =  +0.00 V)
AVDD:         +3.28 V  (min =  +0.00 V, max =  +6.03 V)
temp1:          FAULT  (low  = -55.0 C, high = +127.0 C)  ALARM (HIGH, CRIT)
                       (crit = +127.0 C)
temp2:          FAULT  (low  = -55.0 C, high = +127.0 C)  ALARM (HIGH, CRIT)
                       (crit = +127.0 C)
SIO Temp:     +91.0 C  (low  = -55.0 C, high = +127.0 C)
                       (crit = +127.0 C)
temp4:         +0.0 C  (low  =  +0.0 C, high =  +0.0 C)
                       (crit =  +0.0 C)
temp5:         +0.0 C  (low  =  +0.0 C, high =  +0.0 C)
                       (crit =  +0.0 C)
temp6:         +0.0 C  (low  =  +0.0 C, high =  +0.0 C)
                       (crit =  +0.0 C)
cpu0_vid:    +0.000 V

I'll have to go digging for a customized sensors3.conf to know better.


FTR, and so Ive written it down, to check (compare against) your last
cleanup patch:

root@voyage:/sys/class/hwmon/hwmon0/device# ls | wc
    128     128    1472

root@voyage:/sys/class/hwmon/hwmon0/device# ls temp* | wc
     51      51     666
root@voyage:/sys/class/hwmon/hwmon0/device# ls temp1* |wc
      9       9     117
root@voyage:/sys/class/hwmon/hwmon0/device# ls temp6* |wc
      8       8     105
root@voyage:/sys/class/hwmon/hwmon0/device# ls in* | wc
     66      66     721
root@voyage:/sys/class/hwmon/hwmon0/device# ls in1* | wc
     12      12     136
root@voyage:/sys/class/hwmon/hwmon0/device# ls in10* | wc
      6       6      71

I'll build all 3 patches together, and report back soon.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
