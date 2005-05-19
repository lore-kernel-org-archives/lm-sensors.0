From: goofee79@hotmail.com (tom paris)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Ticket 1671
Message-Id: <BAY18-F91CN6s1hC7Up0000d77f@hotmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY18-F35Ejb0zNqBRH0000e079@hotmail.com>
In-Reply-To: <BAY18-F35Ejb0zNqBRH0000e079@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Ahh crap!

Installed 2.8.6 and can confirm it works now.

Technically it's SuSE's fault, uname -a gives me:
Linux scrooge 2.6.4-52-default #1 Wed Apr 7 02:08:30 UTC 2004 i686 athlon
i386 GNU/Linux

But i didn't know this was 2.6.5rc1 or higher. :)

Thank you for your help!

Regards,
Goofee

>From: Jean Delvare <khali@linux-fr.org>
>Reply-To: sensors@stimpy.netroedge.com
>To: "tom paris" <goofee79@hotmail.com>
>CC: sensors@Stimpy.netroedge.com
>Subject: Re: Ticket 1671
>Date: Sat, 8 May 2004 20:31:16 +0200
>
> > Ok, here goes:
> >
> > 1-002d:
> > alarms           fan3_div    in2_input  in5_max         temp2_input
> > detach_state     fan3_input  in2_max    in5_min         temp2_max
> > fan1_div         fan3_min    in2_min    in6_input       temp2_max_hyst
> > fan1_input       in0_input   in3_input  in6_max         temp3_input
> > fan1_min         in0_max     in3_max    in6_min         temp3_max
> > fan1_pwm         in0_min     in3_min    name            temp3_max_hyst
> > fan1_pwm_enable  in0_ref     in4_input  power           temp4_input
> > fan2_div         in1_input   in4_max    temp1_input     temp4_max
> > fan2_input       in1_max     in4_min    temp1_max       temp4_max_hyst
> > fan2_min         in1_min     in5_input  temp1_max_hyst  vrm
>
>OK, you have been lying to us. This is not Linux 2.6.4. These files
>follow the new naming scheme, which was introduced with Linux 2.6.5-rc1.
>
>Anyway, just go with lm_sensors 2.8.6 then and it should work fine.
>
>--
>Jean Delvare
>http://khali.linux-fr.org/

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE*=20
http://join.msn.com/?page=FEatures/junkmail
