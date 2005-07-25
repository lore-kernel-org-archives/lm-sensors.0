From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 25 Jul 2005 13:44:53 +0000
Subject: [lm-sensors] Fancontrol
Message-Id: <42E4D09F.7060000@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Henry wrote:

>Hi I'm using Lm sensors and fancontrol
>I have not found a way to set constant CPU fan speed.
>
>every time when the outside temperature drops the cpu fan stops then
>starts and then stops.
>this is very annoying I have to change the settings in
>the /etc/fancontrol file when the weather changes
>
>  
>
many fan-controller circuits are PWM, pulse width modulated.
these usually give a power knob with 256 steps, from 0 to full power.
Since you seem to not know whats on your board, guessing would be pointless.

have you tried compiling *all* the sensor modules, and seeing which ones 
are sensors-detect'd ?
