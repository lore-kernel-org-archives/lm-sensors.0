From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: RFC testing automatic fan clock divider - results
Message-Id: <omen51l2hbg42c0i84pogjmqorjml8o4qo@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1eem519h5an7mbvhid4gpfvusi08jvuv54@4ax.com>
In-Reply-To: <1eem519h5an7mbvhid4gpfvusi08jvuv54@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

G'day,
On Tue, 12 Apr 2005 13:33:51 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

Removed articial set_fan_min too high test, much saner results 
appended :)  Fan1 runs at just over 4000 rpm.

More testing tomorrow.

Cheers,
Grant.

Apr 12 21:59:24 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 1350000, spd 255
Apr 12 21:59:24 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:24 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:26 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 1125000, spd 255
Apr 12 21:59:26 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:26 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:28 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 937500, spd 255
Apr 12 21:59:28 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:28 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:30 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 781300, spd 255
Apr 12 21:59:30 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:30 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:32 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 651100, spd 255
Apr 12 21:59:32 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:32 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:34 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 542600, spd 255
Apr 12 21:59:34 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:34 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:36 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 452200, spd 255
Apr 12 21:59:36 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:36 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:38 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 376800, spd 255
Apr 12 21:59:38 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:38 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:40 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 314000, spd 255
Apr 12 21:59:40 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:40 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:42 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 261700, spd 255
Apr 12 21:59:42 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:42 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:44 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 218100, spd 255
Apr 12 21:59:44 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:44 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:47 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 181800, spd 255
Apr 12 21:59:47 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 0
Apr 12 21:59:47 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 0, final
Apr 12 21:59:49 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 0, val 151500, spd 255
Apr 12 21:59:49 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 8
Apr 12 21:59:49 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 8, final
Apr 12 21:59:51 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 8, val 126300, spd 255
Apr 12 21:59:51 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 8
Apr 12 21:59:51 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 8, final
Apr 12 21:59:53 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 8, val 105300, spd 255
Apr 12 21:59:53 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 8
Apr 12 21:59:53 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 8, final
Apr 12 21:59:55 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 8, val 87800, spd 255
Apr 12 21:59:55 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 8
Apr 12 21:59:55 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 8, final
Apr 12 21:59:57 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 8, val 73200, spd 255
Apr 12 21:59:57 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 16
Apr 12 21:59:57 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 16, final
Apr 12 21:59:59 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 16, val 61000, spd 255
Apr 12 21:59:59 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 16
Apr 12 21:59:59 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 16, final
Apr 12 22:00:01 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 16, val 50800, spd 255
Apr 12 22:00:01 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 24
Apr 12 22:00:01 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 24, final
Apr 12 22:00:03 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 24, val 42300, spd 255
Apr 12 22:00:03 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 24
Apr 12 22:00:03 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 24, final
Apr 12 22:00:05 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 24, val 35300, spd 255
Apr 12 22:00:05 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 32
Apr 12 22:00:05 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 32, final
Apr 12 22:00:07 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 32, val 29400, spd 255
Apr 12 22:00:07 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 40
Apr 12 22:00:07 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 40, final
Apr 12 22:00:09 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 40, val 24500, spd 255
Apr 12 22:00:09 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 48
Apr 12 22:00:09 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 48, final
Apr 12 22:00:11 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 48, val 20400, spd 255
Apr 12 22:00:11 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 64
Apr 12 22:00:11 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 64, final
Apr 12 22:00:13 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 64, val 17000, spd 255
Apr 12 22:00:13 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 72
Apr 12 22:00:13 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 72, final
Apr 12 22:00:15 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 72, val 14200, spd 255
Apr 12 22:00:15 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 88
Apr 12 22:00:15 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 88, final
Apr 12 22:00:17 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 88, val 11800, spd 255
Apr 12 22:00:17 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 112
Apr 12 22:00:17 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 112, final
Apr 12 22:00:19 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 112, val 9800, spd 255
Apr 12 22:00:19 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 136
Apr 12 22:00:19 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 136, final
Apr 12 22:00:22 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 136, val 8200, spd 255
Apr 12 22:00:22 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 160
Apr 12 22:00:22 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 160, final
Apr 12 22:00:24 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 160, val 6800, spd 255
Apr 12 22:00:24 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 192
Apr 12 22:00:24 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 1, min 192, final
Apr 12 22:00:26 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 1, min 192, val 5700, spd 255
Apr 12 22:00:26 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 232
Apr 12 22:00:26 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 2, min 116, final
Apr 12 22:00:26 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 1, new 2, div changed
Apr 12 22:00:28 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 116, val 4800, spd 165
Apr 12 22:00:28 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 280
Apr 12 22:00:28 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 2, min 140, final
Apr 12 22:00:30 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 140, val 4000, spd 165
Apr 12 22:00:30 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 1, min 336
Apr 12 22:00:30 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 2, min 168, final
Apr 12 22:00:32 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 2, min 168, val 3300, spd 165
Apr 12 22:00:32 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 2, min 204
Apr 12 22:00:32 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 4, min 102, final
Apr 12 22:00:32 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 2, new 4, div changed
Apr 12 22:00:34 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 102, val 2800, spd 82
Apr 12 22:00:34 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 2, min 240
Apr 12 22:00:34 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 4, min 120, final
Apr 12 22:00:36 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 120, val 2300, spd 83
Apr 12 22:00:36 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 2, min 292
Apr 12 22:00:36 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 4, min 146, final
Apr 12 22:00:38 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 146, val 1900, spd 83
Apr 12 22:00:38 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 2, min 352
Apr 12 22:00:38 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 4, min 176, final
Apr 12 22:00:40 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 4, min 176, val 1600, spd 82
Apr 12 22:00:40 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 4, min 210
Apr 12 22:00:40 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 8, min 105, final
Apr 12 22:00:40 peetoo kernel: adm9240 0-002d: autoX: fan 1, old 4, new 8, div changed
Apr 12 22:00:42 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 105, val 1300, spd 41
Apr 12 22:00:42 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 4, min 258
Apr 12 22:00:42 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 8, min 129, final
Apr 12 22:00:44 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 129, val 1100, spd 41
Apr 12 22:00:44 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 4, min 306
Apr 12 22:00:44 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 8, min 153, final
Apr 12 22:00:46 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 153, val 900, spd 41
Apr 12 22:00:46 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 4, min 374
Apr 12 22:00:46 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 8, min 187, final
Apr 12 22:00:48 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 187, val 800, spd 42
Apr 12 22:00:48 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 8, min 210
Apr 12 22:00:48 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 8, min 210, final
Apr 12 22:00:50 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 210, val 700, spd 41
Apr 12 22:00:50 peetoo kernel: adm9240 0-002d: auto3: fan 1, div 8, min 241
Apr 12 22:00:50 peetoo kernel: adm9240 0-002d: auto4: fan 1, div 8, min 241, final
Apr 12 22:00:52 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 241, val 600, spd 42
Apr 12 22:00:52 peetoo kernel: adm9240 0-002d: auto2: fan 1, div 8, min 255, final
Apr 12 22:00:55 peetoo kernel: adm9240 0-002d: auto1: fan 1, div 8, min 255, val 500, spd 41
Apr 12 22:00:55 peetoo kernel: adm9240 0-002d: auto2: fan 1, div 8, min 255, final

