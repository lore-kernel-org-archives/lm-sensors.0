From: fhj-52@sbcglobal.net (Ric Johnson)
Date: Tue, 13 Jun 2006 19:16:11 +0000
Subject: [lm-sensors] Using lm_sensors for accessing SMSC EMC6W201
Message-Id: <20060613191611.80065.qmail@web81614.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

I need to monitor temperatures on my system in real time. ( big surprise,
huh?, :) )
The mobo is a Gigabyte(GBT) GA-2CEWH dual Opteron based system which includes
an ITE 8712F Super I/O as well as the SMSC EMC6W201 monitoring device.  
The SMSC is similar in function to the SMSC EMC6D* devices but that is pretty
much all -only "similar":  lm_sensors does not recognize the 6W201 and trying
to use the EMC6D* modules does not work. 

According to GBT the 8712F is strictly used for I/O and all monitoring is done
by the SMSC device.  I am not positive that is entirely true but it is mostly
so.  The installation of lm_sensors (SUSE 10.x) provides pretty wacky results
for everything except the 12VDC line and, possibly, one fan.  ...

I have read most of the 6W201 datasheet and found, I hope, all pertinent info
necessary to get the monitoring done. Of course, I do not know how to modify
lm_sensors to get that accomplished. After reading various man pages, I still
do not see a direct way to get it done.

Cutting to the chase, I first need to be able to WRITE a "START" bit(01h) to
bit 0 of register 40h on the $5000 SMBus(i.e., 0000 0001). That starts the
monitoring and fills the EMC6W201 registers with valuable info, and, according
to the datasheet, makes reading of the registers possible.  PRIOR to writing
the START bit the registers are not accessible and any value in them is not
good. ...

After that, I need to read the registers.  First the temps, then later
voltages and fan speeds; finally, control w/b most excellent to have(hey,
dreams _are_ good, :) ). 
THE readings needed most are in ($5000) SMBus registers(hex):

26, diode 1 temp reading,
27, diode 2 temp reading,
28, diode 3 temp reading,
29, diode 4 temp reading,
2A, diode 5 temp reading, and
2B, Ambient
-- All 6 are needed because which is for what is unknown... 
The value in those registers are signed, 8-bit, 2's compliment of the
temperature in centigrade ranging from -127*c to 127*c.  E.g., a few:
0*c = 0000 0000
1*c = 0000 0001
2*c = 0000 0010
3*c = 0000 0011
...
25*c = 0001 1001
... 
and so forth.

Of course I would like to read register 40h to make sure that it is something
I want lm_sensors to write a 01h to before actually doing that.  ...sometimes
datasheets and implementations are not the same.  GBT assured me that they
followed the SMSC rec's so it should be okay but I would like to proceed
cautiously.  I.e., the sensors-detect does find EEPROMs and I do not want to
write there.

I am not capable of providing an official driver but could possibly tweak and
test some already established code.  Curently, I am using openSUSE 10.1-x86_64
with kernel 2.6.16.13-4-smp.  
There is a huge hole in my experience and knowledge about reading and writing
binary/hex to devices on a mainboard.  That's probably obvious but I mention
it to emphasize that I know there are steps missing from what I described
above but unless someone takes the time to assist me, I won't know what they
are and could ruin my mobo. So, please, at least, warn me of the shark
infested waters before I go swimming, so to speak.

HOW can I modify lm_sensors to do those things?

If lm_sensors cannot be modified please let me know.  

Thanks, :)

Ric Johnson



