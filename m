From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: RFC testing automatic fan clock divider - results
Message-Id: <p8co51dsr1rpl932d51jfqcvhgs5ve2mqv@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1eem519h5an7mbvhid4gpfvusi08jvuv54@4ax.com>
In-Reply-To: <1eem519h5an7mbvhid4gpfvusi08jvuv54@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 12 Apr 2005 14:44:37 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>
>Hi Grant,
>
>You min figures look suspicious to me.

They are crap, yes -- I'm pretty much back to your algorithm now with 
a couple extras:

                unsigned int new_min = 1350000U / val;
                u8 new_div = 0;

                while (new_min > magic && new_div < 3) { <<= keep new_div in range
                        new_div++;
                        new_min++;  <<= integer rounding before / 2
                        new_min >>= 1;
                }

If I'd realised about intended data-loss (fan speed way below 
fan_min) is correct because the fan was spinning way too slow 
for user defined minimum, therefore not being able to measure 
fan speed is alright, as fan is borked by user definition :)

Cheers,
Grant.

auto? fan1 div 8 min 255 val   400 spd 42
auto! fan1 div 8 min 255 too low
auto? fan1 div 8 min 255 val   500 spd 42
auto! fan1 div 8 min 255 too low
auto? fan1 div 8 min 255 val   600 spd 42
auto! fan1 div 8 min 255 too low
auto? fan1 div 8 min 255 val   700 spd 42
auto- fan1 div 8 min 241
auto? fan1 div 8 min 241 val   800 spd 42
auto- fan1 div 8 min 211
auto? fan1 div 8 min 211 val  1000 spd 42
auto- fan1 div 8 min 169
auto? fan1 div 8 min 169 val  1200 spd 42
auto- fan1 div 8 min 141
auto? fan1 div 8 min 141 val  1400 spd 42
auto- fan1 div 8 min 121
auto? fan1 div 8 min 121 val  1700 spd 42
auto- fan1 div 8 min 100
auto? fan1 div 8 min 100 val  2000 spd 42
auto- fan1 div 4 min 169
autoX fan1 old 8 new   4 div changed
auto? fan1 div 4 min 169 val  2400 spd 83
auto- fan1 div 4 min 141
auto? fan1 div 4 min 141 val  2900 spd 84
auto- fan1 div 4 min 117
auto? fan1 div 4 min 117 val  3500 spd 84
auto- fan1 div 4 min  97
auto? fan1 div 4 min  97 val  4200 spd 84
auto- fan1 div 2 min 161
autoX fan1 old 4 new   2 div changed
auto? fan1 div 2 min 161 val  5000 spd 167
auto- fan1 div 2 min 135
auto? fan1 div 2 min 135 val  6000 spd 167
auto- fan1 div 2 min 113
auto? fan1 div 2 min 113 val  7200 spd 168
auto- fan1 div 1 min 187
autoX fan1 old 2 new   1 div changed
auto? fan1 div 1 min 187 val  8600 spd 255
auto- fan1 div 1 min 156
auto? fan1 div 1 min 156 val 10300 spd 255
auto- fan1 div 1 min 131
auto? fan1 div 1 min 131 val 12400 spd 255
auto- fan1 div 1 min 108
auto? fan1 div 1 min 108 val 14900 spd 255
auto- fan1 div 1 min  90
auto? fan1 div 1 min  90 val 17900 spd 255
auto- fan1 div 1 min  75
auto? fan1 div 1 min  75 val 21500 spd 255
auto- fan1 div 1 min  62
auto? fan1 div 1 min  62 val 25800 spd 255
auto- fan1 div 1 min  52
auto? fan1 div 1 min  52 val 31000 spd 255
auto- fan1 div 1 min  43
auto? fan1 div 1 min  43 val 37200 spd 255
auto- fan1 div 1 min  36
auto? fan1 div 1 min  36 val 44600 spd 255
auto- fan1 div 1 min  30
auto? fan1 div 1 min  30 val 53500 spd 255
auto- fan1 div 1 min  25
auto? fan1 div 1 min  25 val 64200 spd 255
auto- fan1 div 1 min  21
auto? fan1 div 1 min  21 val 77000 spd 255
auto- fan1 div 1 min  17
auto? fan1 div 1 min  17 val 92400 spd 255
auto- fan1 div 1 min  14
auto? fan1 div 1 min  14 val 110900 spd 255
auto- fan1 div 1 min  12
auto? fan1 div 1 min  12 val 133100 spd 255
auto- fan1 div 1 min  10
auto? fan1 div 1 min  10 val 159700 spd 255
auto- fan1 div 1 min   8
auto? fan1 div 1 min   8 val 191600 spd 255
auto- fan1 div 1 min   7
auto? fan1 div 1 min   7 val 229900 spd 255
auto- fan1 div 1 min   5
auto? fan1 div 1 min   5 val 275900 spd 255
auto- fan1 div 1 min   4
auto? fan1 div 1 min   4 val 331100 spd 255
auto- fan1 div 1 min   4
auto? fan1 div 1 min   4 val 397300 spd 255
auto- fan1 div 1 min   3
auto? fan1 div 1 min   3 val 476800 spd 255
auto- fan1 div 1 min   2
auto? fan1 div 1 min   2 val 572200 spd 255
auto- fan1 div 1 min   2
auto? fan1 div 1 min   2 val 686600 spd 255
auto- fan1 div 1 min   1
auto? fan1 div 1 min   1 val 823900 spd 255
auto- fan1 div 1 min   1
auto? fan1 div 1 min   1 val 988700 spd 255
auto- fan1 div 1 min   1
auto? fan1 div 1 min   1 val 1186400 spd 255
auto- fan1 div 1 min   1
auto? fan1 div 1 min   1 val 1350000 spd 255
auto- fan1 div 1 min   1
auto? fan1 div 1 min   1 val 1125000 spd 255
auto- fan1 div 1 min   1
auto? fan1 div 1 min   1 val 937500 spd 255
auto- fan1 div 1 min   1
auto? fan1 div 1 min   1 val 781300 spd 255
auto- fan1 div 1 min   1
auto? fan1 div 1 min   1 val 651100 spd 255
auto- fan1 div 1 min   2
auto? fan1 div 1 min   2 val 542600 spd 255
auto- fan1 div 1 min   2
auto? fan1 div 1 min   2 val 452200 spd 255
auto- fan1 div 1 min   2
auto? fan1 div 1 min   2 val 376800 spd 255
auto- fan1 div 1 min   3
auto? fan1 div 1 min   3 val 314000 spd 255
auto- fan1 div 1 min   4
auto? fan1 div 1 min   4 val 261700 spd 255
auto- fan1 div 1 min   5
auto? fan1 div 1 min   5 val 218100 spd 255
auto- fan1 div 1 min   6
auto? fan1 div 1 min   6 val 181800 spd 255
auto- fan1 div 1 min   7
auto? fan1 div 1 min   7 val 151500 spd 255
auto- fan1 div 1 min   8
auto? fan1 div 1 min   8 val 126300 spd 255
auto- fan1 div 1 min  10
auto? fan1 div 1 min  10 val 105300 spd 255
auto- fan1 div 1 min  12
auto? fan1 div 1 min  12 val 87800 spd 255
auto- fan1 div 1 min  15
auto? fan1 div 1 min  15 val 73200 spd 255
auto- fan1 div 1 min  18
auto? fan1 div 1 min  18 val 61000 spd 255
auto- fan1 div 1 min  22
auto? fan1 div 1 min  22 val 50800 spd 255
auto- fan1 div 1 min  26
auto? fan1 div 1 min  26 val 42300 spd 255
auto- fan1 div 1 min  31
auto? fan1 div 1 min  31 val 35300 spd 255
auto- fan1 div 1 min  38
auto? fan1 div 1 min  38 val 29400 spd 255
auto- fan1 div 1 min  45
auto? fan1 div 1 min  45 val 24500 spd 255
auto- fan1 div 1 min  55
auto? fan1 div 1 min  55 val 20400 spd 255
auto- fan1 div 1 min  66
auto? fan1 div 1 min  66 val 17000 spd 255
auto- fan1 div 1 min  79
auto? fan1 div 1 min  79 val 14200 spd 255
auto- fan1 div 1 min  95
auto? fan1 div 1 min  95 val 11800 spd 255
auto- fan1 div 1 min 114
auto? fan1 div 1 min 114 val  9800 spd 255
auto- fan1 div 1 min 137
auto? fan1 div 1 min 137 val  8200 spd 255
auto- fan1 div 1 min 164
auto? fan1 div 1 min 164 val  6800 spd 255
auto- fan1 div 2 min  99
autoX fan1 old 1 new   2 div changed
auto? fan1 div 2 min  99 val  5700 spd 167
auto- fan1 div 2 min 118
auto? fan1 div 2 min 118 val  4800 spd 167
auto- fan1 div 2 min 141
auto? fan1 div 2 min 141 val  4000 spd 167
auto- fan1 div 2 min 169
auto? fan1 div 2 min 169 val  3300 spd 167
auto- fan1 div 4 min 103
autoX fan1 old 2 new   4 div changed
auto? fan1 div 4 min 103 val  2800 spd 84
auto- fan1 div 4 min 121
auto? fan1 div 4 min 121 val  2300 spd 84
auto- fan1 div 4 min 147
auto? fan1 div 4 min 147 val  1900 spd 83
auto- fan1 div 4 min 178
auto? fan1 div 4 min 178 val  1600 spd 84
auto- fan1 div 8 min 106
autoX fan1 old 4 new   8 div changed
auto? fan1 div 8 min 106 val  1300 spd 42
auto- fan1 div 8 min 130
auto? fan1 div 8 min 130 val  1100 spd 42
auto- fan1 div 8 min 154
auto? fan1 div 8 min 154 val   900 spd 42
auto- fan1 div 8 min 188
auto? fan1 div 8 min 188 val   800 spd 42
auto- fan1 div 8 min 211
auto? fan1 div 8 min 211 val   700 spd 42
auto- fan1 div 8 min 241
auto? fan1 div 8 min 241 val   600 spd 42
auto! fan1 div 8 min 255 too low
auto? fan1 div 8 min 255 val   500 spd 42
auto! fan1 div 8 min 255 too low
