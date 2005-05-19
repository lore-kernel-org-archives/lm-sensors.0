From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: RFC scaling/constraining user-space input
Message-Id: <lllk31p1cgiaao96a5vn16edoda4tkmt19@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Result of my survey of chip drivers, cherrypicking for 'best 
practice'.  To clarify this stuff I read in code.  Perhaps 
others been here too?  A newcomer's view of the lm_sensors 
stuff.  Perhaps this has all been done before too.  I'm 
simply looking for sane looking interface components.  

Comments welcome.  

Rounding and Scaling
--------------------
unipolar:
return (val + scale/2) / scale;

bipolar (also is general case):
return val < 0 ? (val - scale/2) / scale : (val + scale/2) / scale;

Constraining user_space input
-----------------------------
static inline u8 IN_TO_REG(long val, int scale)
{
	/* assume scale > 0 */
	if (val <= 0)
		return 0;
	return SENSORS_LIMIT((val + scale/2) / scale, 0, 255);
}

static inline s8 TEMP_TO_REG(int val, scale)
{
	/* assume scale > 0 */
	return SENSORS_LIMIT(val < 0 ? 
			(val - scale/2) / scale : 
			(val + scale/2) / scale, -128, 127);
}

static inline u8 FAN_TO_REG(long rpm, int div)
{
	/* assume gated 22.5kHz counter with div in 1, 2, 4, 8... */

	if (rpm <= 0)
		return 255;
	return SENSORS_LIMIT(
		(1350000 + rpm * div / 2) / (rpm * div), 1, 254);
}

Two main ideas for constraining fan divisor, the easy way silently 
defaults to something:

static inline u8 DIV_TO_REG(int val)
{
	return val = 8 ? 3 : val = 4 ? 2 : val = 1 ? 0 : 1;
}

from adm1026:
#define DIV_TO_REG(val) ((val) >= 8 ? 3 : (val) >= 4 ? 2 : (val) >= 2 ? 1 : 0)

or round to nearest (mine?):
#define DIV_TO_REG(val) ((val) <= 1 ? 0 : (val) = 2 ? 1 : (val) >= 6 ? 3 : 2)

Yet another method seeks to special case fan setting and return 
an error:

	/* supported values: 2, 4, 8 */
	unsigned long v = simple_strtoul(buf, NULL, 10);
	switch (v) {
	case 2: v = 1; break;
	case 4: v = 2; break;
	case 8: v = 3; break;
	default:
		dev_err(&client->dev, "fan_ripple value %ld not supported. "
					"Must be one of 2, 4 or 8!\n", v);
		return -EINVAL;
	}

Overkill?  Apart from the use of a confusing term 'ripple' for 
divisor, why special case fan divisor to return errors?  This 
method also disables the neat feature of discovering limits by 
trying something way out of range and seeing result.

Coupled with setting fan divisor, why take special action to 
adjust fan speed limit when divisor change?  Why not simply 
tell user-space to set divisor prior to changing fan speed 
limit?

Then we get to the odd VID reporting, too late, I suppose, to 
simply present VID sense value to user-space and let them do 
whatever interpretation suits?  But we seem stuck with it.

Thinking out aloud, and I am still to nail the sysfs callbacks, 
next todo...  

Cheers,
Grant.
