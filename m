From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Mar 2012 17:47:41 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (w83627ehf) Fix writing into fan_stop_time for NCT6775F/NCT6776F
Message-Id: <20120312184741.5123efff@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331567005-13734-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331567005-13734-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 Mar 2012 10:35:02 -0700, Guenter Roeck wrote:
> On Mon, 2012-03-12 at 13:23 -0400, Jean Delvare wrote:
> > As a side note, someone's got to explain to me why these functions are
> > macro-generated when the macro is called only once. It would be a good
> > idea to unfold that code to make it easier to read.
> > 
> I don't know. Historic, maybe ?

Certainly. Probably the driver originally had more attributes but they
did not make it upstream.

> I thought about unfolding it, but
> concluded that it would not be appropriate to do that for a bug fix.

I agree, that would be a separate patch. If you have time and
interest... (I lack the former.)

> I don't like those macro functions anyway ...

Nobody does. They were needed before the introduction of struct
sensor_device_attribute, what, 7 years ago? We should no longer see
anything like that in our drivers these days, but...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
