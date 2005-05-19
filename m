From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: w83781d and alarms for temp2 and temp3
Message-Id: <20040506193424.34a32085.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040501224829.GA13732@pc.aurel32.lan>
In-Reply-To: <20040501224829.GA13732@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please find attached two patches to fix that, one concerning sensors
> and the other one concerning sensord.
> 
> The patch for sensors is almost the same as the previous one, but now
> the code would compile!
> 
> The patch for sensord looks like a little bit long. That's because the
> code was shared between w83781d and as99127f chips. With this patch,
> the two chips are handled separatly

About the sensors patch: fix is correct, but indentation isn't. I'll
take care of that though, no need to resend.

About the sensord patch: I don't like it. You do not need to define
separate constants for the AS99127F in lib/chips.h. We can do without
them. Just use the SENSORS_W83781D defines in the as99127f_features
array (much like w83697hf_features uses the SENSORS_W83782D defines).

Care to provide a new patch?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
