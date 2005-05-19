From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: RFC: test results for adm9240 auto fan clock divider
Message-Id: <pea8615m7fc0afhobd82frv1be2vspnh36@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
In-Reply-To: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 18 Apr 2005 22:16:18 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>
>> Requirements:
>
>Agreed on everything, except:
>
>> automatic fan clock divider
>> ````````````````````````````
>>     * User sets 0 to fan_min limit
>>       - low speed alarm is disabled
>>       - fan clock divider not changed
>>       - auto fan clock adjuster disabled
>
>Why would we want to disable the auto fan clock adjuster in this case?

We don't, here are some test results after fixing above:

first, full display after installing new adm9240:

peetoo:0-002d$ wy_set_limits
peetoo:0-002d$ ww_adm9240

 volt      min     inp     max  alarm
 Vtt      1367    1510    1628    --
 3.3V     3145    3352    3455    --
 5V       4766    5182    5234    --
 12V     11438   12250   12563    --
-5V      -4484   -5124   -5491    --
-12V    -10868  -11593  -13145    --

 temp      inp     max    hyst  alarm
  1       29.5    55.0    50.0    --

 fan       rpm     min    div   alarm
  1       1467    1197     8      --
  2          0       0     4      --

 cpu0_vid:      2000
 analog_out:    1235
 alarms:        0x0000
 ci_alarm:      --

Turn up full speed (it has a variable resistor in series with 
thermisor to calibrate operating point)

Fan clock divider adjusted down one:
 fan       rpm     min    div   alarm
  1       4018       0     4      --
  2          0       0     8      --

Hysteresis, fan clock divider stays at 4:
 fan       rpm     min    div   alarm
  1       1474       0     4      --
  2          0       0     8      --

Fan clock adjusted downwards (stuck my finger into the fan :o)
 fan       rpm     min    div   alarm
  1        861       0     8      --
  2          0       0     8      --

 fan       rpm     min    div   alarm
  1          0       0     8      --
  2          0       0     8      --

All fixed?

Cheers,
Grant
