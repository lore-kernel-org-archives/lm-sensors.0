From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 17 Mar 2015 03:55:35 +0000
Subject: Re: [lm-sensors] [PATCH 26/35 linux-next] hwmon: constify of_device_id array
Message-Id: <5507A5B7.5020704@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426535685-25996-1-git-send-email-fabf@skynet.be> <1426535685-25996-5-git-send-email-fabf@skynet.be>
In-Reply-To: <1426535685-25996-5-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org

On 03/16/2015 12:54 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---

Applied to hwmon-next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
