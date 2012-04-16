From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Apr 2012 12:43:19 +0000
Subject: Re: [lm-sensors] Need support IBM x3650
Message-Id: <20120416144319.574e2b39@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F8C109C.3070604@gmail.com>
In-Reply-To: <4F8C109C.3070604@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 Apr 2012 19:29:16 +0700, Quang Minh wrote:
> Hi all,
> 
> I have a server IBM x3650 run CentOS. I want check temperature of server.
> I tried install lm_sensor, run sensors-detect then got error
>          Sorry, no sensors were detected.
>          Either your sensors are not supported, or they are connected to an
>          I2C or SMBus adapter that is not supported. See doc/FAQ,
>          doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
>          (FAQ #4.24.3) for further information.
>          If you find out what chips are on your board, check
>          http://www.lm-sensors.org/wiki/Devices for driver status.
> 
> Can you help me?

Not if you don't provide additional information:
* Which kernel are you running?
* Which version of lm-sensors?

Please also provide the full output of sensors-detect.

That being said, on high end servers monitoring is frequently done by
IPMI, which lm-sensors doesn't support, so the is a chance that
lm-sensors just won't work on this machine.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
