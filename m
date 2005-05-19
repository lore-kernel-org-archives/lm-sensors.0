From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: flex scanner jammed problem
Message-Id: <20030923211403.04761487.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I just installed lm_sensors via synaptic.

What is synaptic?

> I could set up my sensors.
> But since I did that the KDE process window does not work any more,
> ksysguardd and ksensors gave me "flex scanner jammed".

Which means that sensors itself doesn't work. Am I right?

This is a known problem, which has two possible solutions:

1* Fix your /etc/sensors.conf file. Copy the default etc/sensors.conf.eg
file that match the version you're using, and it should be OK.

2* If it doesn't work, update to 2.8.0 or CVS, we fixed a bug in the
parser some weeks ago.


> And I got another question! is there plan in lm_sensors to support
> writing to fan values, too? the w83627hf chip I have supports that.

"Writing to fan values" makes no sense ;) You already should be able to
write to the min settings. As for the speed control, it is known as PWM.
It *is* supported by our w83781d and w83627hf drivers (one of which you
must be using), although it is known not to work properly for everyone.
See the prog/pwm in our package, where you'll find the fancontrol and
pwmprogram. These are the ones you need in order to have PWM working.
Give it a try and let us know how it works for you.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
