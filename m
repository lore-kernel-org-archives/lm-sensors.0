From: Logan Freijo <loganfreijo@embarqmail.com>
Date: Sun, 04 Nov 2012 02:02:44 +0000
Subject: Re: [lm-sensors] f71882fg not showing motherboard temps
Message-Id: <5095CCC4.5080301@embarqmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5091A80D.3090101@embarqmail.com>
In-Reply-To: <5091A80D.3090101@embarqmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/3/2012 11:43 AM, Hans de Goede wrote:
> Hi,
>
>
> Now a days not really, since there is little ISA stuff left in a 
> modern PC, and what
> is there usually is detected fine without isapnp too, since it has 
> been at the
> same isa address since the beginning of time (ie serial ports, if 
> you're lucky enough
> to have a serial port on your motherboard). However if in the future 
> you think:
> "hey why is Linux not seeing my foobar hardware" where by foobar is 
> something
> ancient like say a floppy controller, try removing the option. Note 
> this is all
> AFAIK, this is veering away a bit from my area of expertise (which is 
> certain hwmon
> chips and usb).
>
> > Is it possible there is a CMOS option that will disable the BIOS use 
> of this resource?
>
> Not likely.
>
> Regards,
>
> Hans
>

Ok. I won't worry about it then. The wiki says that custom 
configurations should be sent to the mailing list. Below is the 
configuration I have that seems to work. Hopefully this will help 
someone else.

Thanks,

Logan



chip "f71882fg-*"

### Voltages

    #Not sure about in2. Reading changes with change to NB voltage
    #and Vcore voltage

    label  in1   "Vcore"
    label  in2   "NBcore"
    label  in3   "+5V"
    label  in4   "+12V"
    label  in5   "5VSB"
    label  in6   "VDIMM"

    compute  in2  @ * (16/8), @ / (16/8)
    compute  in3  @ * (42/8), @ / (42/8)
    compute  in4  @ * (88/8), @ / (88/8)
    compute  in5  @ * (42/8), @ / (42/8)
    compute  in6  @ * (16/8), @ / (16/8)

    set in1_min   0.7
    set in1_max   1.5
    set in2_min   1.2 * 0.95
    set in2_max   1.2 * 1.05
    set in3_min   5   * 0.95
    set in3_max   5   * 1.05
    set in4_min   12  * 0.95
    set in4_max   12  * 1.05
    set in5_min   5   * 0.95
    set in5_max   5   * 1.95
    set in6_min   1.5 * 0.95
    set in6_max   1.5 * 1.95


###Temps


    label  temp1   "CPU Temp"
    label  temp2   "SYS Temp1"
    label  temp3   "SYS Temp2"



###Fans

    #Fan4 doesn't exist on this motherboard
    ignore fan4

    label fan1   "CPU Fan"
    label fan2   "SYS Fan1"
    label fan3   "SYS Fan2"

    set fan1_min   500
    set fan2_min   500
    set fan3_min   500


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
