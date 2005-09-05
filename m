From: grant_lkml@dodo.com.au (Grant Coady)
Date: Mon, 05 Sep 2005 01:37:58 +0000
Subject: [lm-sensors] Re: RFC PATCH patch-13-mm1-hwmon-adm9240-whitespace-1
Message-Id: <e41nh1ht18p7dheui6dis7s0ug72krn4pi@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <uvhkh19nggg4s7rv03ab6tetdu06jlmk42@4ax.com>
In-Reply-To: <uvhkh19nggg4s7rv03ab6tetdu06jlmk42@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 4 Sep 2005 13:29:09 +0200, Jean Delvare <khali@linux-fr.org> wrote:
>
>> > Are you referring to Yani Ioannou's dynamic sysfs callbacks? That
>> > would be very welcome, thanks for looking into that.
>> 
>> Yes, it finally seems to have settled some?
>
>Yes it has. There are 6 drivers converted already (lm63, lm83, lm90,
>it87, adm1026 and w83792d) and one more in the works (pc87360.)
>Considering the size shrink and code readability improvement that was
>obtained each time, converting more drivers is very welcome.

Okay, I can work on and test lm78 and W83697HF drivers as well then.

Thanks,
Grant

