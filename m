From: <samu.p.onkalo@nokia.com>
Date: Mon, 25 Oct 2010 06:10:01 +0000
Subject: Re: [lm-sensors] [PATCH 00/12] lis3 accelerator feature update
Message-Id: <62697B07E9803846BC582181BD6FB6B836EAE847F1@NOK-EUMSG-02.mgdnok.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
 <4CC44B3D.5030404@tremplin-utc.net>
In-Reply-To: <4CC44B3D.5030404@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: eric.piel@tremplin-utc.net, jic23@cam.ac.uk
Cc: khali@linux-fr.org, guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-i2c-owner@vger.kernel.org [mailto:linux-i2c-
>owner@vger.kernel.org] On Behalf Of ext =C3=89ric Piel
>
>Op 22-10-10 13:57, Samu Onkalo schreef:
>> Changes are tested only with I2C interface using 8bit sensor since I
>don't
>> have other possibilities. Some features are not enabled
>> by default since I can't test them with all possible configurations.
>> Platform data contains field which controls new features.
>Thanks Samu for persevering with the automatic power down feature.
>Hopefully I'll find also some time to activate it on the hp_accel side.
>
>For now, I've reviewed the changes and everything looked fine, as well
>as tested them on my HP laptop (with a 12 bits sensor). Although most of
>the changes are not visible on this platform, at least there shouldn't
>be any regression.
>

Thanks for the review.

-Samu
=20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
