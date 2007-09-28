From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 28 Sep 2007 19:42:40 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 1/3] lm75: cleanups (no
Message-Id: <20070928214240.66309beb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925051533.38DF9239408@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925051533.38DF9239408@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 27 Sep 2007 13:37:09 -0700, David Brownell wrote:
> (...)  And I don't much like the
> idea of paying for such stuff with an ever-increasing data
> footprint, which is how the I2C_CLIENT_INSMOD_*() macros do
> such stuff.

I don't like these macros either. My plan was to replace them with a
per-driver sysfs file that would let users instantiate I2C devices from
user-space. Unfortunately I couldn't find the time to actually
implement the idea in the past few months.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
