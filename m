From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Nov 2010 09:48:50 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101129104850.63cb9ebf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 29 Nov 2010 03:41:35 -0600 (CST), Jeff Rickman wrote:
> Hi Juerg,
> > I don't understand. Does fan1 change as a result of your running the
> > fancontrol script? The SCH5127 has a built in fan controller so you
> > shouldn't need to run any external scripts. The chip should
> > automatically take care of adjusting the fan speed based on the temp.
> > Can you please send the output of the following command:
> >
> > grep "" /sys/class/hwmon/hwmon*/*
> 
> No output from your command in my SSH session, but there is symbolically
> linked 'content' in that file structure.

Juerg certainly meant instead:

grep "" /sys/class/hwmon/hwmon*/device/*

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
