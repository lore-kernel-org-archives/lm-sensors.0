From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: RFC testing automatic fan clock divider - results
Message-Id: <eesn51tqp8d9kna0stvkavumkgu0lr7org@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1eem519h5an7mbvhid4gpfvusi08jvuv54@4ax.com>
In-Reply-To: <1eem519h5an7mbvhid4gpfvusi08jvuv54@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Tue, 12 Apr 2005 14:44:37 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>You min figures look suspicious to me.
>
>> (...) adm9240 0-002d: auto1: fan 1, div 1, min 0, val 1350000, spd 255
>> (...) adm9240 0-002d: auto3: fan 1, div 1, min 0
>> (...) adm9240 0-002d: auto4: fan 1, div 1, min 0, final
>
>This would yield a min of 1, not 0.
>
>> (...) adm9240 0-002d: auto1: fan 1, div 1, min 0, val 651100, spd 255
>> (...) adm9240 0-002d: auto3: fan 1, div 1, min 0
>> (...) adm9240 0-002d: auto4: fan 1, div 1, min 0, final
>
>1350000/651100 = 2, not 0.
>
>> (...) adm9240 0-002d: auto1: fan 1, div 1, min 0, val 151500, spd 255
>> (...) adm9240 0-002d: auto3: fan 1, div 1, min 8
>
>And here suddenly it jumps from 0 to 8 directly. This doesn't make
>sense. Could you please check your code and find out the reason?

Another pair of eyes:)  I was looking for absence of a different effect, 
will do check with this in mind.  

Cheers,
Grant.
