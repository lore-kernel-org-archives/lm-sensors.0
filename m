From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH] updated it87 for kernel 2.6
Message-Id: <1076935183.4030ba0fe5cfc@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040216210601.6dae0bf7.komoriya@paken.org>
In-Reply-To: <20040216210601.6dae0bf7.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me]

Quoting Takeru KOMORIYA <komoriya@paken.org>:

> I found it87 in kernel 2.6 may be based on old module.
> It lacks reset_it87 option and smart guardian (sg) features in
> lm_sensors cvs.
> 
> So I tryed to add these features and made the patch for
> linux-2.6.2-rc2. It works well for me.
> 
> If you think the attached patch is useful, please merge it in.

I like the idea of porting 2.4 changes to 2.6, but your patch is not
correct. In 2.6, we decided that each sysfs file would hold a single
value. I agree that this is a bit different here since the "smart
guardian" feature is specific to the IT87 chips. Still I don't think
that Greg KH will accept such a patch.

What do the three values in sgpwm and the five values in sgtl mean? We
would have to find that many filenames.

How different is the "smart guardian" pwm from the standard pwm?

I also think it would be easier for us if you could split your big patch
in parts. It looks like you do four different, independant things
here:
* change the sensor type selection method
* add it87_reset (which btw I would more simply call "reset")
* add pwm support
* add smart guardian support

Submitting these as separate patches, one at a time, will make it much
easier for us to ensure that your code is correct and that we can
safely include it in the Linux 2.6 kernel.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
