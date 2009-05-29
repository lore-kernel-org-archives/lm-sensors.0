From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 May 2009 15:58:19 +0000
Subject: Re: [lm-sensors] PATCH [2/4]: hwmon: f71882fg sanity check f8000
Message-Id: <20090529175819.4aa4fec4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A1FA578.4010801@redhat.com>
In-Reply-To: <4A1FA578.4010801@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 May 2009 11:06:00 +0200, Hans de Goede wrote:
> We depend up on the pwm_enable register (0x96) not containing any reserved
> settings in various places. We were already checking to make sure there
> were no reserved settings in the register for the f71862fg, this patch adds
> the same checking for the f8000, while at it it also moves the code to
> a more apropriate place so we don't need to check if the fan/pwm part
> of the IC is enabled twice.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks good, applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
