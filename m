From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 May 2007 17:00:20 +0000
Subject: Re: [lm-sensors] w83627hf.c pwm frequency patch
Message-Id: <20070515190020.60f498f7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <bj0b43lnno3l4t105008r2ou1uan2e4u5c@4ax.com>
In-Reply-To: <bj0b43lnno3l4t105008r2ou1uan2e4u5c@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Carlos,

On Sat, 12 May 2007 11:05:39 +0200, com.ea wrote:
> Hello guys,
> 
> I came back home for a few days and could test the changes I made to the driver to support the pwm
> frequency registers. Anyway I only have a w83697hf at hand to make the tests, and the registers in
> 627hf are a bit different. Does someone want to test it?

Unfortunately I have a W83627THF variant, it uses DC for fan speed
control, so obviously your work won't have any effect on my chip.

> Btw, is it ok if I send a patch against 2.6.21.1?

No, please send a patch against 2.6.22-rc1 or later. The w83627hf
driver received a huge update between 2.6.21 and 2.6.22-rc1.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
