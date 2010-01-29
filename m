From: "Juliano F. Ravasi" <jravasi@gmail.com>
Date: Fri, 29 Jan 2010 18:03:55 +0000
Subject: Re: [lm-sensors] Help with asus_atk0110 module
Message-Id: <4B63230B.6080108@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e01001290037o64afca82ra3ad2a5556ecb0e6@mail.gmail.com>
In-Reply-To: <68676e01001290037o64afca82ra3ad2a5556ecb0e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Luca Tettamanti wrote:
> Ok, you were bitten by this bug:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027633.html
>
> Fix is already present in Linus' tree, you can find the patch here:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027647.html
>   

Thanks! That worked!

But it looks like the module doesn't support PWM outputs... I couldn't
get much information from Google, and reading the source seems like it
only supports temp/volt/fan sensors. Is this correct? Is it planned to
support adjusting the PWM outputs in the future?

Best regards,

-- 
Juliano F. Ravasi ·· http://juliano.info/
5105 46CC B2B7 F0CD 5F47 E740 72CA 54F4 DF37 9E96

"A candle loses nothing by lighting another candle."
    -- Erin Majors



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
