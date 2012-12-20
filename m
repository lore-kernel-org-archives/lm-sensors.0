From: Juergen Beisert <jbe@pengutronix.de>
Date: Thu, 20 Dec 2012 10:30:38 +0000
Subject: Re: [lm-sensors] [PATCH v2] linux/kernel.h: Fix DIV_ROUND_CLOSEST with unsigned divisors
Message-Id: <201212201130.39235.jbe@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1355928015-26212-1-git-send-email-linux@roeck-us.net> <20121219224122.GA26863@roeck-us.net> <20121220112202.3ead1fe1@endymion.delvare>
In-Reply-To: <20121220112202.3ead1fe1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Jean,

Jean Delvare wrote:
> On Wed, 19 Dec 2012 14:41:22 -0800, Guenter Roeck wrote:
> > On Wed, Dec 19, 2012 at 01:47:21PM -0800, Andrew Morton wrote:
> > > The changelog didn't describe the end-user visible effects of the bug.
> > > Please always include this information.  Because...
> >
> > One observed effect is that the s2c_hwmon driver reports a value of
> > 4198403 instead of 0 if the ADC reads 0.
> >
> > Other impact is unpredictable. Problem is seen if the divisor is an
> > unsigned variable or constant and the dividend is less than (divisor/2).
>
> Really? In my own testing, the problem only shows with dividend = 0,
> and even then, only when dividend is signed and divisor is not.
> DIV_ROUND_CLOSEST(5, 20U) returns 0 as expected, and so do
> DIV_ROUND_CLOSEST(0 / 20), DIV_ROUND_CLOSEST(0U / 20) and
> DIV_ROUND_CLOSEST(0U / 20U).
>
> Are your observations different?

I tried it with this simple user-land program to get an idea what's going 
wrong in the s3c_hwmon.c ADC driver:

#define DIV_ROUND_CLOSEST(x, divisor)(			\
{							\
	typeof(x) __x = x;				\
	typeof(divisor) __d = divisor;			\
	(((typeof(x))-1) > 0 || (__x) > 0) ?		\
		(((__x) + ((__d) / 2)) / (__d)) :	\
		(((__x) - ((__d) / 2)) / (__d));	\
}							\
)

int main(int argc, char *argv[])
{
	int x;
	unsigned y;

	printf("Constants\n");

	printf("-1 -> %d\n", DIV_ROUND_CLOSEST(-1, 2));
	printf("-1 -> %d\n", DIV_ROUND_CLOSEST(-1, 1023));
	printf("0 -> %d\n", DIV_ROUND_CLOSEST(0, 1023));
	printf("0 -> %d\n", DIV_ROUND_CLOSEST(0, 2));
	printf("1 -> %d\n", DIV_ROUND_CLOSEST(1, 2));
	printf("1 -> %d\n", DIV_ROUND_CLOSEST(3300, 1023));
	printf("2 -> %d\n", DIV_ROUND_CLOSEST(6600, 1023));

	printf("Variables\n");

	x = -1; y = 2;
	printf("-1 -> %d\n", DIV_ROUND_CLOSEST(x, y));
	x = -1; y = 1023;
	printf("-1 -> %d\n", DIV_ROUND_CLOSEST(x, y));
	x = 0; y = 1023;
	printf("0 -> %d\n", DIV_ROUND_CLOSEST(x, y));
	x = 3300; y = 1023;
	printf("3300 -> %d\n", DIV_ROUND_CLOSEST(3300, 1023));
	x = 6600; y = 1023;
	printf("6600 -> %d\n", DIV_ROUND_CLOSEST(6600, 1023));

	return 0;
}

Result is on my x86 host (same on my ARM target):

Constants
-1 -> -1
-1 -> 0
0 -> 0
0 -> 0
1 -> 1
1 -> 3
2 -> 6
Variables
-1 -> 2147483647
-1 -> 4198403
0 -> 4198403
3300 -> 3
6600 -> 6

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
