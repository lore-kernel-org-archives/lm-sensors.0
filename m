From: "David Mathog" <mathog@caltech.edu>
Date: Thu, 21 Oct 2010 18:05:39 +0000
Subject: Re: [lm-sensors] Tyan S2466 and lm_sensors 3
Message-Id: <E1P8zWF-0000n3-8T@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1P8fJt-000075-89@mendel.bio.caltech.edu>
In-Reply-To: <E1P8fJt-000075-89@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Did you run "sensors -s"?
> 
> Do you have any "set fan#_div" statement in this chip section? If you
> do, it is important that these come before the "set fan#_min"
> statements.
> 

Set up the fan related lines in the two sensors3.conf blocks like this:

chip "w83782d-*"
    label   fan1 "Ch Fan 1"
    label   fan2 "Ch Fan 2"
    label   fan3 "Ch Fan 3"
    set fan1_div 4
    set fan2_div 4
    set fan3_div 4
    set fan1_min 3000
    set fan2_min 3000
    set fan3_min 3000
chip "w83627hf-*"
    label   fan1 "CPU1 Fan"
    label   fan2 "CPU0 Fan"
    ignore  fan3 
    compute fan1 2*@,@/2
    compute fan2 2*@,@/2
    set fan1_div 4
    set fan2_div 4
    set fan1_min 3000
    set fan2_min 3000

% sensors -s
% sensors | grep RPM
CPU1 Fan:      0 RPM  (min = 3000 RPM, div = 4)  ALARM
CPU0 Fan:   6552 RPM  (min = 3000 RPM, div = 4)
Ch Fan 1:      0 RPM  (min = 2986 RPM, div = 4)  ALARM
Ch Fan 2:   4500 RPM  (min = 2986 RPM, div = 4)
Ch Fan 3:   4383 RPM  (min = 2986 RPM, div = 4)

which is fine.

Tried different dividers (2,4,8,16) and the values moved around a
little, but these were always within a few percent of 3000, so
arbitrarily used a divisor of 4 everywhere.

Thanks for your help,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
