From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 24 Aug 2007 09:10:47 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] libsensors4: Drop SENSORS_MODE_NO_RW
Message-Id: <20070824111047.75a65c97@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070821212900.6d1fd920@hyperion.delvare>
In-Reply-To: <20070821212900.6d1fd920@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 22 Aug 2007 14:04:50 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Drop SENSORS_MODE_NO_RW and SENSORS_MODE_RW. The mode is a bitfield,
> > we typically set, or test for, a specific bit.
> 
> Looks good to me,

OK, thanks. All 4 patches committed now. I have 3 more waiting, I'll try
to put them in shape for submission later today.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
