From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Oct 2007 14:22:50 +0000
Subject: Re: [lm-sensors] Intel DP35DP - P35 Sensor Support?
Message-Id: <20071030152250.4d7a09b0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071015T022008-788@post.gmane.org>
In-Reply-To: <loom.20071015T022008-788@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please do not send HTML mails to this mailing list. This makes your
post very large for no benefit.

On Sun, 28 Oct 2007 08:58:48 -0700, d. d. gmane wrote:
> Correction...here's the proper sensors detection using 3.0.0rc3:

In fact, both branches of lm-sensors have the same version of
sensors-detect.

> (...)
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   Yes
> Found `Nat. Semi. PC8374L Super IO Sensors'                
>     (but not activated)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No

It it possible, though unlikely, that the PC8374L sensors are used. I
say "unlikely" because sensors should be activated if they were used.
But we can still investigate this. Please provide the output of:

isadump 0x2e 0x2f 0x08

The other possibility is that the ICH9 internal sensors are used, but
we do not support them yet. Well we do not support the PC8374L sensors
either...

The DP35DP technical documentation suggests that the ICH9 is used for
the fan speed control and monitoring. It's not so clear about
temperature and voltage sensors, however it claims automatic fan speed
control, which usually means that the fan and temperature sensors are
in the same chip. So my guess is that the only thing that may actually
be monitored by the PC8374L on your board are the voltages.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
