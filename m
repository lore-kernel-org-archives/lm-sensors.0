From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Parameter based conversions is an easy way for drivers to scale 
voltages with fixed point math.

I've written fixed point math routines in bash to prove the concept, 
but if driver scaling has been vetoed, I'd rather know now than 
submit something unwanted.  lm87 driver almost has it, carrying 
scaling factors in private memory, loaded at chip detect time.

Surveying the Winbond sensor chips, I came up with:

/*
 * Winbond inX internal scaling -- fullscale is 4096mV, Vref is 3600mV
 *
 * These sensor chips perform internal scaling for 5V (in3) and 5VSB
 * Using datasheet resistor values for traceability:
 *
 * 83781D, 83782D, 83783D, 83L784R      5V is 34/50
 * 83726F, 83726HF, 83697HF             5V is 34/50, 5VSB is 17/33
 * 83627THF, 83637HF                    5V is 34/51, 5VSB is 34/51
 */
static const u8 r1[] = {0, 0, 0, 34, 0, 0, 0, 17, 0};
static const u8 r2[] = {1, 1, 1, 50, 1, 1, 1, 33, 1};

static inline unsigned long IN_FROM_REG(u8 reg, int n)
{
        return SCALE(reg, 4096 * (r1[n] + r2[n]), 256 * r2[n]);
}

static inline u8 IN_TO_REG(unsigned long val, int n)
{
        return SENSORS_LIMIT(SCALE(val, 256 * r2[n],
                                4096 * (r1[n] + r2[n])), 0, 255);
}

Of course a 'real' driver would have the table in private memory and 
load appropriate values on chip detect, lm87 does this, worth doing 
for Winbond?

There is not much more to making some of the values preset to chip 
standard values for +12 and negative, and making those external to 
sensor chip values settable from user-space.

Comments?  

--Grant.
