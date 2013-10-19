From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 19 Oct 2013 08:24:40 +0000
Subject: Re: [lm-sensors] hwmon: (tmp401) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20131019082440.GL11731@mwanda>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131018142506.GA25585@longonot.mountain>
In-Reply-To: <20131018142506.GA25585@longonot.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 18, 2013 at 09:13:53AM -0700, Guenter Roeck wrote:
> Did you see this with smatch ? I am running smatch on the branch myself,
> but I don't recall seing the report, so I wonder.

I have a check that I haven't pushed where it complains if we check
IS_ERR() on something that's not an error pointer.  It has a lot of
false positives.

I should write a check where it complains if we check IS_ERR() after a
dereference.

regards,
dan carpenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
