From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 21 May 2005 19:26:48 +0000
Subject: [lm-sensors] Re: lm_sensors
Message-Id: <20050521192611.0c6874ab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dave,

Sorry for the delay...

> I have a question please...
> 
> I run lm_sensor on my machines and some do not seem to be changing
> ever, even with a significant change in room temperature.  If I
> perform a reboot, the temperature does change and to what I believe is
> a more accurate (believable) temperature.  I am beginning to think my
> temperature sensor readings are not updating.  Is there a way to
> update, restart, stop/start the sensors software information providing
> the data?

I think this problem isn't unheard of, but I don't think we ever found
what the problem was. Nevertheless, can you tell us:
* the version of the Linux kernel you use,
* the version of lm_sensors you use,
* which hardware and driver you are having the problem with?

Thanks,

-- 
Jean Delvare
