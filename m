From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Mon, 22 Aug 2005 19:55:50 +0000
Subject: [lm-sensors] Abit Uguru driver 0.9
Message-Id: <430A11D4.8000405@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Well I (believe I) am done. I've attached three files, the 2.6 kernel 
driver, a patch for current lm_sensors2 cvs which adds the nescesary 
userspace support and some documentation about the Uguru written by Olle 
Sandberg.

Please review and merge the userspace part in CVS (if review ok). Which 
steps should I take to get the kernel-part merged upstream (iow 
ultimatly merged into Linus' tree)?

Thanks & Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: abituguru.c
Type: application/octet
Size: 12840 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050822/05d66393/abituguru-0001.bin
-------------- next part --------------
uGuru driver
------------

First of all, what I know about uGuru is no fact based on any help, hints or
datasheet from Abit. The data I have got on uGuru have I assembled through
my weak knowledge in "backwards engineering".
And just for the record, you may have noticed uGuru isn't a chip developed by 
Abit, as they claim it to be. It's realy just an microprocessor (uC) created by
Winbond (W83L950D). And -no,  reading the manual for this specific uC or mailing 
Windbond for help won't give any usefull data about uGuru, as it is the program
inside the uC that is responding to calls.


#detection :
As what I know uGuru is always placed at and using the (ISA) I/O-ports 0xE0 and
0xE4, so we don't have to scan any port-range, just check what the two ports 
are holding for detection.
I will refer to 0xE0 as cmd-port(command-port) and 0xE4 as data-port
because I have seen abit refer to them with these names.
Anyway...

If data-port is holdning 0x00 or 0x08 and the cmd-port holds 0xAC uGuru is
detected. Why we have to check for two diffrent values at data-port, is because
after a reboot uGuru will hold 0x00 here, but if the driver is removed and 
later on attached again data-port will hold 0x08, as in ready-state (more to
come about this).


#uGuru read sensor :
The first thing to do is to select *registerbank to read from uGuru (I call
this registerbank, because when reading uGuru sensors, you first select a bank,
and then in the bank there is a specific register for each sensor).
The temp- and voltage-sensors are all in the same registerbank - 0x21. 
While fans are (of some unknown reason) placed at registerbank - 0x26.

uGuru will then respond by holdning 0x08 at data-port if it need more input, 
and this is always the case when reading sensors. The input uGuru want is the 
specific register address of the sensor to be read.

After input of the registeraddress at cmd-port, we'll have to wait until uGuru
holds 0x01 at data-port. 0x01 means that uGuru holds the actual data of the
register we requested to read at cmd-port. If uGuru still holds 0x01 at 
data-port after we have read the value, it does mean that there is more to
read in this register(but this is never the case when reading sensors, so dont
worry about it).
All of uGuru's sensors are in just one byte of data. After the sensors value
have been read, uGuru will hold 0x09 at data-port to tell that there is no more
data to be read here.
Thats about it... After this is done the uguru_ready() is called, to be
able to read uGuru again.


#uGuru ready :
This function is called to be able to read uGuru again. In this state uGuru
probably holds 0x09 at data-port, but we want it to hold 0x08 (to tell that
it's ready to be read again). 
To put it in ready-state, we first select registerbank 0x00 (same way as when
reading a sensor), and then wait for uGuru to tell us that there is nothing to
be read here (0x09). After this we ensure that cmd-port holds 0xAC, and if it 
does, uGuru is ready for another sensor to be read, and we are back in the
same state we were when detecting uGuru, execpt that data-port hold 0x08 
instead of 0x00.


#Temperature sensors :
3 sensors, all placed at registerbank 0x21.
temp 1: register 0x00
temp 2: register 0x01
temp 3: register 0x0F

The temp registers holds the actual temperature in degrees. (0-255C)

#Voltage sensors :
11 sensors, all placed at registerbank 0x21.
in1=r(0x03)*(3.49/255)
in2=r(0x04)*(3.49/255)
in3=r(0x0A)*(3.49/255)
in4=r(0x08)*(3.49/255)
in5=r(0x0E)*(3.49/255)
in6=r(0x02)*(3.49/255) 
in7=r(0x09)*(3.49/255)
in8=r(0x06)*(6.25/255)
in9=r(0x05)*(4.36/255)
in10=r(0x0B)*(6.25/255)
in11=r(0x0D)*(4.36/255)



#Fan sensors :
5 sensors, all placed at registerbank 0x26.
fan1=r(0x00)*(15300/255)
fan2=r(0x01)*(15300/255)
fan3=r(0x02)*(15300/255)
fan4=r(0x03)*(15300/255)
fan5=r(0x04)*(15300/255)




Olle Sandberg <ollebull@gmail.com> 
050525
-------------- next part --------------
A non-text attachment was scrubbed...
Name: userspace.patch
Type: text/x-patch
Size: 5648 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050822/05d66393/userspace-0001.bin
