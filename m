From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: i2c-voodoo3 bug fix
Message-Id: <20041121111213.37f3138f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1100995535.27226.29.camel@localhost>
In-Reply-To: <1100995535.27226.29.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nat,

This is really a bt869 bug fix, not i2c-voodoo3, isn't it?

> I noticed that the first time the resolution is changed after bootup,
> the changes do not take effect. This is because the
> bt869_update_client function gets called twice, almost consecutively
> (which means on the second time it doesnt run{because of the jiffies
> check}), another variable, "update_required", has been added to allow
> the force-running of it (as a test for this has been added to the IF
> at the start)

While I agree with the problem, I do not agree with the fix. The bt869
driver is badly written in that the bt869_update_client function does
two separated things:
1* reprogram the BT869 chip;
2* get the BT869 status info.

Only that second part really belong to the function if it were to follow
the model of the other drivers. The chip reprogramming should be moved
to a different function. Each function should be called only when
needed. I think it would be a much nicer solution than what you propose.
This also would make the driver much more efficient. The fact that the
driver will reprogram the chip entirely each time one *asks* for status
is a sever design flaw.

Note that I don't own a BT869-enabled board myself so I cannot modify or
test anything, I am just commenting on the driver design.

As a side note, bt869_read_value has an unused parameter which we should
get rid of as well.

Care to provide a patch that properly fix the driver design?

> please find attached patched code

Please send patches instead, not modified files. We cannot easily review
modified files.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
