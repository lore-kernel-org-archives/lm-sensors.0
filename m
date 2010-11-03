From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Nov 2010 13:49:55 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (adm9240) Implement the
Message-Id: <20101103144955.522c6177@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101102174042.1d548a0c@endymion.delvare>
In-Reply-To: <20101102174042.1d548a0c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 3 Nov 2010 06:31:45 -0700, Guenter Roeck wrote:
> Since you are at it, would it make sense to make that change
> in the w83795 driver as well (ie set data->valid to 0) ?

Yes, it would, thanks for raising this point.

I have more work pending on the w83795 driver anyway, so fixing this
won't cost me anything.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
