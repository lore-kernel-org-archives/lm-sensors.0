From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 25 Mar 2014 15:20:58 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (it87) Add support for IT8623E
Message-Id: <20140325162058.2d58e01e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1354475868-10032-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1354475868-10032-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf, Martin,

On Tue, 25 Mar 2014 15:59:23 +0100, Rudolf Marek wrote:
> Hi all,
> 
> That was fast :) thank you all.

Well, thank _you_ for the patch :)

> Martin, most likely you can try following 
> sensors.conf config.
> 
> chip "it8603-*"
>      label temp1 "CPU Temp"
>      label temp2 "M/B Temp"

I would add:

     ignore temp3

as this input doesn't seem to be connected.

> 
>      label in0 "Vcore"
>      label in1 "in1"

Not very useful ^^

>      label in2 "+12V"
>      label in3 "+5V"
>      label fan1 "CPU Fan"
>      label fan2 "CHA Fan"
>      label fan3 "PWR Fan"

There doesn't seem to be a fan3 on Martin's system, so he should omit
that line.

> 
>      compute in2  @ * (12/2), @ / (12/2)
>      compute in3  @ * (25/10), @ / (25/10)
> 
> Then in2 and in3 could be same on your board, because they are wired to in2/in3 
> on it8603 to support the under/overvoltage protection.

If that doesn't work, Martin could always comment out the compute
statements and follow my guide at:
http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling

I would also suggest adding the following set statements to get rid of
most of the ALARMs:

   set in0_min   0.800  # Should be adjusted depending on CPU model
   set in0_max   1.200  # Should be adjusted depending on CPU model
   set in2_min  12 * 0.95
   set in2_max  12 * 1.05
   set in3_min   5 * 0.95
   set in3_max   5 * 1.05
   set in7_min 3.0 * 0.95
   set in7_max 3.3 * 1.05

   set temp1_min  5
   set temp1_max 60
   set temp2_min  5
   set temp2_max 60

(Don't forget to run "sensors -s" afterward.)

-- 
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
