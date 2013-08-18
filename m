From: Nils Hammar <nils.hammar@abc.se>
Date: Sun, 18 Aug 2013 19:21:33 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P85-D3 motherboard config.
Message-Id: <52111EBD.5040700@abc.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I apologize - I did introduce a typo, it's the P85, not P58. :-[


On 2013-08-18 17:55, Nils Hammar wrote:
> I have made a best effort to create a configuration file for the 
> Gigabyte GA-P85-D3 motherboard. I can't guarantee that it's entirely 
> correct since it is created through trial&error. I provide it in hope 
> that it is useful for someone else.
>
> Below is the file content:
> ---
> #
> # Configuration for the Gigabyte GA-P85-D3 motherboard.
> #
> # Driver 'it87' at it8728-isa-0a30.
> #
> # This motherboard is for the fourth generation Intel Core processors
> # with Socket 1150. One important difference is that those processors
> # has internal voltage regulation, which means that some voltages
> # that were present on earlier motherboards are no longer there.
> # One such example is the Vtt voltage.
> #
> #
> chip "it8728-*"
>
>     #######################################
>     # FANS                                #
>     # The actual number of fans and their #
>     # RPM limits depends on what the      #
>     # computer case is equipped with      #
>     # and your CPU fan, so you may        #
>     # want to update this section.        #
>     #######################################
>
>     label fan1 "CPU fan"
>     set fan1_min 700
>
>     label fan2 "System fan 1"
>     set fan2_min 300
>
>     label fan3 "System fan 2"
>     set fan3_min 300
>
>     ignore fan4 # Remove the 'ignore' if fan is installed.
>     label fan4 "System fan 3"
>     set fan4_min 0    # Set to a valid value if fan is installed.
>
>     ignore fan5 # Not present on motherboard, listed here since the 
> chip supports it.
>     label fan5 "System fan 4"
>     set fan5_min 0
>
>     ######################################
>     # VOLTAGES                           #
>     # These figures are from estimations #
>     # based on values provided in BIOS.  #
>     # This means that some of them may   #
>     # be mixed up.                       #
>     ######################################
>
>     label in0 "Vcore"
>     set in0_min 0.05
>     set in0_max 1.025
>     compute in0 1.0*@,@/1.0
>
>     label in1 "+3.3V"
>     set in1_min 3.135   # according to ATX 12V PSU design guide
>     set in1_max 3.465   #
>     compute in1 1.635*@,@/1.635
>
>     label in2 "+12V"
>     set in2_min 11.40   # according to ATX 12V PSU design guide
>     set in2_max 12.60   #
>     compute in2 6.0*@,@/6.0
>
>     label in3 "+5V"
>     set in3_min 4.750   # according to ATX 12V PSU design guide
>     set in3_max 5.250   #
>     compute in3 2.5*@,@/2.5
>
>     label in4 "Vaxg"
>     set in4_min 0.80
>     set in4_max 1.00
>     compute in4 1.0*@,@/1.0
>
>     label in5 "Vrin"
>     set in5_min 1.65
>     set in5_max 1.85
>     compute in5 1.0*@,@/1.0
>
>     label in6 "Vdram"
>     set in6_min 1.45    # adjust these, 1.35 for LVDDR3
>     set in6_max 1.55    # 1.5V is recommended, 1.65 tops
>     compute in6 1.0*@,@/1.0
>
>     label in7 "3VSB"
>     set in7_min 3.14
>     set in7_max 3.47
>     compute in7 1.0*@,@/1.0
>
>     # CMOS Battery voltage.
>     label in8 "Vbat"
>     compute in8 1.0*@,@/1.0
>
>     ###############################
>     # Temperatures                #
>     ###############################
>     label temp1 "PCH temp"
>     set temp1_min 10
>     set temp1_max 60
>
>     # ignore temp2 # Not sure if this sensor actually exists.
>     # It's always reporting 25 degrees Celsius for me at the moment.
>     label temp2 "MB temp"
>     set temp2_min 0
>     set temp2_max 60
>
>     label temp3 "CPU temp"
>     set temp3_min 10
>     set temp3_max 85
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
