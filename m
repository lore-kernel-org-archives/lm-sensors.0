From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jun 2008 11:45:46 +0000
Subject: Re: [lm-sensors] Future plans for sensors-detect
Message-Id: <20080608134546.0981d8ae@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080521114013.074cde02@hyperion.delvare>
In-Reply-To: <20080521114013.074cde02@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 May 2008 12:06:10 +0200, Jean Delvare wrote:
> We already ship a default sensors.conf file which includes arbitrary
> labels for many chips, which may or may not match the user's
> motherboard. This is IMHO plain wrong, I agree with you that
> unconfigured sensors are better than misconfigured sensors. I believe
> that we should strip down sensors.conf.eg to only include labels which
> we know are always correct (e.g. internal voltage labels.) This would
> also make libsensors initialization much faster - for now we waste
> users' time reading long configuration sections for chips they don't
> even have.

I don't have the time to work on this right now, but have created
ticket #2333 so that we don't forget about it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
