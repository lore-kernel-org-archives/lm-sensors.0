From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Query on apparently 'disconnected' sysfs interfaces
Message-Id: <20050318052539.GA4767@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
In-Reply-To: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant:

* Grant Coady <grant_nospam@dodo.com.au> [2005-03-18 11:35:40 +1100]:

(...)

> Problem: There are many examples of disconnected code fragments 
> in the sysfs interface area.
> 
> Possibilities?  I'm missing an obscure indirection, cruft in code, 
> something else I've not yet thought of.  Also, I'm no preprocessor 
> expert, still picking up what the macros are doing from context. 

The preprocessor macros are the keys to understanding these drivers.

> Given (## = my thoughts) so few drivers are inconsistent, here's 
> one example:

That (## = my thoughts) is a little ironic, you will see...

(...)

> ## more attributes defined but not used?
> drivers/i2c/chips/lm83.c:static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
> drivers/i2c/chips/lm83.c:static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
> drivers/i2c/chips/lm83.c:static DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input3, NULL);
> drivers/i2c/chips/lm83.c:static DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input4, NULL);

E.g. with lm83, take a look at this part (to which I added two comments):

	#define show_temp(suffix, value) \
	static ssize_t show_temp_##suffix(struct device *dev, char *buf) \
	{ \
        	struct lm83_data *data = lm83_update_device(dev); \
        	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
	}
	show_temp(input1, temp_input[0]); /* defines show_temp_input1() */
	show_temp(input2, temp_input[1]); /* defines show_temp_input2() */
	/* ... */

Each show_temp() defines an entire (small) function.  The preprocessor
operator ## is used to tack the literal text "input1" onto "show_temp_"
to form a single token.  See page 90 of K&R/C.

> My problem at this point is seeing how the driver interfaces to 
> sysfs -- finding many exceptions to the 'norm', thus now it seems 
> I must find what the non-documented 'norm' actually is, before 
> bothering writing to an indeterminate (in my mind) interface.

Functions like the above show_temp_input1() are registered to sysfs and
are invoked whenever the sysfs file is read or written.  They are
registered by calling device_create_file().

> Is it worth documenting inconsistencies while I try to fathom 
> current practice vs documentation?

The existing documentation is a guideline for how to name the sysfs files;
it doesn't really specify how to code it.  In practice, the macro-fu just
reduces the line count for all those little functions.

> Are there tools written to perform this or similar checking?
> I'd really dislike re-inventing this stuff.  

I'm not sure what you mean here.  What checking?

> Another thing I tried was diff'ing -mm4 against -ac4, showed 
> where many obvious improvements have been made in -mm4 tree.
> Then I got side-tracked back into my current problem space, 
> sysfs interface seems not fully documented and/or me confused.  

Greg KH's i2c/sensors tree gets picked up by -mm long before those 
patches hit -ac.  I.e. what you saw is expected.

I hope this helps; regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
