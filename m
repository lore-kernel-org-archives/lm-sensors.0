From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 04 Nov 2014 21:23:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon, fam15h_power: Fix NB device ID for F16h M30h
Message-Id: <20141104212347.GA14379@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1415123342-11368-1-git-send-email-aravind.gopalakrishnan@amd.com>
In-Reply-To: <1415123342-11368-1-git-send-email-aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Cc: herrmann.der.user@googlemail.com, jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, Nov 04, 2014 at 11:49:02AM -0600, Aravind Gopalakrishnan wrote:
> F3 device ID is wrongly included in fam15h_power_id_table
> for F16h M30h. It should be F4 device ID. Fix this.
> 
> Signed-off-by: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
