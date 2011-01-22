From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 22 Jan 2011 20:46:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Override interface
Message-Id: <20110122204652.GA22384@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1295708831-10623-1-git-send-email-kronos.it@gmail.com>
In-Reply-To: <1295708831-10623-1-git-send-email-kronos.it@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 22, 2011 at 10:07:11AM -0500, Luca Tettamanti wrote:
> ASUS Sabertooth X58 has a bug in ACPI that prevents the reading of MCH
> temperature when the "old" ATK0110 interface is used. Add a DMI entry
> to override the detection heuristic and force the use of the "new"
> interface on this board.
> 
> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> Tested-by: Joris Creyghton <jorisctn@gmail.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
