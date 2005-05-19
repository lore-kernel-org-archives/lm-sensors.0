From: alexzhur@ukrpack.net (AleX Zhuravliov)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Thanks and my sensors.conf file
Message-Id: <1939959284.20020419124451@ukrpack.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Guys,


First  of  all  thank  you  for the lm package you are making. And I'm
sending  you  my  conf  file  just  for you to know. The whole file is
attached  and  in  the  letter I'll put just what was changed and some
comments.

The  Mobo is Soyo 7VCA based on Via Apollo Pro A (if I'm not mistaken)
with *686 chip.

------------- Beginning of sensors.conf -----------
# Johannes Drechsel-Burkhard <jdb@chello.at> notes that on his MSI K7T Pro,
# temp1 is the CPU temp and temp2 is the SYS temp.  
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
## The same with mine MoBo
    label temp1 "CPU Temp"
    label temp2 "SYS Temp"
    label temp3 "SBr Temp" # It shows some temperature (~24C) so it's in

    set  in0_min 1.3 # The CPU is Celeron and the voltage is 1.4, so I
    set in0_max 1.7  # put this boundaries

# Maybe these will be of some use to you
    set temp1_hyst 55
    set temp1_over 60
    set temp2_hyst 40
    set temp2_over 45
    set temp3_hyst 60
    set temp3_over 65

#  With these adjustments the figures are pretty close to what my BIOS
#  shows  but  since  it show only integers for temp, it's of not of a
# too big use.
# I adjusted the readings under Linux so that they would show the same
#  figures  as the MBprobe program under windows (98 SE with idle loop
# enabled. The prog's site is: http://web.bham.ac.uk/jst829/mbprobe/

    compute "2.0V" @/0.955  ,  @*0.955
    compute "2.5V" @/0.973  ,  @*0.973
    compute "3.3V" @/0.974  ,  @*0.974
    compute "5.0V" @/0.975  ,  @*0.975
    compute "12V" @/0.968  ,  @*0.968

    compute "temp1" @/1.034  ,  @*1.034
    compute "temp2" @/1.053  ,  @*1.053
------------- End of sensors.conf -------------

Hope it will do you some good.

-- 
Best regards,
AleX Zhuravliov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors.conf
Type: application/octet-stream
Size: 34248 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020419/f9cff2e7/sensors.obj
