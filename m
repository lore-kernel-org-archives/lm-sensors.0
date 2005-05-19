From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Query on apparently 'disconnected' sysfs interfaces
Message-Id: <ulam31pub1dplqrjt149rc84hh5tfuv2bo@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
In-Reply-To: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Mar 2005 00:25:39 -0500, "Mark M. Hoffman" <mhoffman@lightlink.com> wrote:
. . .
>Each show_temp() defines an entire (small) function.  The preprocessor
>operator ## is used to tack the literal text "input1" onto "show_temp_"
>to form a single token.  See page 90 of K&R/C.

So I gotta go find a copy of a book I chucked >20 years ago?  :o)
>
>> Are there tools written to perform this or similar checking?
>> I'd really dislike re-inventing this stuff.  
>
>I'm not sure what you mean here.  What checking?

These items do not appear in doc/i2c/sysfs-interface, yet to 
check source context, ad hoc grep & cut in drivers/i2c/chips:

alarm_mask	< beep_mask?  I'd like to have alarm_mask
alarms_in
alarms_temp
analog_out
aout_output	< analog_out ?
die_code
fan1_auto
gpio
gpio_mask
in1_ref
out0_enable
out0_output
temp1_crit_enable
temp1_hyst
temp1_min_hyst
vid		< cpu0_vid?

At this point in time I'm quite happy to document and cross-reference 
current practice, but I don't want to duplicate a work-in-progress.

Whether this is useful to the group I don't know, but I'll chase 
documentation in preference to ad hoc coding, or blindly copy-paste 
what might work -- too much of that has happened already.

>I hope this helps; regards,
yes, it does, thank you.

Cheers,
Grant.
