From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Mar 2006 21:14:23 +0000
Subject: [lm-sensors] [PATCH] Add fan control support to W83627EHF
Message-Id: <440B54AF.1000205@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409FFA1.7050109@sh.cvut.cz>
In-Reply-To: <4409FFA1.7050109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> So add 1?
>              * 0 Disabled (set PWM to 255)
>              * 1 Manual mode
>              * 2 Thermal Cruise
>              * 3 Fan Speed Cruise
>              * 4 Smart FAN III

Yes like this plus extra fanX_target and fanX_tolerance + the logic to preserve the tempX_target and tempX_tolerance.

> I'll put together a quick patch and send that back to you tomorrow.

No need to hurry, I must fix the voltages for Jean tomorrow ;)

Regards
Rudolf

