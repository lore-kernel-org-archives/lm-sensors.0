From: markusbauer@users.sourceforge.net (Markus Bauer)
Date: Mon, 22 Jan 2007 02:08:00 +0000
Subject: [lm-sensors] sensors.conf update for W83627EHF on MSI K9N Platinum
Message-Id: <45B41C80.2070001@users.sourceforge.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a MSI K9N Platinum mainboard with a W83627EHF chip.
I changed the sensors.conf configuration file to match my mainboard and
I want to share my results with you.


The specs provides a formula to calculate the -12V value. It produces a
reasonable result for the in5 input, which also seems to be connected.
So I added:

    label in5 "-12V"
    compute in5 (@+(20.48/242)-2.048)*24.2, (@-2.048)*(10/242)+2.048
    set in5_min   -12.0*1.05
    set in5_max   -12.0*0.95


The +5V value is calculated wrong for my board. There is no formula in
the specs, but I figured out from the value in the BIOS that for example
the input value 1.46 must be converted to 5.07.
A factor used in the specs is (R1 / 34). I calculated that R1 must be
exactly 84. So I changed:

    label in6 "+5V"
    compute in6 @*(1+(84/34)),  @/(1+(84/34))


On this board the CPU fan is connected to fan4:
   label fan4      "CPU Fan"


A full patch of my changes is attached.


Regards,
Markus


-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors.conf.diff
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070122/45da030f/attachment.pl 
