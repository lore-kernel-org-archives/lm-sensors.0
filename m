From: Juerg Haefliger <juergh@gmail.com>
Date: Mon, 29 Nov 2010 08:05:05 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <AANLkTimdSsVqhQuASug+icaKUDcbbNzfX=5oty=hA_Fr@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

Thanks for the detailed feedback.


> Experiences so far:
>
> (1) "fancontrol" script does work, but I would like it to run as a
> "background" process or even as a daemon. I'm not a programmer so I don't
> know if this is even possible or how to do it.
>
> (2) Fan speed on "Fan1" does go up and down with system temperatures.

I don't understand. Does fan1 change as a result of your running the
fancontrol script? The SCH5127 has a built in fan controller so you
shouldn't need to run any external scripts. The chip should
automatically take care of adjusting the fan speed based on the temp.
Can you please send the output of the following command:

grep "" /sys/class/hwmon/hwmon*/*

Thanks
...Juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
