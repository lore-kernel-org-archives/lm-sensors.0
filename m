From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 May 2008 18:00:00 +0000
Subject: Re: [lm-sensors] LM75 re-work,
Message-Id: <20080527200000.246e41d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080527155308.GZ22585@trinity.fluff.org>
In-Reply-To: <20080527155308.GZ22585@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Tue, 27 May 2008 16:53:08 +0100, Ben Dooks wrote:
> Is there a patch, or set of patches for the lm75 driver to
> use the new i2c framework available in one bundle? I've had a
> look over the list and was wondering if someone had gathered
> together all the submissions?

There are 3 patches which are ready to go upstream at this point:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022931.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023040.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023041.html

Apply them in this order. In case the list archive corrupted the patches
somehow, you can fetch them temporarily from my home server at:
http://jdelvare.pck.nerim.net/sensors/lm75/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
