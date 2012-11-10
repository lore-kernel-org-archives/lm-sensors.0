From: =?ISO-8859-1?Q?Lars_P=F6tter?= <lars@ing-poetter.de>
Date: Sat, 10 Nov 2012 13:57:50 +0000
Subject: Re: [lm-sensors] Configuration File for ASRock B75 Pro3
Message-Id: <509E5D5E.3030209@ing-poetter.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <509C1EBF.3000309@ing-poetter.de>
In-Reply-To: <509C1EBF.3000309@ing-poetter.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Run sensors -u, and you'll see the underlying attribute names. SYSTIN is
> probably temp1, CPUTIN is temp2, and AUXTIN is temp3. They are not special,
> but the driver provides a symbolic name, which is displayed by the sensors
> command. You have to use the raw name, not the symbolic name, in sensors.conf.
> 
> Hope this helps,

Yes that helped. Thank you very much. It now works !

So here is the working configuration file for the ASRock B75 Pro 3 Main
Board:

chip "nct6776-isa-0290"
    label in1 "+1.9V"
    ignore in4
    label in5 "+1.66V"
    ignore fan1
    label fan2 "CPU Fan"
    ignore fan3
    ignore fan4
    ignore fan5

    set in1_min  1.9 * 0.90
    set in1_max  1.9 * 1.10
    set in5_min  1.66 * 0.90
    set in5_max  1.66 * 1.10

    set fan2_min  900 * 0.90

    set temp1_max  50
    set temp1_max_hyst 30

So this could be added to the Wiki (I do not have write rights) perhaps
it would be good to add the information to use sensors -s and sensors -u
when creating new configuration files to the Wiki here:
http://lm-sensors.org/wiki/Configurations

Also the sensors -h warning on -u " Raw output (debugging only)" made me
not trying it. Perhaps "all underlying attribute names" would be a
better description.

Thanks again

Lars


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
