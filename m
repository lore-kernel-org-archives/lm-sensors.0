From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Jan 2009 09:56:51 +0000
Subject: Re: [lm-sensors] Updated fancontrol script
Message-Id: <20090127105651.55477b84@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090102221548.GA19021@paradise.net.nz>
In-Reply-To: <20090102221548.GA19021@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Volker,

On Sat, 03 Jan 2009 11:15:48 +1300, Volker Kuhlmann wrote:
> I have updated my improved/extended fancontrol script with the changes
> from 0.63 to 0.67 of the "official" script. It's backwards compatible.

Someday we should get rid of these version numbers. Referring to the
version of the lm-sensors package is much easier IMHO.

> http://volker.top.geek.nz/linux/tech/lm_sensors/fancontrol-1.1
> 
> Major changes: temperature hysteresis for fan speed, using bash string
> functions instead of external programs, changed some ugly programming.
> For minor changes see changelog.
> 
> Feel free to make this the official script... ;)

If you want us to take anything from you, please send patches against
our latest version of fancontrol. Preferably incremental ones.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
