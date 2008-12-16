From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Dec 2008 16:48:26 +0000
Subject: Re: [lm-sensors] PATCH: f71882fg: fix fan_to/from_reg prototypes
Message-Id: <20081216174826.424632d5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4947D4D0.3020405@redhat.com>
In-Reply-To: <4947D4D0.3020405@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Dec 2008 17:18:24 +0100, Hans de Goede wrote:
> Hi Jean,
> 
> The RPM after conversion from / before conversion to a register value can be
> much more then 65535 (up to 1500000), so putting this into an u16 can cause
> overflows. This changes the functions to use an int to store / get RPM instead.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
